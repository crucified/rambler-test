//
//  LentaParserTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMNewsParser.h"
#import "RMNewsParser_Private.h"

@interface RMNewsParserTests : XCTestCase
@property (strong, nonatomic) RMNewsParser* parser;
@end

@implementation RMNewsParserTests

- (void)setUp {
    [super setUp];
    self.parser = [RMNewsParser new];
    self.continueAfterFailure = NO;
}

- (void)tearDown {
    self.parser = nil;
    [super tearDown];
}

- (void)testValidLentaResponse {
   //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validLentaResponse" ofType:@"xml"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];

    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(items);
        XCTAssertEqual(items.count, 2);
        RMNewsItem* firstItem = items.firstObject;
        XCTAssert(firstItem.title != nil);
        XCTAssert(firstItem.newsDescription != nil);
        XCTAssert(firstItem.date != nil);
        XCTAssert(firstItem.imagePath != nil);
        [expectation fulfill];
        
        
    }];

    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}

- (void)testValidGazetaResponse {
    //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validGazetaResponse" ofType:@"xml"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeGazeta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(items);
        XCTAssertEqual(items.count, 3);
        RMNewsItem* firstItem = items.firstObject;
        XCTAssert(firstItem.title != nil);
        XCTAssert(firstItem.newsDescription != nil);
        XCTAssert(firstItem.date != nil);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}


- (void)testJSONLentaResponseCompletionWithErrorTriggered {
    //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"someJSON" ofType:@"json"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNil(items);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}

- (void)testBadXMLLentaResponseCompletionWithErrorTriggered {
    //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"corruptedLentaResponse" ofType:@"xml"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNil(items);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}

-(void) testTwoOpAtOnceAllGood
{
    //given
    NSString* gazetaFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validGazetaResponse" ofType:@"xml"];
    NSString* validGazetaResponse = [NSString stringWithContentsOfFile:gazetaFilePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* gazetaParser = [[NSXMLParser alloc] initWithData:[validGazetaResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString* lentaFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validLentaResponse" ofType:@"xml"];
    NSString* validLentaResponse = [NSString stringWithContentsOfFile:lentaFilePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* lentaParser = [[NSXMLParser alloc] initWithData:[validLentaResponse dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    __block NSInteger opsCount = 0;
    //when
    [self.parser parseNewsFromXMLParser:gazetaParser sourceType:RMParseSourceTypeGazeta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(items);
        XCTAssertEqual(items.count, 3);
        @synchronized(self) {
            opsCount++;
        }
    }];
    
    [self.parser parseNewsFromXMLParser:lentaParser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(items);
        XCTAssertEqual(items.count, 2);
        @synchronized(self) {
            opsCount++;
        }
    }];
    
    
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (opsCount < 2);

}

-(void) testInvalidSourceTypeErrorCallbackCalled
{
    //given
    NSString* gazetaFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validGazetaResponse" ofType:@"xml"];
    NSString* validGazetaResponse = [NSString stringWithContentsOfFile:gazetaFilePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* gazetaParser = [[NSXMLParser alloc] initWithData:[validGazetaResponse dataUsingEncoding:NSUTF8StringEncoding]];

    //when
    NSInteger unknownSourceType = 100500;
    [self.parser parseNewsFromXMLParser:gazetaParser sourceType:unknownSourceType completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNil(items);
    }];

}
@end
