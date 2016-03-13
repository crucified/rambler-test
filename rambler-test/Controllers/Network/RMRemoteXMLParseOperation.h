//
//  RMRemoteXMLParseOperation.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMLentaParser.h"

typedef void(^RMNewsDownloadCompletionHandler)(NSArray* news, NSError* error);

@interface RMRemoteXMLParseOperation : NSOperation

+(instancetype) operationWithPath:(NSString*)path parameters:(NSDictionary*)params parser:(RMLentaParser*)parser completion:(RMNewsDownloadCompletionHandler)completion;

@end
