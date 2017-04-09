//
//  ChatVC.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryObj.h"

@interface ChatVC : UIViewController

@property (nonatomic,strong) StoryObj *story;
@property (nonatomic,strong) UIImage *initialImage;

@end
