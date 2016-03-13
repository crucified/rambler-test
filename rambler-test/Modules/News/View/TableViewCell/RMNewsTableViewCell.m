//
//  RMNewsTableViewCell.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsTableViewCell.h"
#import "RMNewsItem.h"

static CGFloat const RMBriefCellHeight = 106;

@interface RMNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView* newsImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;
@property (assign, nonatomic) BOOL isBrief;
@end


@implementation RMNewsTableViewCell

+(CGFloat) briefCellHeight
{
    return RMBriefCellHeight;
}

- (void)awakeFromNib {
    self.titleLabel.text = @"";
    self.descriptionLabel.text = @"";
    self.isBrief = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.descriptionLabel.hidden = NO;
}

-(void) setIsBrief:(BOOL)isBrief
{
    _isBrief = isBrief;
    self.descriptionLabel.hidden = isBrief;
}

-(void) setNews:(RMNewsItem*)news
{
    //TODO: add image async-ly
    
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.newsDescription;
}

-(void) expandView
{
    self.isBrief = NO;
}

-(void) collapseView
{
    self.isBrief = YES;
}

@end
