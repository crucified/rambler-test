//
//  RMRemoteXMLParseOperation.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMRemoteXMLParseOperation.h"

@interface RMRemoteXMLParseOperation()

@property (strong, nonatomic) id<RMNetworkControllerInterface> loader;
@property (strong, nonatomic) id<RMNewsParserInterface> parser;

@property (assign, nonatomic) BOOL isRunning;
@property (copy, nonatomic) RMNewsDownloadCompletionHandler completion;
@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSDictionary* params;
@property (assign, nonatomic) RMParseSourceType sourceType;
@end

@implementation RMRemoteXMLParseOperation

+(instancetype) operationWithPath:(NSString *)path
                       parameters:(NSDictionary *)params
                           loader:(id<RMNetworkControllerInterface>)loader
                           parser:(id<RMNewsParserInterface>)parser
                       sourceType:(RMParseSourceType)parseSourceType
                       completion:(RMNewsDownloadCompletionHandler)completion
{
    RMRemoteXMLParseOperation* op = [RMRemoteXMLParseOperation new];
    op.path = [path copy];
    op.loader = loader;
    op.parser = parser;
    op.completion = [completion copy];
    op.sourceType = parseSourceType;
    return op;
}


-(void) dealloc
{
    
}
#pragma mark - NSOperation

-(void) start
{
    self.isRunning = YES;
    __weak typeof(self) weakSelf = self;
    [self.loader performGETRequestWithPath:self.path params:self.params completion:^(NSXMLParser *responseObject, NSError *error) {
        [weakSelf.parser parseNewsFromXMLParser:responseObject
                                     sourceType:self.sourceType
                                     completion:^(NSArray<RMNewsItem *> *items, NSError *error)
        {
            [weakSelf willChangeValueForKey:@"isFinished"];
            [weakSelf willChangeValueForKey:@"isExecuting"];
            if (weakSelf.completion) {
                weakSelf.completion(items, error);
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
    return self.isRunning;
}
@end
