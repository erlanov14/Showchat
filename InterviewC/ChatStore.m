//
//  ChatStore.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ChatStore.h"
#import "ChatService.h"
#import "Defs.h"

@implementation ChatStore {
    ChatService *chatService;
    int page;
    BOOL isBusy;
    NSString *sid;
}

- (instancetype)initWithSid:(NSString *)sid1 {
    if ( self = [super init] ) {
        _hasMore = YES;
        sid = sid1;
    }
    return self;
}


- (void)refreshData {
    page = 0;
    _hasMore = YES;
    [self getNextMessages];
}
- (void)getNextMessages {
    if(isBusy) return;
    if(!chatService) chatService = [ChatService new];
    
    
    isBusy = YES;
    [chatService getAllMessagesWithID:sid completion:^(BOOL success, NSMutableArray *messages, NSString *error) {
        isBusy = NO;
        if ( success ) {
            page++;
            if ( messages.count == 20 )  {
                _hasMore = YES;
            }
            else {
                _hasMore = NO;
            }
            if ( page == 1 ) {
                _messagesArray = [NSMutableArray arrayWithArray:messages];
            }
            else {
                [_messagesArray addObjectsFromArray:messages];
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

-(void)addMessage:(NSDictionary *)message {
    [_messagesArray addObject:message];
    if ( [_delegate respondsToSelector:@selector(dataArrayChanged)] ) {
        [_delegate dataArrayChanged];
    }
}


@end
