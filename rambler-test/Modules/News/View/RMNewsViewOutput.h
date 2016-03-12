//
//  RMNewsViewOutput.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMNewsViewOutput <NSObject>

/**
 Метод сообщает презентеру о том, что view готова к работе
 */
-(void) didTriggerViewReadyEvent;

@end
