//
//  StoriesService.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoriesService : NSObject

- (void)getStoriesForPage:(NSString*)page completion:(void (^)(BOOL success, NSMutableArray *stories, NSString *error))completionBlock;

@end
