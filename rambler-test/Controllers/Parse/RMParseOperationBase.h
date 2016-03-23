//
//  RMParseOperationBase.h
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMParseOperationCommonTypes.h"

@interface RMParseOperationBase : NSOperation

@property (readonly, nonatomic) NSArray* parsedItems;
@property (readonly, nonatomic) NSError* parseError;
@property (copy, nonatomic) RMParseCompletion completion;
@property (assign, nonatomic) BOOL isRunning;

+(instancetype) operationWithParser:(NSXMLParser*)parser dateFormatter:(NSDateFormatter*)dateFormatter completion:(RMParseCompletion)completion;

@end
