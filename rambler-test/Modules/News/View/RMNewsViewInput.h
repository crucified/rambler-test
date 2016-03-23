//
//  RMNewsViewInput.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMNewsItem;
@protocol RMNewsViewInput <NSObject>

/**
 Метод настраивает начальный стейт view
 */
-(void) setupInitialState;

-(void) showNews:(NSArray<RMNewsItem*>*) news;

-(void) showErrorWithTitle:(NSString*)title message:(NSString*)message;
@end
