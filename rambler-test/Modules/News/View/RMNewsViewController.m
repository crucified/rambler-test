//
//  RMNewsViewController.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12/03/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "RMNewsViewController.h"
#import "RMNewsViewOutput.h"
#import "RMNewsTableViewCell.h"
#import "RMNewsItem.h"

static NSString* const RMNewsCellReuseID = @"newsCell";

@interface RMNewsViewController()

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSArray<RMNewsItem*>* newsItems;
@property (strong, nonatomic) NSIndexPath* selectedIndexPath;
@end


@implementation RMNewsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    [self configureTableView];
	[self.output didTriggerViewReadyEvent];
}

-(void) configureTableView
{
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Методы RMNewsViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}

-(void) showNews:(NSArray<RMNewsItem *> *)news
{
    self.newsItems = news;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:RMNewsCellReuseID];
    if (indexPath.row < self.newsItems.count) {
        RMNewsItem* news = self.newsItems[indexPath.row];
        [cell setNews:news];
    }
    return cell;
}

-(CGFloat) calculateCellHeightForNews:(RMNewsItem*)news
{
    UIFont* font = [UIFont systemFontOfSize:17.0];
    UILabel* label = [UILabel new];
    label.numberOfLines = 0;
    label.font = font;
    label.text = news.newsDescription;

    DLog(@"%@", NSStringFromCGRect(self.tableView.bounds));
    CGSize newSize = [label sizeThatFits:CGSizeMake(self.tableView.bounds.size.width, CGFLOAT_MAX)];
    
    return [RMNewsTableViewCell briefCellHeight] + newSize.height + 88.0f;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [RMNewsTableViewCell briefCellHeight];
    if (self.selectedIndexPath && (self.selectedIndexPath.row == indexPath.row)) {
        if (indexPath.row < self.newsItems.count) {
            RMNewsItem* news = self.newsItems[indexPath.row];
            cellHeight = [self calculateCellHeightForNews:news];
        }

    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMNewsTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.selectedIndexPath) {
        self.selectedIndexPath = indexPath;
        [cell expandView];
    }
    else {
        self.selectedIndexPath = nil;
        [cell collapseView];
    }
    [tableView beginUpdates];
    [tableView endUpdates];

}
@end
