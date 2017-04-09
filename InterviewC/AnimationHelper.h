//
//  AnimationHelper.h
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationHelper : NSObject

+ (CATransform3D)yRotation:(double)angle;
+ (void)perspectiveTransformForContainerView:(UIView*)containerView;


@end
