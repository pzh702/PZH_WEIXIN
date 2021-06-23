//
//  LoginViewController.m
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"

@interface LoginViewController ()

//@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)initSubViews
{
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    
//    _testLabel = [[UILabel alloc] init];
//    _testLabel.text = @"[self.loginBtn addTarget:self action:@selector(clickLogin:)forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];forControlEvents:UIControlEventTouchUpInside];";
//    _testLabel.font = [UIFont systemFontOfSize:18];
//    [self.view addSubview:_testLabel];
//    [_testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.loginBtn.mas_bottom).offset(100);
//        make.left.equalTo(self.loginBtn.mas_left);
//        make.width.mas_equalTo(200);
////        make.height.mas_equalTo(20);
//    }];
//    _testLabel.numberOfLines = 2;
}

- (void)clickLogin:(UIButton *)btn
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MBProgressHUD showLoadingText:@"登录中..."];
    });
    //模拟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        KPostNotification(KNotificationLoginStateChange, @YES);
    });
    
//    [UIView animateWithDuration:1 animations:^{
//        self.testLabel.numberOfLines = 0;
//        [self.view layoutIfNeeded];
//    }];
}

@end
