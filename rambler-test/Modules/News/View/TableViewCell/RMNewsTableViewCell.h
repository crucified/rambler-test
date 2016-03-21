//
//  RMNewsTableViewCell.h
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMNewsItem;
@interface RMNewsTableViewCell : UITableViewCell

@property (readonly, nonatomic) CGFloat height;

+(CGFloat) briefCellHeight;
-(void) setNews:(RMNewsItem*)news;
-(void) expandView;
-(void) collapseView;

@end
