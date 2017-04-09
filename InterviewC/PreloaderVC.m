//
//  PreloaderVC.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 09.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "PreloaderVC.h"
#import "UIImageView+WebCache.h"
#import "Defs.h"

@interface PreloaderVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorLbl;
@property (weak, nonatomic) IBOutlet UILabel *watchesLbl;
@property (weak, nonatomic) IBOutlet UIView *grView;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end

@implementation PreloaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initCustomViews];
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_story.backgroundImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _authorLbl.text = _story.author;
    _titleLbl.text = _story.name;
    _watchesLbl.text = [NSString stringWithFormat:@"%d",_story.watchCount];
    _subtitle.text = _story.subtitle;
    
    [self addToView:_grView size:CGRectMake(0, 0, Scn_Width, Scn_Height)];
}

- (void)addToView:(UIView*)view size:(CGRect)size {
    view.backgroundColor = [UIColor clearColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = size;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)RGBA(0, 0, 0, 0.8).CGColor];
    
    [view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)bottomBtnTouched:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollToBottom" object:nil];
}


- (void) initCustomViews {
    NSLog(@"initCustomViews");
}

@end
