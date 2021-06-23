//
//  AdPageView.h
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapBlock)(void);

@interface AdPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     tapBlock:(TapBlock)tapBlock;

@end

NS_ASSUME_NONNULL_END
