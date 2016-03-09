//
//  RMNetworkManager.m
//  rambler-test
//
//  Created by Denis Kharitonov on 09.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface RMNetworkManager()

@property (weak, nonatomic) AFHTTPRequestOperationManager* HTTPmanager;

@end


@implementation RMNetworkManager

-(instancetype) init
{
    self = [super init];
    if (self) {
        _HTTPmanager = [AFHTTPRequestOperationManager manager];
        _HTTPmanager.responseSerializer = [AFXMLParserResponseSerializer new];
    }
    return self;
}

-(NSOperation*) performGETRequestWithPath:(NSString *)path params:(NSDictionary *)params completion:(RMRequestCompletion)completion
{
    return [self.HTTPmanager GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (completion){
            completion(nil, error);
        }
    }];
}
@end
