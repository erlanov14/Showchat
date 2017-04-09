//
//  ChatStore.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatStoreDelegate <NSObject>

- (void)dataArrayChanged;
- (void)dataDownloaded;
- (void)dataDownloadError:(NSString*)error;

@end

@interface ChatStore : NSObject

@property (nonatomic,weak) id<ChatStoreDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *messagesArray;
@property BOOL hasMore;

- (instancetype)initWithSid:(NSString*)sid;

- (void)getNextMessages;
- (void)refreshData;
- (void)addMessage:(NSDictionary*)message;

@end
