//
//  MessageInCell.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatObj.h"

@interface MessageInCell : UITableViewCell

- (void)initWithChatObj:(ChatObj*)chatObj;

@end
