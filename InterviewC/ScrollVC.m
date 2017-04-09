//
//  ScrollVC.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 09.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ScrollVC.h"
#import "PreloaderVC.h"
#import "ChatVC.h"
#import "Defs.h"

@interface ScrollVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBtnWidth;


@end

@implementation ScrollVC {
    NSTimer *hideTimer;
    ChatVC *chatVC;
    PreloaderVC *preloaderVC;
    UIImageView *storyImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initBackBtn];
    [self hideBackBtn];
    
    _scrollView.contentSize = CGSizeMake(Scn_Width, Scn_Height*2);
    
    [self addChatVC];
    [self addPreloaderVC];

    storyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Scn_Width, Scn_Height)];
    storyImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:storyImageView];
    storyImageView.image = _initialImage;
    [self initNots];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        storyImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [storyImageView removeFromSuperview];
    }];
}

- (void)initNots {
    [self removeNots];
    [self removeNots];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToBottom) name:@"ScrollToBottom" object:nil];
}
- (void)removeNots {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ScrollToBottom" object:nil];
}
- (void)scrollToBottom {
    [_scrollView scrollRectToVisible:CGRectMake(0, Scn_Height, Scn_Width, Scn_Height) animated:YES];
}


- (void)addChatVC {
    chatVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    chatVC.story = _story;
    chatVC.initialImage = _initialImage;
    [self addChildViewController:chatVC];
    
    UIView *chV = chatVC.view;
    chV.frame = CGRectMake(0, Scn_Height, Scn_Width, Scn_Height);
    [_scrollView addSubview:chV];
    
}
- (void)addPreloaderVC {
    preloaderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PreloaderVC"];
    preloaderVC.story = _story;
//    preloaderVC.initialImage = _initialImage;
    [self addChildViewController:preloaderVC];
    
    UIView *chV = preloaderVC.view;
    chV.frame = CGRectMake(0, 0, Scn_Width, Scn_Height);
    [_scrollView addSubview:chV];
    
}

- (void)initBackBtn {
    _backBtn.layer.cornerRadius = 4;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, _backBtn.frame.size.height-14, _backBtn.frame.size.height-14)];
    imgV.image = [UIImage imageNamed:@"back"];
    [_backBtn addSubview:imgV];
    
    UILabel *backLbl = [[UILabel alloc] initWithFrame:CGRectMake(_backBtn.frame.size.height, 0, 0, _backBtn.frame.size.height)];
    backLbl.text = @"Назад";
    backLbl.textColor = [UIColor whiteColor];
    [backLbl sizeToFit];
    backLbl.frame = CGRectMake(_backBtn.frame.size.height, 0, backLbl.frame.size.width, _backBtn.frame.size.height);
    [_backBtn addSubview:backLbl];
    _backBtnWidth.constant = backLbl.frame.size.width+backLbl.frame.origin.x+12;
}

- (IBAction)backBtnTouched:(id)sender {
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


@end
