//
//  playerStatusModel.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/28.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "playerStatusModel.h"

@implementation playerStatusModel

/**
 重置状态模型属性
 */
- (void)playerResetStatusModel {
    self.autoPlay = NO;
    self.playDidEnd = NO;
    self.dragged = NO;
    self.didEnterBackground = NO;
    self.pauseByUser = YES;
    self.fullScreen = NO;
}

@end
