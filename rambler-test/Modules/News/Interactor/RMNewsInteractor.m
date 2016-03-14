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
#import "RMGazetaXMLController.h"

@interface RMNewsInteractor()


@property (strong, nonatomic) RMLentaRSSController* lentaNewsController;
@property (strong, nonatomic) RMGazetaXMLController* gazetaNewsController;
@property (strong, nonatomic) NSArray<RMNewsItem*>* lentaNews;
@property (strong, nonatomic) NSArray<RMNewsItem*>* gazetaNews;

@end

@implementation RMNewsInteractor

-(instancetype) init
{
    self = [super init];
    if (self) {
        _lentaNewsController = [RMLentaRSSController new];
        _gazetaNewsController = [RMGazetaXMLController new];
    }
    return self;
}

#pragma mark - Методы RMNewsInteractorInput
-(void) obtainNews
{
    NSOperation* downloadLentaOp = [self.lentaNewsController downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            self.lentaNews = news;
        }
    }];

    NSOperation* downloadGazetaOp = [self.gazetaNewsController downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            self.gazetaNews = news;
        }
    }];
    
    NSOperation* finishOp = [NSBlockOperation blockOperationWithBlock:^{
        [self prepareNews];
    }];
    
    [finishOp addDependency:downloadLentaOp];
    [finishOp addDependency:downloadGazetaOp];
    
    [[NSOperationQueue mainQueue] addOperation:finishOp];
}

-(void) prepareNews
{
    NSArray* allNews = [self.lentaNews arrayByAddingObjectsFromArray:self.gazetaNews];
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
