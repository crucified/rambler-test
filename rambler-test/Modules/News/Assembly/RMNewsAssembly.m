//
//  RMNewsAssembly.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsAssembly.h"

#import "RMNewsViewController.h"
#import "RMNewsInteractor.h"
#import "RMNewsPresenter.h"
#import "RMNewsRouter.h"

@implementation RMNewsAssembly


+(UIViewController*) configureNewsModule
{
    RMNewsViewController* newsVC = (RMNewsViewController*)[self instantiateNewsViewController];
    RMNewsPresenter* newsPresenter = [RMNewsPresenter new];
    RMNewsInteractor* newsInteractor = [RMNewsInteractor new];
    RMNewsRouter* newsRouter = [RMNewsRouter new];
    
    newsVC.output = newsPresenter;

    newsPresenter.router = newsRouter;
    newsPresenter.view = newsVC;
    newsPresenter.interactor = newsInteractor;
    
    newsInteractor.output = newsPresenter;
    
    return newsVC;
    
}

+(UIViewController*) instantiateNewsViewController
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RMNewsViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    return vc;
}


@end
