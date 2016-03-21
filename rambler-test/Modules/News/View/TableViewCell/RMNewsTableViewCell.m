//
//  RMNewsTableViewCell.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsTableViewCell.h"
#import "RMNewsItem.h"
#import "RMAsynchronousImageView.h"

static CGFloat const RMBriefCellHeight = 106;

@interface RMNewsTableViewCell()

@property (weak, nonatomic) IBOutlet RMAsynchronousImageView* newsImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel* sourceLabel;

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
    self.sourceLabel.text = @"";
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
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.newsDescription;
    [self.newsImageView setAsynchronousImageWithPath:news.imagePath];
    if (news.sourceType == RMParseSourceTypeLenta) {
        self.sourceLabel.text = @"Lenta.ru";
    }
    else if (news.sourceType == RMParseSourceTypeGazeta){
        self.sourceLabel.text = @"Gazeta.ru";
    }
    else {
        self.sourceLabel.text = @"";
   }
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
