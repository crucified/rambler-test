//
//  RMLentaParser.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsParser.h"
#import "RMNewsParser_Private.h"
#import "RMLentaParseOperation.h"
#import "RMGazetaParseOperation.h"

@implementation RMNewsParser

+(instancetype) sharedInstance
{
    static RMNewsParser* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [RMNewsParser new];
    });
    return instance;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        _parseQueue = [NSOperationQueue new];
        _parseQueue.qualityOfService = NSQualityOfServiceDefault;
    }
    return self;
}

-(void) parseNewsFromXMLParser:(NSXMLParser *)xmlParser
                    sourceType:(RMParseSourceType)sourceType
                    completion:(RMParseCompletion)completion
{
    if (![xmlParser isKindOfClass:[NSXMLParser class]]){
        return;
    }

    NSOperation* op = nil;
    switch (sourceType) {
        case RMParseSourceTypeLenta:{
            op = [RMLentaParseOperation operationWithParser:xmlParser completion:completion];
            break;
        }
        case RMParseSourceTypeGazeta:{
            op = [RMGazetaParseOperation operationWithParser:xmlParser completion:completion];
            break;
        }
        default:
            break;
    }

    if (op) {
        [op addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
        [self.parseQueue addOperation:op];
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isFinished"] && [object isKindOfClass:[RMParseOperationBase class]]) {
        RMParseOperationBase* op = (RMParseOperationBase*) object;
        if (op.isFinished && op.completion) {
            if (op.parseError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    op.completion(nil, op.parseError);
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    op.completion(op.parsedItems, nil);
                });
            
            }
        }
    }
}


@end

