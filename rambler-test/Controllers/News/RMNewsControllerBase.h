//
//  RMNewsControllerBase.h
//  rambler-test
//
//  Created by Denis Kharitonov on 23.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNewsItem.h"
#import "RMNewsControllerInterface.h"

@interface RMNewsControllerBase : NSObject

-(NSOperation*) downloadNewsWithPath:(NSString*)path
                          sourceType:(RMParseSourceType)sourceType
                   completionHandler:(RMNewsDownloadCompletionHandler)completion;

@end
