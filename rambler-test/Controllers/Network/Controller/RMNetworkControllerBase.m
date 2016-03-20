//
//  RMNetworkManager.m
//  rambler-test
//
//  Created by Denis Kharitonov on 09.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNetworkControllerBase.h"
#import "NSError+CustomErrors.h"
#import "RMNetworkControllerBase_Private.h"

@implementation RMNetworkControllerBase

-(instancetype) init
{
    self = [super init];
    if (self) {
        
        _HTTPmanager = [AFHTTPRequestOperationManager manager];
        AFXMLParserResponseSerializer* responseSerializer = [AFXMLParserResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/rss+xml", nil];
        _HTTPmanager.responseSerializer = responseSerializer;
    }
    return self;
}


-(NSOperation*) performGETRequestWithPath:(NSString *)path params:(NSDictionary *)params completion:(RMRequestCompletion)completion
{
    
    self.currentOperation = [self.HTTPmanager GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSXMLParser class]]) {
            if (completion) {
                completion(responseObject, nil);
            }
        }
        else {
            if (completion){
                completion(nil, [NSError badServerResponseError]);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (!operation.cancelled) {
            if (![error isKindOfClass:[NSError class]]) {
                error = [NSError badServerResponseError];
            }
            
            if (completion){
                completion(nil, error);
            }
        }
    }];
    return self.currentOperation;
}




@end
