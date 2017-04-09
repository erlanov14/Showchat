//
//  MessageInCell.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "MessageInCell.h"

@interface MessageInCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;

@end

@implementation MessageInCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bubbleView.layer.cornerRadius = 6;
    
    _textLbl.text = @"self.selectionStyle = UITableViewCellSelectionStyleNone; _bubbleView.layer.cornerRadius = 6; self.selectionStyle = UITableViewCellSelectionStyleNone; _bubbleView.layer.cornerRadius = 6;";
}

- (void)initWithChatObj:(ChatObj *)chatObj {
    _textLbl.text = chatObj.text;
    _nameLbl.text = chatObj.author;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
