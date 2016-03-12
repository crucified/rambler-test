//
//  ViewController.m
//  rambler-test
//
//  Created by Denis Kharitonov on 09.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "ViewController.h"
#import "RMLentaRSSController.h"

@interface ViewController ()

@property (strong, nonatomic) RMLentaRSSController* lentaDownloader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lentaDownloader = [RMLentaRSSController new];
    [self.lentaDownloader downloadNewsWithCompletionHandler:^(id responseObject, NSError *NSError) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
