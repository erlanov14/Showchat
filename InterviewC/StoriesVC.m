//
//  StoriesVC.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoriesVC.h"
#import "StoriesStore.h"
#import "StoriesTableViewHelper.h"
#import "RandomPlayerTransitioningDelegate.h"
#import "ScrollVC.h"
#import "ChatVC.h"
#import "Defs.h"

@interface StoriesVC () <StoriesTableViewHelperDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;

@end

@implementation StoriesVC {
    StoriesStore *storiesStore;
    StoriesTableViewHelper *storiesTableViewHelper;
    RandomPlayerTransitioningDelegate *randomPlayerTransitioningDelegate;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    storiesStore = [StoriesStore new];
    storiesTableViewHelper = [[StoriesTableViewHelper alloc] initWithTableView:_tableView storiesStore:storiesStore];
    storiesTableViewHelper.delegate = self;
    self.view.backgroundColor = RGBA(80, 80, 80, 1);

    randomPlayerTransitioningDelegate = [RandomPlayerTransitioningDelegate new];
    [_activityView startAnimating];
    _reloadBtn.hidden = YES;
}

- (IBAction)reloadBtnTouched:(id)sender {
    _reloadBtn.hidden = YES;
    _activityView.hidden = NO;
    [storiesStore refreshData];
}



#pragma mark - StoriesTableViewHelper Delegate
- (void)tableCellDidSelectedWithIndex:(int)index array:(NSMutableArray *)array {
    
}
- (void)storySelected:(StoryObj *)story holderView:(UIView *)holderView image:(UIImage *)image {
    CGRect newR = [self.view convertRect:holderView.frame fromView:holderView];
//    NSLog(@"%f %f %f %f", newR.origin.x, newR.origin.y, newR.size.width, newR.size.height);
    randomPlayerTransitioningDelegate.originFrame = newR;
    
//    ChatVC *chatVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
//    chatVC.story = story;
//    chatVC.initialImage = image;
//    chatVC.transitioningDelegate = randomPlayerTransitioningDelegate;
//    [self presentViewController:chatVC animated:YES completion:nil];
    
    ScrollVC *scrollVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScrollVC"];
    scrollVC.story = story;
    scrollVC.initialImage = image;
    scrollVC.transitioningDelegate = randomPlayerTransitioningDelegate;
    [self presentViewController:scrollVC animated:YES completion:nil];
}
- (void)dataDownloaded {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _loadingView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_loadingView removeFromSuperview];
    }];
}
- (void)downloadError {
    _reloadBtn.hidden = NO;
    _activityView.hidden = YES;
}


@end
