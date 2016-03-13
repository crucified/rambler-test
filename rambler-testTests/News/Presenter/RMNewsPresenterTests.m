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

@interface RMNewsPresenterTests : XCTestCase

@property (nonatomic, strong) RMNewsPresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockView;

@end

@implementation RMNewsPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[RMNewsPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(RMNewsInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(RMNewsRouterInput));
    self.mockView = OCMProtocolMock(@protocol(RMNewsViewInput));

    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.view = self.mockView;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockRouter = nil;
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

#pragma mark - Тестирование методов RMNewsInteractorOutput

@end
