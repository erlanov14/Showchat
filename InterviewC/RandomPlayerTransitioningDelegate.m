//
//  RandomPlayerTransitioningDelegate.m
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import "RandomPlayerTransitioningDelegate.h"
#import "RandomPlayerPresentAnimationController.h"
#import "RandomPlayerDismissAnimationController.h"

@implementation RandomPlayerTransitioningDelegate {
    RandomPlayerPresentAnimationController *randomPlayerPresentAnimationController;
    RandomPlayerDismissAnimationController *randomPlayerDismissAnimationController;
}

- (instancetype)init {
    self = [super init];
    if ( self ) {
        randomPlayerPresentAnimationController = [RandomPlayerPresentAnimationController new];
        randomPlayerDismissAnimationController = [RandomPlayerDismissAnimationController new];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    randomPlayerPresentAnimationController.originFrame = _originFrame;
    return randomPlayerPresentAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    randomPlayerDismissAnimationController.destinationFrame = _originFrame;//CGRectMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2, 0, 0);
    return randomPlayerDismissAnimationController;
}

@end
