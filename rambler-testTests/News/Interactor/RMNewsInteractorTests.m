//
//  RMNewsInteractorTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RMNewsInteractor.h"

#import "RMNewsInteractorOutput.h"

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

@end
