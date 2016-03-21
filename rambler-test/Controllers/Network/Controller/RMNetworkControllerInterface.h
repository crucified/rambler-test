//
//  RMNetworkControllerInterface.h
//  rambler-test
//
//  Created by Denis Kharitonov on 13.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#ifndef RMNetworkControllerInterface_h
#define RMNetworkControllerInterface_h
#import <Foundation/Foundation.h>

typedef void(^RMRequestCompletion)(NSXMLParser* responseObject, NSError* error);

@protocol RMNetworkControllerInterface <NSObject>

-(NSOperation*) performGETRequestWithPath:(NSString*)path params:(NSDictionary*)params completion:(RMRequestCompletion)completion;

@end

#endif /* RMNetworkControllerInterface_h */
