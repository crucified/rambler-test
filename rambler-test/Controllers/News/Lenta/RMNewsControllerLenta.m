//
//  ;
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsControllerLenta.h"

static NSString* const RMLentaNewsPath = @"http://lenta.ru/rss";


@implementation RMNewsControllerLenta

-(NSOperation*) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion
{
    return [self downloadNewsWithPath:RMLentaNewsPath sourceType:RMParseSourceTypeLenta completionHandler:completion];
}

@end
