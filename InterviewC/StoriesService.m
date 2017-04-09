//
//  StoriesService.m
//  InterviewC
//
//  Created by Yerassyl Yerlanov on 02.04.17.
//  Copyright © 2017 Yerassyl Yerlanov. All rights reserved.
//

#import "StoriesService.h"
#import <AFNetworking/AFNetworking.h>
#import "Defs.h"
#import "Application.h"
#import "StoryObj.h"

@implementation StoriesService

- (void)getStoriesForPage:(NSString *)page completion:(void (^)(BOOL, NSMutableArray *, NSString *))completionBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    NSMutableDictionary *pars = [NSMutableDictionary new];
    pars[@"page"] = page;
    NSString *reqUrl=[[NSString alloc]initWithFormat:@"%@/get_stories",BASE_URL];
    
    
    [manager GET:reqUrl parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ( [responseObject isKindOfClass:[NSDictionary class]] ) {
            NSDictionary *dic = (NSDictionary*)responseObject;
            if ( [str(dic[@"status"]) isEqual:@"1"] ) {
                NSMutableArray *res = [NSMutableArray new];
                NSArray *uss = dic[@"stories"];
                for(int i=0;i<uss.count;i++) {
                    StoryObj *so = [StoryObj new];
                    [so setJSON:uss[i]];
                    [res addObject:so];
                }
                if ( uss.count>0 ) {
                    StoryObj *soo = res[0];
                    for ( int i=0;i<16;i++ ) {
                        [res addObject:soo];
                    }
                }
                #warning REMOVE THIS
                
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


@end
