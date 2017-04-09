//
//  StoriesCell1.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoriesCell1.h"
#import "UIImageView+WebCache.h"
#import "Defs.h"

@interface StoriesCell1 ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIView *grV1;
@property (weak, nonatomic) IBOutlet UIView *grV2;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *author1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *author2;

@end

@implementation StoriesCell1 {
    NSMutableArray *arr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self addGradients];
    [self addGRecognizers];
    
    _imgV1.clipsToBounds = YES;
    _imgV1.contentMode = UIViewContentModeScaleAspectFill;
    _imgV2.clipsToBounds = YES;
    _imgV2.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)addGRecognizers {
    UITapGestureRecognizer *t1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(t1Touched:)];
    [_grV1 addGestureRecognizer:t1];
    UITapGestureRecognizer *t2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(t2Touched:)];
    [_grV2 addGestureRecognizer:t2];
}
- (void)addGradients {
    [self addToView:_grV1 size:CGRectMake(0, 0, Scn_Width/2, Scn_Height*0.4)];
    [self addToView:_grV2 size:CGRectMake(0, 0, Scn_Width/2, Scn_Height*0.4)];
}
- (void)addToView:(UIView*)view size:(CGRect)size {
    view.backgroundColor = [UIColor clearColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = size;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)RGBA(0, 0, 0, 0.8).CGColor];
    
    [view.layer insertSublayer:gradient atIndex:0];
}
- (void)t1Touched:(UITapGestureRecognizer*)t1 {
    if ( [_delegate respondsToSelector:@selector(storySelected:holderView:image:)] ) {
        [_delegate storySelected:arr[0] holderView:_grV1 image:_imgV1.image];
    }
}
- (void)t2Touched:(UITapGestureRecognizer*)t2 {
    if ( [_delegate respondsToSelector:@selector(storySelected:holderView:image:)] ) {
        [_delegate storySelected:arr[1] holderView:_grV2 image:_imgV2.image];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithArray:(NSMutableArray *)array {
    arr = array;
    StoryObj *d1 = arr[0];
    _author1.text = d1.author;
    _title1.text = d1.name;
    [_imgV1 sd_setImageWithURL:[NSURL URLWithString:d1.backgroundImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    StoryObj *d2 = arr[1];
    _author2.text = d2.author;
    _title2.text = d2.name;
    [_imgV2 sd_setImageWithURL:[NSURL URLWithString:d2.backgroundImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
