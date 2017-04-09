//
//  RandomPlayerDismissAnimationController.m
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import "RandomPlayerDismissAnimationController.h"
#import "AnimationHelper.h"

@implementation RandomPlayerDismissAnimationController

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _destinationFrame = CGRectZero;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.45;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    
    // 1
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectMake(toVC.view.frame.size.width, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);//_destinationFrame;
    
    // 2
    UIView *snapshot = [fromVC.view snapshotViewAfterScreenUpdates:false];
    snapshot.frame = initialFrame;
    snapshot.layer.masksToBounds = YES;
    
    // 3
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshot];
    fromVC.view.hidden = YES;
    toVC.view.frame = CGRectMake(-100, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
    
    double duration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:duration animations:^{
        // 1
        toVC.view.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
        snapshot.frame = finalFrame;
//        snapshot.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        // 2
        fromVC.view.hidden = NO;
        [snapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
//    animation.fromValue = [NSNumber numberWithFloat:0.0f];
//    animation.toValue = [NSNumber numberWithFloat:finalFrame.size.height/2];
//    animation.duration = duration;
//    [snapshot.layer setCornerRadius:finalFrame.size.height/2];
//    [snapshot.layer addAnimation:animation forKey:@"cornerRadius"];
    
    
    [UIView commitAnimations];
}


@end
