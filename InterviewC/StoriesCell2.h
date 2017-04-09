//
//  StoriesCell2.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryObj.h"

@protocol StoriesCell2Delegate <NSObject>

- (void)storySelected:(StoryObj*)story holderView:(UIView*)holderView image:(UIImage*)image;

@end

@interface StoriesCell2 : UITableViewCell
@property (nonatomic,weak) id<StoriesCell2Delegate> delegate;

- (void)initWithArray:(NSMutableArray*)array;

@end
