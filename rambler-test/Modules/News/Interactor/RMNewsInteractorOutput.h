//
//  RMNewsInteractorOutput.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMNewsItem;
@protocol RMNewsInteractorOutput <NSObject>

-(void) newsObtained:(NSArray<RMNewsItem*>*) news;
-(void) newsObtainFailed:(NSError*) error;

@end
