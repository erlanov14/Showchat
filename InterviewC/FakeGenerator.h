//
//  FakeGenerator.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 03.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeGenerator : NSObject

@property NSString *sid;

- (NSMutableArray*)getStories;
- (NSDictionary*)getFirstWithID:(NSString*)sid;
- (NSDictionary*)getNextWithID:(NSString*)sid;


@end
