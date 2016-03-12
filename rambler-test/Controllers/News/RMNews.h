//
//  News.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMNewsItem;
typedef void(^RMNewsDownloadCompletionHandler)(NSArray* news, NSError* error);

/// Aggregated news class
@interface RMNews : NSObject

-(void) obtainNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion;

@end
