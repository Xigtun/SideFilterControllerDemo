//
//  OCViewController.m
//  SideFilterControllerDemo
//
//  Created by cysu on 22/11/2016.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "OCViewController.h"
#import "CYNavigationController.h"
#import "OCFilterController.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"OC List";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemAction
{
    CYNavigationController *nav = [[CYNavigationController alloc] initWithRootViewController:[[OCFilterController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
