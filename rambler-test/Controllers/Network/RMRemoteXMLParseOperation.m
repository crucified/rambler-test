//
//  RMRemoteXMLParseOperation.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMRemoteXMLParseOperation.h"
#import "RMNetworkManager.h"


@interface RMRemoteXMLParseOperation()

@property (strong, nonatomic) RMNetworkManager* networkManager;
@property (strong, nonatomic) RMLentaParser* parser;

@property (assign, nonatomic) BOOL isRunning;
@property (copy, nonatomic) RMNewsDownloadCompletionHandler completion;
@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSDictionary* params;
@end

@implementation RMRemoteXMLParseOperation

+(instancetype) operationWithPath:(NSString *)path parameters:(NSDictionary *)params parser:(RMLentaParser *)parser completion:(RMNewsDownloadCompletionHandler)completion
{
    RMRemoteXMLParseOperation* op = [RMRemoteXMLParseOperation new];
    op.path = [path copy];
    op.parser = parser;
    op.completion = [completion copy];
    
    return op;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        _networkManager = [RMNetworkManager new];
    }
    return self;
}

#pragma mark - NSOperation

-(void) start
{
    self.isRunning = YES;
    __weak typeof(self) weakSelf = self;
    [self.networkManager performGETRequestWithPath:self.path params:self.params completion:^(NSXMLParser *responseObject, NSError *error) {
        [weakSelf.parser parseNewsFromXMLParser:responseObject completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
            [weakSelf willChangeValueForKey:@"isFinished"];
            [weakSelf willChangeValueForKey:@"isExecuting"];
            if (weakSelf.completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.completion(items, error);
                });
            }
            weakSelf.isRunning = NO;
            [weakSelf didChangeValueForKey:@"isFinished"];
            [weakSelf didChangeValueForKey:@"isExecuting"];
        }];
    }];
}

-(BOOL) isAsynchronous
{
    return YES;
}

-(BOOL) isFinished
{
    return !self.isRunning;
}

-(BOOL) isExecuting
{
    return self.isExecuting;
}
@end
