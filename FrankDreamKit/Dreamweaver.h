//
//  Dreamweaver.h
//  DreamCloud
//
//  Created by LWW on 2018/12/11.
//  Copyright © 2018 LWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DreamRequestManner.h"
#import "DreamViewer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dreamweaver : NSObject

+ (instancetype)DreamInstance;

@property (nonatomic)BOOL isDebug;

- (void)Dream:(NSString *)sourUrl action:(NSString *)ID and:(void(^)(NSString*url))finishBlock;

+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
