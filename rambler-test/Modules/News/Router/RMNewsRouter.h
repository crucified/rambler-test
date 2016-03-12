//
//  RMNewsRouter.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface RMNewsRouter : NSObject <RMNewsRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
