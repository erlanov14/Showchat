//
//  ChatService.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FakeGenerator.h"

@interface ChatService : NSObject

@property FakeGenerator *fakeGenerator;

- (void)getMessagesWithID:(NSString*)sid page:(NSString*)page completion:(void (^)(BOOL success, NSMutableArray *messages, NSString *error))completionBlock;

- (void)getAllMessagesWithID:(NSString*)sid completion:(void (^)(BOOL success, NSMutableArray *messages, NSString *error))completionBlock;

- (void)increaseViewsCount:(NSString*)sid completion:(void (^)(BOOL success, NSString *error))completionBlock;

@end
