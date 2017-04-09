//
//  StoryObj.h
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 07.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryObj : NSObject

- (instancetype)initWithJSON:(NSMutableDictionary *)json;
- (void)setJSON:(NSMutableDictionary *)json;

@property (nonatomic,strong) NSString *iD;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *backgroundImage;
@property int watchCount;
@property (nonatomic,strong) NSString *subtitle;

@property (nonatomic,strong) NSMutableArray *messages;

@end
