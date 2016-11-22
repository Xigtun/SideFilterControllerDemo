//
//  PresentAnimater.m
//
//
//  Created by cysu on 6/6/16.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "PresentAnimator.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    // 对fromVC.view的截图添加动画效果
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;

    // 遮罩层
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    filterView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];

    filterView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
//    [filterView addGestureRecognizer:tapp];
//    [filterView.window addGestureRecognizer:tapp];
    [tempView addSubview:filterView];

    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;

    // 要实现转场，必须加入到containerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth-64, kScreenHeight);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = toVC.view.frame;
        frame.origin.x = 64;
        toVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


- (void)closeView
{

}

@end

@implementation DismissAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    // 取出present时的截图用于动画
    UIView *tempView = containerView.subviews.lastObject;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = fromVC.view.frame;
        frame.origin.x = kScreenWidth;
        fromVC.view.frame = frame;
//        fromVC.view.x = kScreenWidth;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;

            // 将截图去掉
            [tempView removeFromSuperview];
        }
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
