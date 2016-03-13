//
//  RMLentaParser.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNewsItem.h"

typedef void(^RMParseCompletion)(NSArray<RMNewsItem*>* items, NSError* error);

@interface RMLentaParser : NSObject

-(NSOperation*) parseNewsFromXMLParser:(NSXMLParser*)xmlParser completion:(RMParseCompletion)completion;

@end
