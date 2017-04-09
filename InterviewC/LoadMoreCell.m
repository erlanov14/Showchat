//
//  LoadMoreCell.m
//  CF
//
//  Created by Yerassyl Yerlanov on 30.01.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) startAnimating {
    [_activityIndicator startAnimating];
}


@end
