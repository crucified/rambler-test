//
//  RMLentaParseOperationTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMLentaParseOperation.h"
#import "RMLentaParseOperation_Private.h"
#import "RMGazetaParseOperation.h"
#import "RMGazetaParseOperation_Private.h"

@interface RMLentaGazetaParseOperationsTests : XCTestCase
@property (strong, nonatomic) RMLentaParseOperation* lentaParseOp;
@property (strong, nonatomic) RMGazetaParseOperation* gazetaParseOp;
@end

@implementation RMLentaGazetaParseOperationsTests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
}

- (void)tearDown {
    self.lentaParseOp = nil;
    [super tearDown];
}

- (void) testLentaNotAnXMLParserErrorCallbacked {

    //given
    self.lentaParseOp = [RMLentaParseOperation new];
    self.lentaParseOp.parser = [NSNull null];
    
    [self.lentaParseOp start];
    
    XCTAssert(self.lentaParseOp.isFinished);
    XCTAssert(self.lentaParseOp.parseError != nil);
}

- (void) testGazetaNotAnXMLParserErrorCallbacked {
    
    //given
    self.gazetaParseOp = [RMGazetaParseOperation new];
    self.gazetaParseOp.parser = [NSNull null];
    
    [self.gazetaParseOp start];
    
    XCTAssert(self.gazetaParseOp.isFinished);
    XCTAssert(self.gazetaParseOp.parseError != nil);
}

@end
