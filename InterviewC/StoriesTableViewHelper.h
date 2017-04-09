//
//  StoriesTableViewHelper.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoriesStore.h"
#import "StoryObj.h"
#import <UIKit/UIKit.h>


@protocol StoriesTableViewHelperDelegate <NSObject>

- (void)tableCellDidSelectedWithIndex:(int)index array:(NSMutableArray*)array;
- (void)storySelected:(StoryObj*)story holderView:(UIView*)holderView image:(UIImage*)image;
- (void)dataDownloaded;

@end


@interface StoriesTableViewHelper : NSObject <UITableViewDataSource,UITableViewDelegate,StoriesStoreDelegate>

@property (nonatomic,weak) id <StoriesTableViewHelperDelegate> delegate;

- (instancetype)initWithTableView:(UITableView*)tableView storiesStore:(StoriesStore*)storiesStore;


@end
