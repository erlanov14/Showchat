//
//  StoriesStore.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoriesStore.h"
#import "StoriesService.h"
#import "Defs.h"

@implementation StoriesStore {
    StoriesService *storiesService;
    int page;
    BOOL isBusy;
}

- (instancetype)init {
    if ( self = [super init] ) {
        _hasMore = YES;
    }
    return self;
}


- (void)refreshData {
    page = 0;
    _hasMore = YES;
    [self getNextStories];
}
- (void)getNextStories {
    if(isBusy) return;
    if(!storiesService) storiesService = [StoriesService new];
    
    isBusy = YES;
    [storiesService getStoriesForPage:strFormat(@"%d", page) completion:^(BOOL success, NSMutableArray *stories, NSString *error) {
        isBusy = NO;
        if ( success ) {
            page++;
            if ( stories.count == 10 )  {
                _hasMore = YES;
            }
            else {
                _hasMore = NO;
            }
            if ( page == 1 ) {
                _storiesArray = [NSMutableArray arrayWithArray:stories];
            }
            else {
                [_storiesArray addObjectsFromArray:stories];
            }
            
            if ( [_delegate respondsToSelector:@selector(dataDownloaded)] ) {
                [_delegate dataDownloaded];
            }
        }
        else {
            _hasMore = NO;
            if ( [_delegate respondsToSelector:@selector(dataDownloadError:)] ) {
                [_delegate dataDownloadError:error];
            }
        }
    }];
}

@end
