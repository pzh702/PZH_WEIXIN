//
//  ToolUtils.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/17.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolUtils : NSObject

/**获取小红点,width:父视图的长度*/
+ (UIView *)getRedDotWithWidth:(CGFloat)width;

/**类似qq的未读消息，width:父视图的长度*/
+ (UIButton *)getRedNumWithNumberStr:(NSString *)numberStr
                               width:(CGFloat)width;

/**给顶部bar添加文字*/
+ (void)addBarTitleWithTitle:(NSString *)title
                          vc:(UIViewController *)vc
                      isLeft:(BOOL)isLeft
                      action:(SEL)action
                      target:(id)target;

/**给顶部bar添加图片*/
+ (void)addBarImgWithImg:(NSString *)imgName
                      vc:(UIViewController *)vc
                  isLeft:(BOOL)isLeft
                  action:(SEL)action
                  target:(id)target;

+ (NSString *) urlencode:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
