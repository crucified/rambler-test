//
//  RMNewsInteractor.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsInteractor.h"
#import "RMNewsInteractorOutput.h"
#import "RMLentaRSSController.h"
#import "NSError+CustomErrors.h"

@interface RMNewsInteractor()

@property (strong, nonatomic) RMLentaRSSController* lentaNewsController;
@property (strong, nonatomic) NSArray<RMNewsItem*>* lentaNews;

@end

@implementation RMNewsInteractor

-(instancetype) init
{
    self = [super init];
    if (self) {
        _lentaNewsController = [RMLentaRSSController new];
    }
    return self;
}

#pragma mark - Методы RMNewsInteractorInput
-(void) obtainNews
{
    NSOperation* downloadOp = [self.lentaNewsController downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            DLog(@"1");
            self.lentaNews = news;
        }
    }];

    NSOperation* finishOp = [NSBlockOperation blockOperationWithBlock:^{
        DLog(@"2");
        [self prepareNews];
    }];
    
    [finishOp addDependency:downloadOp];
    
    [[NSOperationQueue mainQueue] addOperation:finishOp];
}

-(void) prepareNews
{
    NSArray* allNews = self.lentaNews;
    NSSortDescriptor* dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray* sortedNews = [allNews sortedArrayUsingDescriptors:@[dateSort]];
    if (sortedNews) {
        [self.output newsObtained:sortedNews];
    }
    else {
        [self.output newsObtainFailed:[NSError badServerResponseError]];
    }
    
}
@end
