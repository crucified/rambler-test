//
//  RMParseOperationCommonTypes.h
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#ifndef RMParseOperationCommonTypes_h
#define RMParseOperationCommonTypes_h

@class RMNewsItem;
typedef enum : NSUInteger {
    RMParseStateIdle,
    RMParseStateTitle,
    RMParseStateDescription,
    RMParseStateImagePath,
    RMParseStateDate
} RMParseState;

typedef void(^RMParseCompletion)(NSArray<RMNewsItem*>* items, NSError* error);

#endif /* RMParseOperationCommonTypes_h */
