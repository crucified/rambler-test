//
//  RMNewsViewController.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMNewsViewInput.h"

@protocol RMNewsViewOutput;

@interface RMNewsViewController : UIViewController <RMNewsViewInput>

@property (nonatomic, strong) id<RMNewsViewOutput> output;

@end
