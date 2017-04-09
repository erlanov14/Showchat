//
//  StoriesTableViewHelper.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoriesTableViewHelper.h"
#import "LoadMoreCell.h"
#import "StoriesCell1.h"
#import "StoriesCell2.h"
#import "StoriesCell3.h"
#import "ReachabilityManager.h"
#import "Defs.h"

@interface StoriesTableViewHelper() <StoriesCell1Delegate,StoriesCell2Delegate,StoriesCell3Delegate>

@end

@implementation StoriesTableViewHelper {
    UITableView *_tableView;
    
    UIRefreshControl *refreshControl;
    UILabel *noMatchesLabel;
    
    StoriesStore *_storiesStore;
    NSString *filterDate;
}

- (instancetype)initWithTableView:(UITableView *)tableView storiesStore:(StoriesStore *)storiesStore {
    self = [super init];
    if ( self && tableView ) {
        _tableView = tableView;
        _storiesStore = storiesStore;
        _storiesStore.delegate = self;
        
        [self initTable];
    }
    return self;
}



- (void)initTable {
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBA(50, 50, 50, 1);
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)hideNoMatches {
    [noMatchesLabel removeFromSuperview];
}
- (void)showNoMatches {
    if(!noMatchesLabel) {
        noMatchesLabel = [[UILabel alloc] init];
        [noMatchesLabel setTextColor:[UIColor lightGrayColor]];
        [noMatchesLabel setText:NSLocalizedString(@"Refresh stories", nil)];
        [noMatchesLabel setFont:robotoFontRegular(15)];
        [noMatchesLabel sizeToFit];
    }
    noMatchesLabel.frame = CGRectMake((_tableView.bounds.size.width - noMatchesLabel.bounds.size.width) / 2.0f,
                                      30+(_tableView.rowHeight - noMatchesLabel.bounds.size.height) / 2.0f,
                                      noMatchesLabel.bounds.size.width,
                                      noMatchesLabel.bounds.size.height);
    [_tableView insertSubview:noMatchesLabel atIndex:0];
}


- (void)refreshData {
    if ( ![ReachabilityManager hasInternetConnection] ) {
        [[[UIAlertView alloc] initWithTitle:@"Нет доступа к интернету, подключитесь к Wi-Fi или 4G" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        [refreshControl endRefreshing];
        return;
    }
    
    [_storiesStore refreshData];
    
}
- (void)loadMore {
    if ( ![ReachabilityManager hasInternetConnection] ) {
        [[[UIAlertView alloc] initWithTitle:@"Нет доступа к интернету, подключитесь к Wi-Fi или 4G" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        [refreshControl endRefreshing];
        return;
    }
    
    [_storiesStore getNextStories];
}

- (void)showLoadMoreCell {
    [_tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView endUpdates];
}
- (void)hideLoadMoreCell {
    [_tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView endUpdates];
}

- (NSMutableArray *)getFilteredArray {
    NSMutableArray *arr = [NSMutableArray new];
    for(int i=0;i<_storiesStore.storiesArray.count;i++) {
//        NSDictionary *di = _storiesStore.storiesArray[i];
        [arr addObject:_storiesStore.storiesArray[i]];
    }
    return arr;
}
- (void)setFilter:(NSString *)filter {
    filterDate = filter;
    [_tableView reloadData];
}


- (NSMutableArray *)getArraForRow:(int)row {
    NSMutableArray *res = [NSMutableArray new];
    
    int offset = row/4;
//    offset = offset*4;
    offset = offset*10;
    if ( row%4 == 0 ) {
        [res addObject:_storiesStore.storiesArray[offset]];
        [res addObject:_storiesStore.storiesArray[offset+1]];
    }
    else if ( row%4 == 1 ) {
        [res addObject:_storiesStore.storiesArray[offset+2]];
        [res addObject:_storiesStore.storiesArray[offset+3]];
        [res addObject:_storiesStore.storiesArray[offset+4]];
    }
    else if ( row%4 == 2 ) {
        [res addObject:_storiesStore.storiesArray[offset+5]];
        [res addObject:_storiesStore.storiesArray[offset+6]];
        [res addObject:_storiesStore.storiesArray[offset+7]];
    }
    else if ( row%4 == 3 ) {
        [res addObject:_storiesStore.storiesArray[offset+8]];
        [res addObject:_storiesStore.storiesArray[offset+9]];
    }
    return  res;
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( [self getFilteredArray].count == 0 ) {
        [self showNoMatches];
    }
    else {
        [self hideNoMatches];
    }
    
    if ( section == 0 ) {
        if ( [self getFilteredArray].count == 0 ) return 0;
        int cnt = (int)[self getFilteredArray].count;
        if ( cnt%10 == 0 ) return (cnt/10)*4;
        return 1+(int)(cnt/10);
    }
    else {
        if ( _storiesStore.hasMore ) {
            return 1;
        }
        else {
            return 0;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == 0 ) {
        if ( indexPath.row%4==0 || indexPath.row%4==3 ) {
            return Scn_Height*0.4;
        }
        else {
            return Scn_Height*0.6;
        }
    }
    else {
        return 44;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == 0 ) {
        if ( indexPath.row%4==0 || indexPath.row%4==3 ) {
            static NSString *CellIdentifier = @"StoriesCell1";
            
            StoriesCell1 *cell = (StoriesCell1 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                [tableView registerNib:[UINib nibWithNibName:@"StoriesCell1" bundle:nil] forCellReuseIdentifier:@"StoriesCell1"];
                cell = (StoriesCell1 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            [cell initWithArray:[self getArraForRow:(int)indexPath.row]];
            
            return cell;
        }
        else if ( indexPath.row%4==1 ) {
            static NSString *CellIdentifier = @"StoriesCell2";
            
            StoriesCell2 *cell = (StoriesCell2 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                [tableView registerNib:[UINib nibWithNibName:@"StoriesCell2" bundle:nil] forCellReuseIdentifier:@"StoriesCell2"];
                cell = (StoriesCell2 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            [cell initWithArray:[self getArraForRow:(int)indexPath.row]];
            
            return cell;
        }
        else {
            static NSString *CellIdentifier = @"StoriesCell3";
            
            StoriesCell3 *cell = (StoriesCell3 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                [tableView registerNib:[UINib nibWithNibName:@"StoriesCell3" bundle:nil] forCellReuseIdentifier:@"StoriesCell3"];
                cell = (StoriesCell3 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            [cell initWithArray:[self getArraForRow:(int)indexPath.row]];
            
            return cell;
        }
        
    }
    else if ( indexPath.section == 1 ) {
        static NSString *CellIdentifier = @"LoadMoreCell";
        
        LoadMoreCell *cell = (LoadMoreCell *) [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"LoadMoreCell" bundle:nil] forCellReuseIdentifier:@"LoadMoreCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
        }
        [cell startAnimating];
        [self loadMore];
        return cell;
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ( [_delegate respondsToSelector:@selector(tableCellDidSelectedWithIndex:array:)] ) {
        if ( indexPath.section == 0 ) {
            [_delegate tableCellDidSelectedWithIndex:(int)indexPath.row array:[self getFilteredArray]];
        }
    }
}

#pragma mark - DialogsStoreDelegate
- (void)dataArrayChanged {
    [_tableView reloadData];
}
- (void)dataDownloaded {
    [refreshControl endRefreshing];
    [_tableView reloadData];
    if ( [_delegate respondsToSelector:@selector(dataDownloaded)] ) {
        [_delegate dataDownloaded];
    }
}
- (void)dataDownloadError:(NSString*)error {
    [refreshControl endRefreshing];
    if ( ![error isEqualToString:@""] ) {
        [[[UIAlertView alloc] initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    if ( [_delegate respondsToSelector:@selector(downloadError)] ) {
        [_delegate downloadError];
    }
}

#pragma mark - Cell Delegates
- (void)storySelected:(StoryObj *)story holderView:(UIView *)holderView image:(UIImage *)image {
    if ( [_delegate respondsToSelector:@selector(storySelected:holderView:image:)] ) {
        [_delegate storySelected:story holderView:holderView image:image];
    }
}

@end
