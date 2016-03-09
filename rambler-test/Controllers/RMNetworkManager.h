//
//  RMNetworkManager.h
//  rambler-test
//
//  Created by Denis Kharitonov on 09.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RMRequestCompletion)(NSDictionary* response, NSError* error);

@interface RMNetworkManager : NSObject

-(NSOperation*) performGETRequestWithPath:(NSString*)path params:(NSDictionary*)params completion:(RMRequestCompletion)completion;

@end
