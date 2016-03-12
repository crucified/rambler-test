//
//  RMLentaRSSController.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RMNewsDownloadCompletionHandler)(NSArray* news, NSError* error);

@interface RMLentaRSSController : NSObject

-(void) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion;
@end
