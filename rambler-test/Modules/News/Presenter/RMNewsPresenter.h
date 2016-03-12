//
//  RMNewsPresenter.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsViewOutput.h"
#import "RMNewsInteractorOutput.h"
#import "RMNewsModuleInput.h"

@protocol RMNewsViewInput;
@protocol RMNewsInteractorInput;
@protocol RMNewsRouterInput;

@interface RMNewsPresenter : NSObject <RMNewsModuleInput, RMNewsViewOutput, RMNewsInteractorOutput>

@property (nonatomic, weak) id<RMNewsViewInput> view;
@property (nonatomic, strong) id<RMNewsInteractorInput> interactor;
@property (nonatomic, strong) id<RMNewsRouterInput> router;

@end
