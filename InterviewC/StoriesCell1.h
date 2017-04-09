//
//  StoriesCell1.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryObj.h"

@protocol StoriesCell1Delegate <NSObject>

- (void)storySelected:(StoryObj*)story holderView:(UIView*)holderView image:(UIImage*)image;

@end

@interface StoriesCell1 : UITableViewCell
@property (nonatomic,weak) id<StoriesCell1Delegate> delegate;

- (void)initWithArray:(NSMutableArray*)array;

@end
