//
//  Defs.h
//  Limerence
//
//  Created by Yerassyl on 05.02.16.
//  Copyright © 2017 yera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Application : NSObject

+ (BOOL)hasLoggedIn;

+ (void)setLoggenIn;
+ (void)setLoggedOut;

+ (void)setPurchaseTime;
+ (BOOL)getHavePurchased;

+ (void)setTNot:(NSString*)tNot aNot:(NSString*)aNot;
+ (NSString*)getANot;
+ (NSString*)getTNot;

+ (UIViewController*)topMostController;

+ (NSString*)generateRandomString:(int)num;

@end
