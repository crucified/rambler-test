//
//  RMNewsPresenter.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsPresenter.h"

#import "RMNewsViewInput.h"
#import "RMNewsInteractorInput.h"

@implementation RMNewsPresenter

#pragma mark - Методы RMNewsModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы RMNewsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    [self.interactor obtainNews];
}


#pragma mark - Методы RMNewsInteractorOutput
-(void) newsObtained:(NSArray<RMNewsItem *> *)news
{
    [self.view showNews:news];
}

-(void) newsObtainFailed:(NSError *)error
{
    [self.view showErrorWithTitle:@"Messages error" message:@"No news obtained"];
}



@end
