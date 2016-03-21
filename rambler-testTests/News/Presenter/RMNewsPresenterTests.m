//
//  RMNewsPresenterTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RMNewsPresenter.h"

#import "RMNewsViewInput.h"
#import "RMNewsInteractorInput.h"
#import "RMNewsInteractor.h"

@interface RMNewsPresenterTests : XCTestCase

@property (nonatomic, strong) RMNewsPresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockView;

@end

@implementation RMNewsPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[RMNewsPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(RMNewsInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(RMNewsViewInput));

    self.presenter.interactor = self.mockInteractor;
    self.presenter.view = self.mockView;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockInteractor = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов RMNewsModuleInput

#pragma mark - Тестирование методов RMNewsViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given


    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView setupInitialState]);
}


-(void) testInteractorCallsNewsObtainedMethodWithNonNilArg
{
    //given
    __block BOOL exitFlag = NO;
    id presenterMock = OCMPartialMock(self.presenter);
    
    OCMStub([presenterMock newsObtained:OCMOCK_ANY]).andDo(^(NSInvocation* inv){exitFlag = YES;}).andForwardToRealObject;
    RMNewsInteractor* realInteractor = [RMNewsInteractor new];
    realInteractor.output = presenterMock;
    
    //when
    [realInteractor obtainNews];

    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:0];
    } while (!exitFlag);
    
    OCMVerify([presenterMock newsObtained:[OCMArg isNotNil]]);
    
}
#pragma mark - Тестирование методов RMNewsInteractorOutput

@end
