//
//  RMRemoteXMLParseOperation_Private.h
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMRemoteXMLParseOperation.h"

@interface RMRemoteXMLParseOperation()

@property (strong, nonatomic) id<RMNetworkControllerInterface> loader;
@property (strong, nonatomic) id<RMNewsParserInterface> parser;

@property (assign, nonatomic) BOOL isRunning;
@property (copy, nonatomic) RMNewsDownloadCompletionHandler completion;
@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSDictionary* params;
@property (assign, nonatomic) RMParseSourceType sourceType;
@end
