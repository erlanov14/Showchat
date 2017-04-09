//
//  ChatService.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "ChatService.h"
#import <AFNetworking/AFNetworking.h>
#import "Defs.h"
#import "Application.h"
#import "ChatObj.h"

@implementation ChatService

-(void)getMessagesWithID:(NSString *)sid page:(NSString *)page completion:(void (^)(BOOL, NSMutableArray *, NSString *))completionBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    NSMutableDictionary *pars = [NSMutableDictionary new];
    NSString *reqUrl=[[NSString alloc]initWithFormat:@"%@",BASE_URL];
    
    NSMutableArray *res = [NSMutableArray new];
    
    [res addObject:[_fakeGenerator getFirstWithID:sid]];
    completionBlock(YES,res,nil);
    
    return;
    [manager POST:reqUrl parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ( [responseObject isKindOfClass:[NSDictionary class]] ) {
            NSDictionary *dic = (NSDictionary*)responseObject;
            NSMutableArray *arr = [NSMutableArray new];
            
            NSArray *items = dic[@"data"];
            for(int i=0;i<items.count;i++) {
                NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithDictionary:items[i]];
                [arr addObject:item];
            }
            completionBlock(YES,arr,nil);
            return;
        }
        completionBlock(NO,nil,@"Error on receiving data");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"Get Followers Error: %@", error.description);
        completionBlock(NO,nil,error.localizedDescription);
    }];
}

- (void)getAllMessagesWithID:(NSString *)sid completion:(void (^)(BOOL, NSMutableArray *, NSString *))completionBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    NSMutableDictionary *pars = [NSMutableDictionary new];
    pars[@"story_id"] = sid;
    NSString *reqUrl=[[NSString alloc]initWithFormat:@"%@/get_all_messages",BASE_URL];
    

    [manager GET:reqUrl parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ( [responseObject isKindOfClass:[NSDictionary class]] ) {
            NSDictionary *dic = (NSDictionary*)responseObject;
            if ( [str(dic[@"status"]) isEqual:@"1"] ) {
                NSMutableArray *res = [NSMutableArray new];
                NSArray *uss = dic[@"messages"];
                for(int i=0;i<uss.count;i++) {
                    ChatObj *co = [ChatObj new];
                    [co setJSON:uss[i]];
                    [res addObject:co];
                }
                
                completionBlock(YES, res, nil);
            }
            else {
                completionBlock(NO, nil, str(dic[@"error"]));
            }
            
            return;
        }
        completionBlock(NO, nil, @"Error on receiving data");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"Get Followers Error: %@", error.description);
        completionBlock(NO,nil,error.localizedDescription);
    }];
}

- (void)increaseViewsCount:(NSString *)sid completion:(void (^)(BOOL, NSString *))completionBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    NSMutableDictionary *pars = [NSMutableDictionary new];
    pars[@"story_id"] = sid;
    NSString *reqUrl=[[NSString alloc]initWithFormat:@"%@/watch_story",BASE_URL];
    
    [manager GET:reqUrl parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ( [responseObject isKindOfClass:[NSDictionary class]] ) {
            NSDictionary *dic = (NSDictionary*)responseObject;
            if ( [str(dic[@"status"]) isEqual:@"1"] ) {
                completionBlock(YES, nil);
            }
            else {
                completionBlock(NO, str(dic[@"error"]));
            }
            
            return;
        }
        completionBlock(NO, @"Error on receiving data");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"Get Followers Error: %@", error.description);
        completionBlock(NO,error.localizedDescription);
    }];
}

@end
