//
//  RandomPlayerPresentAnimationController.m
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import "RandomPlayerPresentAnimationController.h"
#import "AnimationHelper.h"

@implementation RandomPlayerPresentAnimationController

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _originFrame = CGRectZero;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    // 2
    CGRect initialFrame = _originFrame;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    // 3
    UIView *snapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    snapshot.frame = initialFrame;
    snapshot.alpha = 1.0;
//    snapshot.layer.cornerRadius = initialFrame.size.height/2;
    snapshot.layer.masksToBounds = YES;
    
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshot];
    toVC.view.hidden = YES;
    

    [AnimationHelper perspectiveTransformForContainerView:containerView];
//    snapshot.layer.transform = [AnimationHelper yRotation:M_PI_2];
    
    
    
    
    // 1
    double duration =  [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        snapshot.frame = finalFrame;
        snapshot.alpha = 1.0;
    } completion:^(BOOL finished) {
        toVC.view.hidden = NO;
        fromVC.view.layer.transform = [AnimationHelper yRotation:0.0];
        [snapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
//    animation.fromValue = [NSNumber numberWithFloat:initialFrame.size.height/2];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];
//    animation.duration = duration;
//    [snapshot.layer setCornerRadius:0.0];
//    [snapshot.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [UIView commitAnimations];
}



@end
