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
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBtnWidth;
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;

@end

@implementation ChatVC {
    ChatService *chatService;
    ChatStore *chatStore;
    ChatTableViewHelper *chatTableViewHelper;
    NSTimer *hideTimer;
    NSMutableArray *currentArray;
    int currentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _storyImageView.image = _initialImage;
    
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

    
    [self initBackBtn];
    [self hideBackBtn];
    
    [chatService increaseViewsCount:_story.iD completion:^(BOOL success, NSString *error) {
        
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _storyImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_storyImageView removeFromSuperview];
    }];
}

- (void)initBackBtn {
    _backBtn.layer.cornerRadius = 4;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, _backBtn.frame.size.height-14, _backBtn.frame.size.height-14)];
    imgV.image = [UIImage imageNamed:@"back"];
    [_backBtn addSubview:imgV];
    
    UILabel *backLbl = [[UILabel alloc] initWithFrame:CGRectMake(_backBtn.frame.size.height, 0, 0, _backBtn.frame.size.height)];
    backLbl.text = @"Back";
    backLbl.textColor = [UIColor whiteColor];
    [backLbl sizeToFit];
    backLbl.frame = CGRectMake(_backBtn.frame.size.height, 0, backLbl.frame.size.width, _backBtn.frame.size.height);
    [_backBtn addSubview:backLbl];
    _backBtnWidth.constant = backLbl.frame.size.width+backLbl.frame.origin.x+12;
//    [self.view layoutIfNeeded];
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


- (IBAction)backBtnTouched:(id)sender {
//    [chatTableViewHelper scrollToBottom];
//    return;
    if ( _backBtn.alpha == 1 ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _backBtn.alpha = 1;
        } completion:^(BOOL finished) {
            [self startHideTimer];
        }];
    }
}
- (void)startHideTimer {
    if ( hideTimer ) {
        [hideTimer invalidate];
        hideTimer = nil;
    }
    hideTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideBackBtn) userInfo:nil repeats:NO];
}
- (void)hideBackBtn {
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backBtn.alpha = 0.2;
    } completion:^(BOOL finished) {
        
    }];
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
