//
//  ReachabilityManager.h
//  Aha
//
//  Created by Yerassyl on 21.08.16.
//  Copyright © 2016 acelight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSReachability.h"

@interface ReachabilityManager : NSObject

+ (instancetype)sharedInstance;

+ (BOOL)hasInternetConnection;

@end
