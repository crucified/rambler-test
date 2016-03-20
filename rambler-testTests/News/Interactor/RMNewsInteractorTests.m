//
//  RMNewsInteractorTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <AFNetworking/AFNetworking.h>

#import "RMNewsInteractor.h"
#import "RMNewsInteractorOutput.h"
#import "RMNewsInteractor_Private.h"
#import "RMNewsControllerLenta.h"
#import "RMNewsControllerGazeta.h"


@interface RMNewsInteractorTests : XCTestCase

@property (nonatomic, strong) RMNewsInteractor *interactor;

@property (nonatomic, strong) id mockOutput;

@end

@implementation RMNewsInteractorTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.interactor = [[RMNewsInteractor alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RMNewsInteractorOutput));

    self.interactor.output = self.mockOutput;
}

- (void)tearDown {
    self.interactor = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов RMNewsInteractorInput

-(void) testObtainSuccessOutputSuccessCalled
{
    // given
    
    // when
    [self.interactor obtainNews];
    
    // then
    [[[self.mockOutput expect] andDo:^(NSInvocation *invocation){ XCTAssert(YES, @"test passed");}] newsObtained:[OCMArg any]];
    
}

-(void) testLentaCorruptedResponseLenaNewsNil
{
    //given
    id lentaControllerMock = OCMClassMock([RMNewsControllerLenta class]);
    OCMStub([lentaControllerMock downloadNewsWithCompletionHandler:([OCMArg invokeBlockWithArgs:@"", [NSNull null], nil])]).andReturn([NSOperation new]);
    self.interactor.lentaNewsController = lentaControllerMock;
    
    //when
    [self.interactor obtainNews];

    //then
    XCTAssert(self.interactor.lentaNews == nil);
}

-(void) testGazetaCorruptedResponseGazetaNewsNil
{
    //given
    id gazetaControllerMock = OCMClassMock([RMNewsControllerGazeta class]);
    OCMStub([gazetaControllerMock downloadNewsWithCompletionHandler:([OCMArg invokeBlockWithArgs:@"", [NSNull null], nil])]).andReturn([NSOperation new]);
    self.interactor.gazetaNewsController = gazetaControllerMock;
    
    //when
    [self.interactor obtainNews];
    
    XCTAssert(self.interactor.gazetaNews == nil);
}

-(void) testNoNewsOutputObtainFailedCalled
{
    //given
    id lentaControllerMock = OCMClassMock([RMNewsControllerLenta class]);
    OCMStub([lentaControllerMock downloadNewsWithCompletionHandler:([OCMArg invokeBlockWithArgs:@"", [NSNull null], nil])]).andReturn([NSOperation new]);
    self.interactor.lentaNewsController = lentaControllerMock;
    
    id gazetaControllerMock = OCMClassMock([RMNewsControllerGazeta class]);
    OCMStub([gazetaControllerMock downloadNewsWithCompletionHandler:([OCMArg invokeBlockWithArgs:@"", [NSNull null], nil])]).andReturn([NSOperation new]);
    self.interactor.gazetaNewsController = gazetaControllerMock;
    
    //when
    [self.interactor obtainNews];
    
    //then
    OCMExpect([self.mockOutput newsObtainFailed:[OCMArg isNotNil]]);
}

@end
