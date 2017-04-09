//
//  ChatObj.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 07.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ChatObj.h"
#import "Defs.h"

@implementation ChatObj

- (id)init {
    if (self = [super init]) {
        
        self.iD = @"0";
        self.storyId = @"0";
        self.text = @"";
        self.author = @"";
        self.isIncoming = NO;
        self.isImage = NO;
        self.isComment = NO;
        self.image = @"";
        
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
        self.storyId = ZERO_OR_STRING(json[@"story_id"]);
        self.text = FREESTRING_OR_STRING(json[@"text"]);
        self.author = FREESTRING_OR_STRING(json[@"author"]);
    
        self.isIncoming = [FREESTRING_OR_STRING(json[@"is_incoming"]) isEqual:@"1"];
        self.isImage = [FREESTRING_OR_STRING(json[@"is_image"]) isEqual:@"1"];
        self.isComment = [FREESTRING_OR_STRING(json[@"is_comment"]) isEqual:@"1"];
        
        self.image = FREESTRING_OR_STRING(json[@"image"]);
    }
}

@end
