//
//  MBProgressHUD+PZH.m
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/12.
//  Copyright © 2020 4399. All rights reserved.
//

#import "MBProgressHUD+PZH.h"

@implementation MBProgressHUD (PZH)

+ (void)showLoadingText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppWindow animated:YES];
        hud.label.text = text;
        hud.label.font= [UIFont systemFontOfSize:15];
        //模式
        hud.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // 代表需要蒙版效果
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        
        //添加加载动画
        UIImageView *progress = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        progress.image = [UIImage imageNamed:@"loading"];
        CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
        theAnimation.values = [NSArray arrayWithObjects:
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.14, 0,0,1)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.28, 0,0,1)],
                               nil];
        theAnimation.cumulative = YES;
        theAnimation.duration = 1;
        theAnimation.repeatCount = NSUIntegerMax;
        theAnimation.removedOnCompletion = NO;
        [progress.layer addAnimation:theAnimation forKey:@"transform"];
        hud.customView = progress;

        [hud showAnimated:YES];
    });
}

+ (void)showTipsText:(NSString *)text
                time:(CGFloat)time
           superView:(UIView *)superView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView?superView:kAppWindow animated:YES];
    hud.label.text = text;
    hud.label.font= [UIFont systemFontOfSize:15];
    //模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // X秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)hideHUD
{
    [self hideHUDForView:kAppWindow animated:YES];
}

@end
