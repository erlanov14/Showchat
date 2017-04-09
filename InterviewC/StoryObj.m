//
//  StoryObj.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 07.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoryObj.h"
#import "ChatObj.h"
#import "Defs.h"

@implementation StoryObj

- (id)init {
    if (self = [super init]) {
        
        self.iD = @"0";
        self.name = @"";
        self.author = @"";
        self.backgroundImage = @"";
        self.watchCount = 0;
        
        self.messages = [NSMutableArray new];
        
    }
    return self;
}



- (instancetype)initWithJSON:(NSMutableDictionary *)json {
    self = [super init];
    [self setJSON:json];
    return self;
}




- (void)setJSON:(NSMutableDictionary *)json {
    //NSLog(@"%@",json);
    
    if (self && json) {
        self.iD = ZERO_OR_STRING(json[@"id"]);
        self.name = FREESTRING_OR_STRING(json[@"name"]);
        self.author = FREESTRING_OR_STRING(json[@"author"]);
        self.backgroundImage = FREESTRING_OR_STRING(json[@"background"]);
        self.watchCount = [ZERO_OR_STRING(json[@"watch_count"]) intValue];

        self.messages = [NSMutableArray new];

        NSArray *arr = json[@"messages"];
        for(int i=0;i<arr.count;i++) {
            ChatObj *chatO = [ChatObj new];
            [chatO setJSON:arr[i]];
            [self.messages addObject:chatO];
        }
    }
}

@end
