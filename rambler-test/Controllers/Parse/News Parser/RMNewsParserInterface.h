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
#import "RMParseOperationBase.h"

@protocol RMNewsParserInterface <NSObject>

-(void) parseNewsFromXMLParser:(NSXMLParser*)xmlParser
                    sourceType:(RMParseSourceType)sourceType
                    completion:(RMParseCompletion)completion;

@end

#endif /* RMNewsParserInterface_h */
