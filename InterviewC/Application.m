//
//  Defs.h
//  Limerence
//
//  Created by Yerassyl on 05.02.16.
//  Copyright © 2017 yera. All rights reserved.
//

#import "Application.h"
#import "Defs.h"

#define LOGGEDINSTR @"Logged_IN_STRING"
#define LASTPURCHASETIME @"LAST_PURCHASE_TIME"
#define TNOTKEY @"t_NOT"
#define ANOTKEY @"a_NOT"

@implementation Application


+ (BOOL)hasLoggedIn {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [str([prefs objectForKey:LOGGEDINSTR]) intValue] == 11;
}
+ (void)setLoggenIn {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"11" forKey:LOGGEDINSTR];
    [prefs synchronize];
}
+ (void)setLoggedOut {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"0" forKey:LOGGEDINSTR];
    [prefs synchronize];
}




+ (void)setPurchaseTime {
    NSString *time = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:time forKey:LASTPURCHASETIME];
    [prefs synchronize];
}
+ (BOOL)getHavePurchased {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if( ![str([prefs objectForKey:LASTPURCHASETIME]) isEqual:@"(null)"] ) {
        int time = (int)[[NSDate date] timeIntervalSince1970];
        return (86400*30) >= time-[str([prefs objectForKey:LASTPURCHASETIME]) intValue];
    }
    return NO;
}

+ (void)setTNot:(NSString *)tNot aNot:(NSString *)aNot {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:tNot forKey:TNOTKEY];
    [prefs setObject:aNot forKey:ANOTKEY];
    [prefs synchronize];
}
+ (NSString *)getANot {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if( ![str([prefs objectForKey:ANOTKEY]) isEqual:@"(null)"] ) {
        return str([prefs objectForKey:ANOTKEY]);
    }
    return @"1";
}
+ (NSString *)getTNot {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if( ![str([prefs objectForKey:TNOTKEY]) isEqual:@"(null)"] ) {
        return str([prefs objectForKey:TNOTKEY]);
    }
    return @"1";
}

+ (UIViewController*)topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController && ![topController.presentedViewController isKindOfClass:[UIAlertController class]]) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

+ (NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}



@end
