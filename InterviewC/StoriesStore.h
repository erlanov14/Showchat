//
//  StoriesStore.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StoriesStoreDelegate <NSObject>

- (void)dataArrayChanged;
- (void)dataDownloaded;
- (void)dataDownloadError:(NSString*)error;

@end

@interface StoriesStore : NSObject

@property (nonatomic,weak) id<StoriesStoreDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *storiesArray;
@property BOOL hasMore;

- (instancetype)init;

- (void)getNextStories;
- (void)refreshData;


@end
