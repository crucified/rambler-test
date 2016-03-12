//
//  RMNewsAssembly_Testable.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsAssembly.h"

@class RMNewsViewController;
@class RMNewsInteractor;
@class RMNewsPresenter;
@class RMNewsRouter;

@interface RMNewsAssembly ()

- (RMNewsViewController *)viewNewsModule;
- (RMNewsPresenter *)presenterNewsModule;
- (RMNewsInteractor *)interactorNewsModule;
- (RMNewsRouter *)routerNewsModule;

@end
