//
//  ;
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaRSSController.h"
#import "RMNetworkControllerBase.h"
#import "RMNewsParser.h"
#import "RMRemoteXMLParseOperation.h"

static NSString* const RMLentaNewsPath = @"http://lenta.ru/rss";

@interface RMLentaRSSController()

@property (weak, nonatomic) id<RMNewsParserInterface> parser;
@property (strong, nonatomic) id<RMNetworkControllerInterface> networkController;
@property (strong, nonatomic) NSOperationQueue* operationQueue;

@end

@implementation RMLentaRSSController

-(instancetype) init
{
    self = [super init];
    if (self) {
        _parser = [RMNewsParser sharedInstance];
        _networkController = [RMNetworkControllerBase new];
        _operationQueue = [NSOperationQueue new];
        _operationQueue.qualityOfService = NSQualityOfServiceDefault;
    }
    return self;
}

-(NSOperation*) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion
{    
    NSOperation* operation = [RMRemoteXMLParseOperation operationWithPath:RMLentaNewsPath
                                                               parameters:nil
                                                                   loader:self.networkController
                                                                   parser:self.parser
                                                               sourceType:RMParseSourceTypeLenta
                                                               completion:^(NSArray *news, NSError *error)
                              {
                                  if (error){
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
    
    return operation;
    
}


@end
