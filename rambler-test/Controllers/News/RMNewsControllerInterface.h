//
//  RMNewsControllerInterface.h
//  rambler-test
//
//  Created by Denis Kharitonov on 13.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#ifndef RMNewsControllerInterface_h
#define RMNewsControllerInterface_h

#import <Foundation/Foundation.h>

typedef void(^RMNewsDownloadCompletionHandler)(NSArray* news, NSError* error);

@protocol RMNewsControllerInterface <NSObject>

-(NSOperation*) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion;

@end

#endif /* RMNewsControllerInterface_h */
