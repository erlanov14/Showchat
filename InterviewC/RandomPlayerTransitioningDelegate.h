//
//  RandomPlayerTransitioningDelegate.h
//  Blindime
//
//  Created by Yerassyl Yerlanov on 24.01.17.
//  Copyright © 2017 acelight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomPlayerTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property CGRect originFrame;
@property CGRect destinationFrame;

@end
