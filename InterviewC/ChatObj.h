//
//  ChatObj.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 07.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatObj : NSObject

- (instancetype)initWithJSON:(NSMutableDictionary *)json;
- (void)setJSON:(NSMutableDictionary *)json;

@property (nonatomic,strong) NSString *iD;
@property (nonatomic,strong) NSString *storyId;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *author;
@property BOOL isIncoming;
@property BOOL isImage;
@property BOOL isComment;
@property (nonatomic,strong) NSString *image;


@end
