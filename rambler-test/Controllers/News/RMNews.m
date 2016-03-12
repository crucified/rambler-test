//
//  News.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNews.h"
#import "RMLentaRSSController.h"

@interface RMNews()

@property (strong, nonatomic) RMLentaRSSController* lentaDownloader;

@property (strong, nonatomic) NSArray<RMNewsItem*>* news;
@end

@implementation RMNews

-(instancetype) init{
    self = [super init];
    if (self) {
        _lentaDownloader = [RMLentaRSSController new];
    }
    return self;
}

-(void) obtainNewsWithCompletionHandler:(RMNewsDownloadCompletionHandler)completion;
{
    [self.lentaDownloader downloadNewsWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (!error) {
            NSSortDescriptor* dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSArray* sortedNews = [news sortedArrayUsingDescriptors:@[dateSort]];
            if (completion) {
                completion(sortedNews, nil);
            }
        }
    }];
}


@end
