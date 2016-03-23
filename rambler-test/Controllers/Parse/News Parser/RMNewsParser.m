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
#import "NSError+CustomErrors.h"

@implementation RMNewsParser

-(instancetype) init
{
    self = [super init];
    if (self) {
        _parseQueue = [NSOperationQueue new];
        _parseQueue.qualityOfService = NSQualityOfServiceDefault;
        NSDateFormatter* dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"EEE, dd MM yyyy HH:mm:SS ZZZ";
        _dateFormatter = dateFormatter; //можно разные dateFormatterы для каждого парсера, но так-то он один общий
    }
    return self;
}

-(void) parseNewsFromXMLParser:(NSXMLParser *)xmlParser
                    sourceType:(RMParseSourceType)sourceType
                    completion:(RMParseCompletion)completion
{
    if (![xmlParser isKindOfClass:[NSXMLParser class]]){
        if (completion) {
            completion(nil, [NSError badServerResponseError]);
        }
        return;
    }

    NSOperation* op = nil;
    switch (sourceType) {
        case RMParseSourceTypeLenta:{
            op = [RMLentaParseOperation operationWithParser:xmlParser dateFormatter:self.dateFormatter completion:completion];
            break;
        }
        case RMParseSourceTypeGazeta:{
            op = [RMGazetaParseOperation operationWithParser:xmlParser dateFormatter:self.dateFormatter completion:completion];
            break;
        }
        default:
            break;
    }

    if (op) {
        [op addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
        [self.parseQueue addOperation:op];
    }
    else {
        completion(nil, [NSError badServerResponseError]);
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isFinished"] && [object isKindOfClass:[RMParseOperationBase class]]) {
        [object removeObserver:self forKeyPath:@"isFinished"];
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

