//
//  AppManager.h
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject

//app启动接口
+(void)appStart;

//fps监测
+(void)showFps;

@end

NS_ASSUME_NONNULL_END
