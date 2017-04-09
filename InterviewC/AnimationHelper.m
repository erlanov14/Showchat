//
//  AnimationHelper.m
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import "AnimationHelper.h"

@implementation AnimationHelper

+(CATransform3D)yRotation:(double)angle {
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}
+ (void)perspectiveTransformForContainerView:(UIView *)containerView {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
}



@end
