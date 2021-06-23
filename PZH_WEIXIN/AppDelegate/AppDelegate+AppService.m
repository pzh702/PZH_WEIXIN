//
//  AppDelegate+AppService.m
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "LoginViewController.h"
#import "MainTabBarViewController.h"

@implementation AppDelegate (AppService)

- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[LoginViewController alloc] init];
    [self.window makeKeyAndVisible];
}

-(void)initService
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
}

- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginState = [notification.object boolValue];
    if (loginState) {//登录成功
        self.window.rootViewController = [MainTabBarViewController new];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"cube";
        anima.subtype = kCATransitionFromRight;
        anima.duration = 0.5;
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        
        [MBProgressHUD showTipsText:@"登录成功" time:2 superView:nil];
    } else {
        [MBProgressHUD showTipsText:@"登录失败" time:2 superView:nil];
    }
    [AppManager showFps];
}

@end
