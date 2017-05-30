//
//  RMAsyncImageViewTests.m
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMAsynchronousImageView.h"
#import "OCMock.h"
#import "RMAsynchronousImageView_Private.h"

@interface RMAsyncImageViewTests : XCTestCase
@property (strong, nonatomic) RMAsynchronousImageView* imageView;
@end

@implementation RMAsyncImageViewTests

- (void)setUp {
    [super setUp];
    
    self.imageView = [RMAsynchronousImageView new];
    
    self.continueAfterFailure = NO;
}

- (void)tearDown {
    self.imageView = nil;
    
    [super tearDown];
}

- (void) testValidImagePath
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    NSString* validImagePath = @"https://pixabay.com/static/uploads/photo/2015/10/01/21/39/background-image-967820_960_720.jpg";
    
    id imageViewMock = OCMPartialMock(self.imageView);
    OCMStub([imageViewMock setImage:OCMOCK_ANY]).andForwardToRealObject().andDo(^(NSInvocation* inv){
        [inv invoke];
        XCTAssert(self.imageView.image != nil);
        XCTAssert(self.imageView.spinner.hidden);
        [expectation fulfill];
    });
    
    //when
    [self.imageView setAsynchronousImageWithPath:validImagePath];
    
    
    //then
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
    
}

-(void) testCorruptedImagePathNoSetImage
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription: @""];
    NSString* corruptedImagePath = @"https://pixabay.com/";
    
    id imageViewMock = OCMPartialMock(self.imageView);
    OCMStub([imageViewMock setImage:OCMOCK_ANY]).andDo(^(NSInvocation* inv){
        XCTAssert(self.imageView.image == nil);
        XCTAssert(self.imageView.spinner.hidden);
        [expectation fulfill];
    }).andForwardToRealObject;
    
    //when
    [self.imageView setAsynchronousImageWithPath:corruptedImagePath];
    
    [self waitForExpectationsWithTimeout:200 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"timeout");
        }
    }];
}

-(void) testNotAnUrlPathNoSetImage
{
    //given
    NSString* corruptedImagePath = @"some bad bad path";

    //when
    [self.imageView setAsynchronousImageWithPath:corruptedImagePath];
    
    //then
    XCTAssert(self.imageView.image == nil);
    XCTAssert(self.imageView.spinner.hidden);
    

}
@end
