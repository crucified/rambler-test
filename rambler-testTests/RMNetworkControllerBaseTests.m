//
//  RMNetworkControllerBaseTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 14.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking/AFNetworking.h>
#import "RMNetworkControllerBase.h"
#import "OCMock.h"
#import "RMNetworkControllerBase_Private.h"
#import "NSError+CustomErrors.h"

@interface RMNetworkControllerBaseTests : XCTestCase

@property (strong, nonatomic) RMNetworkControllerBase* netController;

@end

@implementation RMNetworkControllerBaseTests

- (void)setUp {
    [super setUp];
    self.netController = [RMNetworkControllerBase new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.netController = nil;
}

-(void) testGoodPathCalledErrorNil
{
    //given
    NSString* path = @"http://lenta.ru/rss";

    __block BOOL exitFlag = NO;

    //when
    [self.netController performGETRequestWithPath:path params:nil completion:^(NSXMLParser *responseObject, NSError *error) {
        XCTAssert(error == nil);
        XCTAssert([responseObject isKindOfClass:[NSXMLParser class]]);
        exitFlag = YES;
    }];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (!exitFlag);
    
    
}

-(void) testBadPathCalledFailCompletionTriggered
{
    //given
    NSString* badPath = @"http://ya.ru";
    

    __block BOOL exitFlag = NO;
    
    //when
    [self.netController performGETRequestWithPath:badPath params:nil completion:^(NSXMLParser *responseObject, NSError *error) {
        //then
        XCTAssert(error != nil);
        exitFlag = YES;
    }];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (!exitFlag);
}


-(void) testGetReturnNonXMLParserErrorCallbackCalled
{
    //given
    id managerMock = OCMClassMock([AFHTTPRequestOperationManager class]);

    OCMStub([managerMock GET:OCMOCK_ANY parameters:OCMOCK_ANY success:([OCMArg invokeBlockWithArgs:@"", [NSError new], nil]) failure:OCMOCK_ANY]);
    
    self.netController.HTTPmanager = managerMock;
    
    
    RMRequestCompletion completion = ^void(NSXMLParser* paser, NSError* error){
        //then
        XCTAssertNil(paser);
        XCTAssertNotNil(error);
    };
    
    //when
    [self.netController performGETRequestWithPath:@"somePath" params:nil completion:completion];
}

-(void) testErroCallbackReturnNullErrorCustomErrorInvoked
{
    //given
    id managerMock = OCMClassMock([AFHTTPRequestOperationManager class]);
    
    OCMStub([managerMock GET:OCMOCK_ANY parameters:OCMOCK_ANY success:OCMOCK_ANY failure:([OCMArg invokeBlockWithArgs:[NSNull null], [NSNull null], nil])]);
    
    self.netController.HTTPmanager = managerMock;
    
    
    NSError* badResponsError = [NSError badServerResponseError];
    
    RMRequestCompletion completion = ^void(NSXMLParser* paser, NSError* error){
        //then
        XCTAssertNil(paser);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, badResponsError.code);
        XCTAssertEqual(error.localizedDescription, badResponsError.localizedDescription);
    };
    
    //when
    [self.netController performGETRequestWithPath:@"somePath" params:nil completion:completion];

}

@end
