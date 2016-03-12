//
//  NSError+CustomErrors.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "NSError+CustomErrors.h"

@implementation NSError (CustomErrors)

+(instancetype) badServerResponseError
{
    return [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorCannotDecodeContentData userInfo:@{NSLocalizedDescriptionKey: @"Bad server response"}];
}


@end
