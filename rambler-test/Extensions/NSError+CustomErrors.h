//
//  NSError+CustomErrors.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (CustomErrors)

+(instancetype) badServerResponseError;
@end
