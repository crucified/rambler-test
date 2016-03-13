//
//  RMNewsParserInterface.h
//  rambler-test
//
//  Created by Denis Kharitonov on 13.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#ifndef RMNewsParserInterface_h
#define RMNewsParserInterface_h

#import "RMNewsItem.h"

typedef void(^RMParseCompletion)(NSArray<RMNewsItem*>* items, NSError* error);

typedef enum : NSUInteger {
    RMParseStateIdle,
    RMParseStateTitle,
    RMParseStateDescription,
    RMParseStateImagePath,
    RMParseStateDate
} RMParseState;

@protocol RMNewsParserInterface <NSObject>

-(NSOperation*) parseNewsFromXMLParser:(NSXMLParser*)xmlParser completion:(RMParseCompletion)completion;

@end

#endif /* RMNewsParserInterface_h */
