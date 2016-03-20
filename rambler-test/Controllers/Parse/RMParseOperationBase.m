//
//  RMParseOperationBase.m
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMParseOperationBase.h"

@implementation RMParseOperationBase

+(instancetype) operationWithParser:(NSXMLParser *)parser completion:(RMParseCompletion)completion
{
    return  nil;
}

-(BOOL) isExecuting
{
    return self.isRunning;
}

-(BOOL) isFinished
{
    return !self.isRunning;
}

@end
