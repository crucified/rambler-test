//
//  RMGazetaXMLController.m
//  rambler-test
//
//  Created by Denis Kharitonov on 13.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsControllerGazeta.h"

static NSString* const RMGazetaNewsPath = @"http://www.gazeta.ru/export/rss/lenta.xml";

@implementation RMNewsControllerGazeta

-(NSOperation*) downloadNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion
{
    return [self downloadNewsWithPath:RMGazetaNewsPath sourceType:RMParseSourceTypeGazeta completionHandler:completion];
}

@end
