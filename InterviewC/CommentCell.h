//
//  CommentCell.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 09.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatObj.h"

@interface CommentCell : UITableViewCell

- (void)initWithChatObj:(ChatObj*)chatObj;

@end
