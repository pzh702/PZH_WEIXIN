//
//  coverView.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/17.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface coverView : UIView


//设置封面图
- (void)coverImageViewWithUrl:(NSString *)url	placeholderImage:(UIImage *)placeholderImage;

@end

NS_ASSUME_NONNULL_END
