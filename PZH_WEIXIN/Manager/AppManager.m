//
//  AppManager.m
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import "AppManager.h"
#import "YYFPSLabel.h"
#import "AdPageView.h"

@implementation AppManager

+ (void)appStart
{
    AdPageView *adView = [[AdPageView alloc] initWithFrame:kScreen_Bounds tapBlock:^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"http://www.baidu.com"] options: @{} completionHandler: nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"http://www.baidu.com"]];
        }
    }];
    adView = adView;
}

+ (void)showFps
{
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    [fpsLabel sizeToFit];
    fpsLabel.bottom = KScreenHeight - 55;
    fpsLabel.right = KScreenWidth - 10;
    [kAppWindow addSubview:fpsLabel];
}

@end
