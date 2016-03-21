//
//  RMNewsInteractor_Private.h
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsInteractor.h"
@class RMNewsControllerLenta;
@class RMNewsControllerGazeta;

@interface RMNewsInteractor()

@property (strong, nonatomic) RMNewsControllerLenta* lentaNewsController;
@property (strong, nonatomic) RMNewsControllerGazeta* gazetaNewsController;
@property (strong, nonatomic) NSArray<RMNewsItem*>* lentaNews;
@property (strong, nonatomic) NSArray<RMNewsItem*>* gazetaNews;

@end
