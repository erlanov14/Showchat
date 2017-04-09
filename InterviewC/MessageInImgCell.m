//
//  MessageInImgCell.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 03.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "MessageInImgCell.h"
#import "UIImageView+WebCache.h"

@interface MessageInImgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;

@end

@implementation MessageInImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bubbleView.layer.cornerRadius = 6;
    _imgV.clipsToBounds = YES;
    _imgV.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)initWithChatObj:(ChatObj *)chatObj {
    [_imgV sd_setImageWithURL:[NSURL URLWithString:chatObj.image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _nameLbl.text = chatObj.author;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
