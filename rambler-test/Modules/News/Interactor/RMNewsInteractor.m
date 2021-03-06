//
//  RMNewsInteractor.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsInteractor.h"
#import "RMNewsInteractorOutput.h"
#import "RMNewsControllerLenta.h"
#import "NSError+CustomErrors.h"
#import "RMNewsControllerGazeta.h"
#import "RMNewsInteractor_Private.h"

@implementation RMNewsInteractor

-(instancetype) init
{
    self = [super init];
    if (self) {
        _lentaNewsController = [RMNewsControllerLenta new];
        _gazetaNewsController = [RMNewsControllerGazeta new];
    }
    return self;
}

#pragma mark - Методы RMNewsInteractorInput
-(void) obtainNews
{
    NSOperation* downloadLentaOp = [self.lentaNewsController downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            if ([news isKindOfClass:[NSArray class]]) {
                self.lentaNews = news;
            }
        }
    }];

    NSOperation* downloadGazetaOp = [self.gazetaNewsController downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            if ([news isKindOfClass:[NSArray class]]) {
                self.gazetaNews = news;
            }
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
    NSMutableArray *allNews = [NSMutableArray new];
    if ([self.lentaNews isKindOfClass:[NSArray class]]) {
        [allNews addObjectsFromArray:self.lentaNews];
    }
    
    if ([self.gazetaNews isKindOfClass:[NSArray class]]) {
        [allNews addObjectsFromArray:self.gazetaNews];
    }
    
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
