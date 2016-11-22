//
//  OCFilterController.m
//  SideFilterControllerDemo
//
//  Created by cysu on 22/11/2016.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "OCFilterController.h"

@interface OCFilterController ()

@property (nonatomic, strong) UIView *filterView;

@end

@implementation OCFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Filter";
    self.view.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.filterView];
    
    
}

- (void)leftItemAction
{
    [self.filterView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)filterView
{
    if (!_filterView) {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        _filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, screenHeight)];
        _filterView.backgroundColor = [UIColor clearColor];
        _filterView.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftItemAction)];
        [_filterView addGestureRecognizer:tap];
    }
    return _filterView;
}

@end
