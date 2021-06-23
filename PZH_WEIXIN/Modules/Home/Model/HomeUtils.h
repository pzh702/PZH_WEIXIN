//
//  HomeUtils.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeUtils : NSObject

/**生成随机数据*/
+ (HomeModel *)getRandomData;

@end

NS_ASSUME_NONNULL_END
