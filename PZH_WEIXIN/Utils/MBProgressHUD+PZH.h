//
//  MBProgressHUD+PZH.h
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/12.
//  Copyright © 2020 4399. All rights reserved.
//
#import "MBProgressHUD.h"

@interface MBProgressHUD (PZH)

/**
*  用于显示加载时的菊花+文字，不会自动消失
*
*  @param text     显示的文字
*
*/
+ (void)showLoadingText:(NSString *)text;


/**
*   用于显示提示时的文字，会自动消失
*
*   @param  text    显示的文字
*   @param  time    自动消失的时间
*   @param  superView   父视图，没有则为主窗口
*
*/
+ (void)showTipsText:(NSString *)text
                time:(CGFloat)time
           superView:(UIView *)superView;


/**
 *  快速从window中隐藏ProgressView
 */
+ (void)hideHUD;

@end
