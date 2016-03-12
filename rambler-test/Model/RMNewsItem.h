//
//  NewsItem.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNewsItem : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* newsDescription;
@property (strong, nonatomic) NSString* imagePath;
@property (strong, nonatomic) NSDate* date;

@end
