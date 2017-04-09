//
//  CommentCell.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 09.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConst;

@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithChatObj:(ChatObj *)chatObj {
    if ( chatObj.isIncoming ) {
        [_commentLbl setTextAlignment:NSTextAlignmentLeft];
    }
    else {
        [_commentLbl setTextAlignment:NSTextAlignmentRight];
    }
    _commentLbl.text = chatObj.text;
}

@end
