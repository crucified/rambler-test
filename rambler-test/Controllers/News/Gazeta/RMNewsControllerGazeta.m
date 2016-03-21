//
//  RMGazetaXMLController.m
//  rambler-test
//
//  Created by Denis Kharitonov on 13.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsControllerGazeta.h"
#import "RMRemoteXMLParseOperation.h"
#import "RMNetworkControllerBase.h"
#import "RMNewsParser.h"

static NSString* const RMGazetaNewsPath = @"http://www.gazeta.ru/export/rss/lenta.xml";

@interface RMNewsControllerGazeta()

@property (strong, nonatomic) id<RMNetworkControllerInterface> networkController;
@property (weak, nonatomic) id<RMNewsParserInterface> parser;
@property (strong, nonatomic) NSOperationQueue* operationQueue;

@end


@implementation RMNewsControllerGazeta

-(instancetype) init
{
    self = [super init];
    if (self) {
        _operationQueue = [NSOperationQueue new];
        _operationQueue.qualityOfService = NSQualityOfServiceDefault;
        _networkController = [RMNetworkControllerBase new];
        _parser = [RMNewsParser sharedInstance];
    }
    return self;
}

-(NSOperation*) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion
{
    NSOperation* operation = [RMRemoteXMLParseOperation operationWithPath:RMGazetaNewsPath
                                                               parameters:nil
                                                                   loader:self.networkController
                                                                   parser:_parser
                                                               sourceType:RMParseSourceTypeGazeta
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
