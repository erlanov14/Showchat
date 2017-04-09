//
//  Defs.h
//  Limerence
//
//  Created by Yerassyl on 05.02.16.
//  Copyright © 2017 yera. All rights reserved.
//

#ifndef Defs_h
#define Defs_h

#endif /* Defs_h */

#import "AppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ReachabilityManager.h"
//#import "WaitingView.h"


#define BASE_URL @"http://127.0.0.1:8003/"



#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define APPDelegate     (AppDelegate *)[[UIApplication sharedApplication] delegate]



// Screen size
#define Scn_Center      CGPointMake(Scn_Width/2,Scn_Height/2)
#define Scn_Width       [[UIScreen mainScreen] bounds].size.width
#define Scn_Height      [[UIScreen mainScreen] bounds].size.height





// Fonts
#define robotoFontRegular(a)    [UIFont fontWithName:@"Roboto-Regular" size:a]
#define robotoFontBold(a)       [UIFont fontWithName:@"Roboto-Bold" size:a]
#define robotoFontLight(a)      [UIFont fontWithName:@"Roboto-Light" size:a]
#define robotoFontThin(a)       [UIFont fontWithName:@"Roboto-Thin" size:a]




// String
#define str(a)                      [NSString stringWithFormat:@"%@",a]
#define strFormat(a,b)              [NSString stringWithFormat:a,b]
#define ZERO_OR_STRING(a)           (!a || [a isEqual:[NSNull null]]==YES)?@"0":str(a)
#define FREESTRING_OR_STRING(a)     (!a || [a isEqual:[NSNull null]]==YES)?@"":str(a)



// Threads
#define BG_THREAD dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
#define FG_THREAD dispatch_async(dispatch_get_main_queue(), ^



// iPhone versions
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



@interface Defs : NSObject

extern NSString * const mainURL;
extern NSString * const kSocketServerURLString;
extern NSString * const webSyncServerURL;
+ (NSString*)kServerErrorString;


@end

