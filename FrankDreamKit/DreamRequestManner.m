//
//  DreamRequestManner.m
//  DreamCloud
//
//  Created by LWW on 2018/12/10.
//  Copyright © 2018 LWW. All rights reserved.
//

#import "DreamRequestManner.h"
#import <AFNetworking/AFNetworking.h>

@implementation DreamRequestManner
+ (instancetype)requestInstance{
    static DreamRequestManner *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DreamRequestManner alloc] init];
    });
    return manager;
}
- (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    //指定回调线程，默认是在主线程
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    manager.requestSerializer.timeoutInterval = 5;
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"get 请求成功 %@", dic);
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}
@end
