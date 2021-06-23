//
//  landScapePlayerView.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/18.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface landScapePlayerView : UIView

kStrong	UIView *topToolView;
kStrong UILabel *titleLabel;
kStrong UIView *bottomToolView;
kStrong UIButton *playBtn;
kStrong	UILabel *nowTimeLabel;
kStrong UISlider *videoSlider;
kStrong UIProgressView *progressView;
kStrong UILabel *totalTimeLabel;
kStrong UIButton *exitFullScreenBtn;
kAssign double totalTime;

- (void)resetLandScapeView;

- (void)playEndHideView;

- (void)syncPlayTime:(NSInteger)time;

- (void)syncDurationTime:(NSInteger)time;

@end

NS_ASSUME_NONNULL_END
