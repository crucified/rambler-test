//
//  RMRemoteXMLParseOperationTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMRemoteXMLParseOperation.h"
#import "RMRemoteXMLParseOperation_Private.h"
#import "OCMock.h"
#import "RMNetworkControllerBase.h"
#import "RMParseOperationBase.h"
#import "RMNewsParser.h"
#import "RMNewsParserInterface.h"

@interface RMRemoteXMLParseOperationTests : XCTestCase
@property (strong, nonatomic) RMRemoteXMLParseOperation* remoteParseOp;
@end

@implementation RMRemoteXMLParseOperationTests

- (void)setUp {
    [super setUp];
    self.remoteParseOp = [RMRemoteXMLParseOperation new];
    self.continueAfterFailure = NO;
}

- (void)tearDown {
    self.remoteParseOp = nil;
    
    [super tearDown];
}

- (void)testLoaderReturnNilResponseCompletionWErrorTriggered {

    id loader = OCMProtocolMock(@protocol(RMNetworkControllerInterface));
    OCMStub([loader performGETRequestWithPath:OCMOCK_ANY params:OCMOCK_ANY completion:([OCMArg invokeBlockWithArgs:[NSNull null], [NSNull null], nil])]);
    
    id parser = [RMNewsParser sharedInstance];
    
    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    self.remoteParseOp.loader = loader;
    self.remoteParseOp.parser = parser;
    self.remoteParseOp.completion = ^void(NSArray* news, NSError* error){
        XCTAssert(news == nil);
        XCTAssert(error != nil);
        [expectation fulfill];
    };
    
    [self.remoteParseOp start];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}

@end
