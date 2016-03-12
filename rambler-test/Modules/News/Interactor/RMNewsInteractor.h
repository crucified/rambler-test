//
//  RMNewsInteractor.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsInteractorInput.h"

@protocol RMNewsInteractorOutput;

@interface RMNewsInteractor : NSObject <RMNewsInteractorInput>

@property (nonatomic, weak) id<RMNewsInteractorOutput> output;

@end
