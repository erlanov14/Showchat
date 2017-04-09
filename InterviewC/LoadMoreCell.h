//
//  LoadMoreCell.h
//  CF
//
//  Created by Yerassyl Yerlanov on 30.01.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (void) startAnimating;

@end
