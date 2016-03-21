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
    __block BOOL exitFlag = NO;
    NSString* validImagePath = @"https://pixabay.com/static/uploads/photo/2015/10/01/21/39/background-image-967820_960_720.jpg";
    
    id imageViewMock = OCMPartialMock(self.imageView);
    OCMStub([imageViewMock setImage:OCMOCK_ANY]).andDo(^(NSInvocation* inv){exitFlag = YES;}).andForwardToRealObject;
    
    //when
    [self.imageView setAsynchronousImageWithPath:validImagePath];
    
    
    //then
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    } while (!exitFlag);
    
    XCTAssert(self.imageView.image != nil);
    XCTAssert(self.imageView.spinner.hidden);
}

-(void) testCorruptedImagePathNoSetImage
{
    //given
    __block BOOL exitFlag = NO;
    NSString* corruptedImagePath = @"https://pixabay.com/";
    
    id imageViewMock = OCMPartialMock(self.imageView);
    OCMStub([imageViewMock setImage:OCMOCK_ANY]).andDo(^(NSInvocation* inv){exitFlag = YES;}).andForwardToRealObject;
    
    //when
    [self.imageView setAsynchronousImageWithPath:corruptedImagePath];
    
    
    //then
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    } while (!exitFlag);
    
    XCTAssert(self.imageView.image == nil);
    XCTAssert(self.imageView.spinner.hidden);

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
