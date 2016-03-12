//
//  RMNewsRouterTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RMNewsRouter.h"

@interface RMNewsRouterTests : XCTestCase

@property (nonatomic, strong) RMNewsRouter *router;

@end

@implementation RMNewsRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[RMNewsRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end
