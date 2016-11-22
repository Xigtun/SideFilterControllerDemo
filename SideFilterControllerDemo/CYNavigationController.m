//
//
//  
//
//  Created by cysu on 6/6/16.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "CYNavigationController.h"
#import "PresentAnimator.h"

@interface CYNavigationController () <UIViewControllerTransitioningDelegate>

@end

@implementation CYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitioningDelegate = self;
    self.modalPresentationStyle =  UIModalPresentationCustom;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    PresentAnimator *persenter = [[PresentAnimator alloc] init];
    return persenter;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissAnimator alloc] init];
}

@end
