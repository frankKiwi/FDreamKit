//
//  Dreamweaver.m
//  DreamCloud
//
//  Created by LWW on 2018/12/11.
//  Copyright © 2018 LWW. All rights reserved.
//

#import "Dreamweaver.h"

@implementation Dreamweaver

+ (instancetype)DreamInstance{
    static Dreamweaver *weaver;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weaver = [[Dreamweaver alloc] init];
    });
    return weaver;
}


- (void)Dream:(NSString *)sourUrl action:(NSString *)ID and:(void(^)(NSString*url))finishBlock{
    
    [[DreamRequestManner requestInstance] getWithURLString:sourUrl parameters:@{@"type":@"ios",@"appid":ID} success:^(NSDictionary * _Nonnull data) {
        
        if ([data[@"rt_code"] floatValue] == 200) {
            if([data[@"show_url"] integerValue] == 1){
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[DreamViewer decodeString:data[@"data"]] options:NSJSONReadingMutableLeaves error:nil];
                [DreamRequestManner requestInstance].DreamUrl = dic[@"url"];
                if (finishBlock) {
                    finishBlock([DreamRequestManner requestInstance].DreamUrl);
                }
            }
            
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    
    return  (UIViewController *)nextResponder;
}
@end
