//
//  RMAsynchronousImageView.m
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMAsynchronousImageView.h"
#import "UIImageView+AFNetworking.h"
#import "RMAsynchronousImageView_Private.h"

@implementation RMAsynchronousImageView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

-(void) commonInit {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.hidesWhenStopped = YES;
    self.spinner = spinner;
    [self addSubview:self.spinner];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    self.spinner.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}

-(void) showSpinner
{
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
}

-(void) hideSpinner
{
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
}

-(void) setImage:(UIImage *)image
{
    [self hideSpinner];
    [super setImage:image];
}

-(void) setAsynchronousImageWithPath:(NSString*)imagePath
{
    if (![imagePath isKindOfClass:[NSString class]]) {
        return;
    }
    [self cancelImageRequestOperation];
    
    [self showSpinner];
    NSURL* url = [NSURL URLWithString:imagePath];
    if (url){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

        
        __weak typeof(self) weakSelf = self;
        [self setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            [weakSelf setImage:image];
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            if (error.code != NSURLErrorCancelled) {
                [weakSelf hideSpinner];
                [weakSelf setImage:nil];
            }
        }];
    }
    else {
        [self hideSpinner];
    }
}

@end
