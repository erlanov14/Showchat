//
//  ChatTableViewHelper.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ChatTableViewHelper.h"
#import "MessageInCell.h"
#import "MessageOutCell.h"
#import "ReachabilityManager.h"
#import "MessageInImgCell.h"
#import "MessageOutImgCell.h"
#import "ChatObj.h"
#import "Defs.h"

@interface ChatTableViewHelper()

@end

@implementation ChatTableViewHelper {
    UITableView *_tableView;
    
    UIRefreshControl *refreshControl;
    
    NSMutableArray *chatArray;
    
    BOOL _canAdd;
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if ( self && tableView ) {
        _tableView = tableView;
        
        [self initTable];
    }
    return self;
}

- (void)setChatArray:(NSMutableArray *)chatArray1 {
    chatArray = chatArray1;
    if (_tableView) [_tableView reloadData];
}

- (void)initTable {
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
//    [_tableView addSubview:refreshControl];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    
    _tableView.bounces = NO;
    
    _canAdd = YES;
    
    
    [_tableView setContentInset:UIEdgeInsetsMake(60, 0, 220, 0)]; // 185 is only example

    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 140;
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)refreshData {
    if ( ![ReachabilityManager hasInternetConnection] ) {
        [[[UIAlertView alloc] initWithTitle:@"No access to the Internet, connect to the internet" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        [refreshControl endRefreshing];
        return;
    }
    
//    [_chatStore refreshData];
    
}





#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return chatArray.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ( indexPath.section == 0 ) {
//        return 80;
//    }
//    else {
//        return 44;
//    }
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == 0 ) {
        ChatObj *chatO = chatArray[indexPath.row];
        if ( chatO.isIncoming ) {
            if ( !chatO.isImage ) {
                static NSString *CellIdentifier = @"MessageInCell";
                
                MessageInCell *cell = (MessageInCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    [tableView registerNib:[UINib nibWithNibName:@"MessageInCell" bundle:nil] forCellReuseIdentifier:@"MessageInCell"];
                    cell = (MessageInCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                }
                
                [cell initWithChatObj:chatO];
                
                return cell;
            }
            else {
                static NSString *CellIdentifier = @"MessageInImgCell";
                
                MessageInImgCell *cell = (MessageInImgCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    [tableView registerNib:[UINib nibWithNibName:@"MessageInImgCell" bundle:nil] forCellReuseIdentifier:@"MessageInImgCell"];
                    cell = (MessageInImgCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                }
                
                [cell initWithChatObj:chatO];
                
                return cell;
            }
        }
        else {
            if ( !chatO.isImage ) {
                static NSString *CellIdentifier = @"MessageOutCell";
                
                MessageOutCell *cell = (MessageOutCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    [tableView registerNib:[UINib nibWithNibName:@"MessageOutCell" bundle:nil] forCellReuseIdentifier:@"MessageOutCell"];
                    cell = (MessageOutCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                }
                
                [cell initWithChatObj:chatO];
                
                return cell;
            }
            else {
                
                static NSString *CellIdentifier = @"MessageOutImgCell";
                
                MessageOutImgCell *cell = (MessageOutImgCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    [tableView registerNib:[UINib nibWithNibName:@"MessageOutImgCell" bundle:nil] forCellReuseIdentifier:@"MessageOutImgCell"];
                    cell = (MessageOutImgCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                }
                
                [cell initWithChatObj:chatO];
                
                return cell;
            }
            
        }
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ( [_delegate respondsToSelector:@selector(tableCellDidSelectedWithIndex:array:)] ) {
        if ( indexPath.section == 0 ) {
            [_delegate tableCellDidSelectedWithIndex:(int)indexPath.row array:chatArray];
        }
    }
}
- (void)scrollToBottom {
    [_tableView setScrollEnabled:NO];
    _canAdd = NO;
    
//    float free = 205;//185;
    float res =  _tableView.contentSize.height-(Scn_Height-_tableView.contentInset.bottom);
    if ( res > 20 )
        [_tableView setContentOffset:CGPointMake(0,res) animated:YES];
}
- (void)add {
    FG_THREAD {
        [_tableView beginUpdates];
        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0]];
        [_tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        [self performSelector:@selector(setCanAdd) withObject:nil afterDelay:0.3];
    });
}
- (void)setCanAdd {
    [_tableView setScrollEnabled:YES];
    _canAdd = YES;
}
- (BOOL)canAdd {
    return _canAdd;
}


- (void)changeChatArray:(NSMutableArray *)chatArray1 {
    chatArray = chatArray1;
    
    [self scrollToBottom];
    [self performSelector:@selector(add) withObject:nil afterDelay:0.4];
//    [self add];
    
}

@end
