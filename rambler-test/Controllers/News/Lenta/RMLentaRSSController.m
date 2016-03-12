//
//  ;
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaRSSController.h"
#import "RMNetworkManager.h"
#import "RMLentaParser.h"

static NSString* const RMLentaNewsPath = @"http://lenta.ru/rss";

@interface RMLentaRSSController()

@property (strong, nonatomic) RMNetworkManager* networkManager;
@property (strong, nonatomic) RMLentaParser* parser;

@end

@implementation RMLentaRSSController

-(instancetype) init
{
    self = [super init];
    if (self) {
        _networkManager = [RMNetworkManager new];
        _parser = [RMLentaParser new];
    }
    return self;
}

-(void) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion
{
    __weak typeof(self) weakSelf = self;
    [self.networkManager performGETRequestWithPath:RMLentaNewsPath params:nil completion:^(NSXMLParser *responseObject, NSError *error) {
        
        [weakSelf.parser parseNewsFromXMLParser:responseObject completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
            if (error){
                if (completion) {
                    completion(nil, error);
                }
            }
            else {
                if (completion) {
                    completion(items, error);
                }
            }
        }];
    }];
}


@end
