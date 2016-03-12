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
#import "RMNewsRouterInput.h"

@implementation RMNewsPresenter

#pragma mark - Методы RMNewsModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы RMNewsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы RMNewsInteractorOutput

@end
