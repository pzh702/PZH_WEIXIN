//
//  portraitPlayerView.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/18.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface portraitPlayerView : UIView

kStrong UIView *bottomToolView;
kStrong UIButton *playBtn;
kStrong UILabel *nowTimeLabel;
kStrong UISlider *videoSlider;
kStrong UIProgressView *progressView;
kStrong UILabel *totalTimeLabel;
kStrong UIButton *fullScreenBtn;
kAssign double totalTime;

- (void)resetPortraitView;

- (void)playEndHideView;

- (void)syncPlayTime:(NSInteger)time;

- (void)syncTotalTime:(NSInteger)time;

@end

NS_ASSUME_NONNULL_END
