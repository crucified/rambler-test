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

    __block BOOL exitFlag = NO;
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(items);
        XCTAssertEqual(items.count, 2);
        exitFlag = YES;
    }];

    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (!exitFlag);
}

- (void)testJSONLentaResponseCompletionWithErrorTriggered {
    //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"someJSON" ofType:@"json"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    __block BOOL exitFlag = NO;
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNil(items);
        exitFlag = YES;
    }];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (!exitFlag);
}

- (void)testBadXMLLentaResponseCompletionWithErrorTriggered {
    //given
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"corruptedLentaResponse" ofType:@"xml"];
    NSString* validResponse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[validResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    __block BOOL exitFlag = NO;
    //when
    [self.parser parseNewsFromXMLParser:parser sourceType:RMParseSourceTypeLenta completion:^(NSArray<RMNewsItem *> *items, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNil(items);
        exitFlag = YES;
    }];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    } while (!exitFlag);
}

@end
