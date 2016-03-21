//
//  RMNewsViewControllerTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RMNewsViewController.h"

#import "RMNewsViewOutput.h"

@interface RMNewsViewControllerTests : XCTestCase

@property (nonatomic, strong) RMNewsViewController *controller;

@property (nonatomic, strong) id mockOutput;

@end

@implementation RMNewsViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[RMNewsViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(RMNewsViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

- (void)testThatControllerNotifiesPresenterOnDidLoad {
	// given

	// when
	[self.controller viewDidLoad];

	// then
	OCMVerify([self.mockOutput didTriggerViewReadyEvent]);
}

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов RMNewsViewInput

@end
