//
//  RMNewsControllerBase.m
//  rambler-test
//
//  Created by Denis Kharitonov on 23.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsControllerBase.h"
#import "RMNetworkControllerBase.h"
#import "RMNewsParser.h"
#import "RMRemoteXMLParseOperation.h"

@interface RMNewsControllerBase()

@property (strong, nonatomic) id<RMNewsParserInterface> parser;
@property (strong, nonatomic) id<RMNetworkControllerInterface> networkController;
@property (strong, nonatomic) NSOperationQueue* operationQueue;
@property (strong, nonatomic) NSOperation* currentOperation;

@end

@implementation RMNewsControllerBase
-(instancetype) init
{
    self = [super init];
    if (self) {
        _parser = [RMNewsParser new];
        _networkController = [RMNetworkControllerBase new];
        _operationQueue = [NSOperationQueue new];
        _operationQueue.qualityOfService = NSQualityOfServiceDefault;
    }
    return self;
}

-(NSOperation*) downloadNewsWithPath:(NSString*)path
                          sourceType:(RMParseSourceType)sourceType
                   completionHandler:(RMNewsDownloadCompletionHandler)completion
{
    [self.currentOperation cancel];
    
    NSOperation* operation = [RMRemoteXMLParseOperation operationWithPath:path
                                                               parameters:nil
                                                                   loader:self.networkController
                                                                   parser:self.parser
                                                               sourceType:sourceType
                                                               completion:^(NSArray *news, NSError *error)
                              {
                                  if (error && error.code != NSUserCancelledError){
                                      if (completion) {
                                          completion(nil, error);
                                      }
                                  }
                                  else {
                                      if (completion) {
                                          completion(news, error);
                                      }
                                  }
                              }];
    
    [self.operationQueue addOperation:operation];
    self.currentOperation = operation;
    return self.currentOperation;
    
}



@end
