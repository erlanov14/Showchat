//
//  ChatVC.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ChatVC.h"
#import "ChatStore.h"
#import "ChatTableViewHelper.h"
#import "ChatService.h"
#import "Defs.h"

@interface ChatVC () <ChatStoreDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatVC {
    ChatService *chatService;
    ChatStore *chatStore;
    ChatTableViewHelper *chatTableViewHelper;
    NSMutableArray *currentArray;
    int currentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    currentArray = [NSMutableArray new];
    if(_story.messages.count > 0) {
        [currentArray addObject:_story.messages[0]];
    }
    
    chatService = [ChatService new];
    chatStore = [[ChatStore alloc] initWithSid:_story.iD];
    chatStore.delegate = self;
    [chatStore refreshData];
    
    chatTableViewHelper = [[ChatTableViewHelper alloc] initWithTableView:_tableView];
    [chatTableViewHelper setChatArray:currentArray];
    UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tTouched)];
    [self.view addGestureRecognizer:t];

    
    
    [chatService increaseViewsCount:_story.iD completion:^(BOOL success, NSString *error) {
        
    }];
}



- (void)tTouched {
    if ([chatTableViewHelper canAdd]) {
        if ( currentIndex+1<_story.messages.count ) {
            currentIndex++;
            [currentArray addObject:_story.messages[currentIndex]];
            [chatTableViewHelper changeChatArray:currentArray];
        }
    }
}



#pragma mark - ChatsStoreDelegate
- (void)dataArrayChanged {
    
}
- (void)dataDownloaded {
    [_story.messages addObjectsFromArray:chatStore.messagesArray];
}
- (void)dataDownloadError:(NSString*)error {
    if ( ![error isEqualToString:@""] ) {
        [[[UIAlertView alloc] initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

@end
