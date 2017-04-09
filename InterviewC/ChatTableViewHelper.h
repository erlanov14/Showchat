//
//  ChatTableViewHelper.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol ChatTableViewHelperDelegate <NSObject>

- (void)tableCellDidSelectedWithIndex:(int)index array:(NSMutableArray*)array;

@end


@interface ChatTableViewHelper : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) id <ChatTableViewHelperDelegate> delegate;

- (instancetype)initWithTableView:(UITableView*)tableView;
- (void)setChatArray:(NSMutableArray*)chatArray;
- (void)changeChatArray:(NSMutableArray*)chatArray;

- (void)scrollToBottom;
- (BOOL)canAdd;

@end
