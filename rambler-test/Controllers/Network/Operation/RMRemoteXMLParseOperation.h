//
//  RMRemoteXMLParseOperation.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNewsParserInterface.h"
#import "RMNetworkControllerInterface.h"

typedef void(^RMNewsDownloadCompletionHandler)(NSArray* news, NSError* error);

@interface RMRemoteXMLParseOperation : NSOperation

+(instancetype) operationWithPath:(NSString*)path
                       parameters:(NSDictionary*)params
                           loader:(id<RMNetworkControllerInterface>)loader
                           parser:(id<RMNewsParserInterface>)parser
                       sourceType:(RMParseSourceType)parseSourceType
                       completion:(RMNewsDownloadCompletionHandler)completion;

@end
