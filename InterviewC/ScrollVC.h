//
//  ScrollVC.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 09.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryObj.h"

@interface ScrollVC : UIViewController

@property (nonatomic,strong) StoryObj *story;
@property (nonatomic,strong) UIImage *initialImage;

@end
