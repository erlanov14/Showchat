//
//  ReachabilityManager.m
//  Aha
//
//  Created by Yerassyl on 21.08.16.
//  Copyright © 2016 acelight. All rights reserved.
//

#import "ReachabilityManager.h"

@interface ReachabilityManager()

@property(strong,nonatomic) KSReachability* internetReachability;
@property BOOL hasInternet;

@end

@implementation ReachabilityManager


+ (instancetype)sharedInstance {
    static ReachabilityManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[[self class] alloc] init];
    });
    return sharedMyManager;
}
- (instancetype)init {
    self = [super init];
    if ( self ) {
        [self initReachability];
    }
    return self;
}
- (void)initReachability {
    // Create a new reachability object.
    _hasInternet = YES;
    self.internetReachability = [KSReachability reachabilityToInternet];
    self.internetReachability.onInitializationComplete = ^(KSReachability *reachability)
    {
        //    NSLog(@"Internet reachability initialization complete. Reachability = %d. Flags = %x", reachability.reachable, reachability.flags);
    };
    // Set a callback.
    self.internetReachability.onReachabilityChanged = ^(KSReachability* reachability)
    {
//        NSLog(@"Internet reachability changed to %d. Flags = %x (blocks)", reachability.reachable, reachability.flags);
        _hasInternet = reachability.reachable;
    };
}

+ (BOOL)hasInternetConnection {
    return [[self sharedInstance] hasInternet];
}

@end
