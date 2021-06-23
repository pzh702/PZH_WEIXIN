//
//  landScapePlayerView.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/18.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "landScapePlayerView.h"

@interface landScapePlayerView ()



@end

@implementation landScapePlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initSubviews];
		[self makeSubviewsAction];
		[self makeSubViewsConstraints];
	}
	return self;
}

- (void)initSubviews
{
	_topToolView = [UIView new];
	_topToolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
	[self addSubview:_topToolView];

	_titleLabel = [UILabel new];
	_titleLabel.textColor = [UIColor whiteColor];
	_titleLabel.font = [UIFont systemFontOfSize:15];
	[self.topToolView addSubview:_titleLabel];

	_bottomToolView = [UIView new];
	_bottomToolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
	[self addSubview:_bottomToolView];

	_playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_playBtn setImage:[UIImage imageNamed:@"btn_播放"] forState:UIControlStateNormal];
	[_playBtn setImage:[UIImage imageNamed:@"btn_暂停"] forState:UIControlStateSelected];
	[self.bottomToolView addSubview:_playBtn];

	_nowTimeLabel = [UILabel new];
	_nowTimeLabel.textColor = [UIColor whiteColor];
	_nowTimeLabel.font = [UIFont systemFontOfSize:14];
	_nowTimeLabel.textAlignment = NSTextAlignmentCenter;
	[self.bottomToolView addSubview:_nowTimeLabel];

	_videoSlider = [[UISlider alloc] init];
	_videoSlider.maximumValue = 1;
	_videoSlider.minimumTrackTintColor = [UIColor colorWithHexString:@"#e6420d"];
	_videoSlider.maximumTrackTintColor = [UIColor clearColor];
	[_videoSlider setThumbImage:[UIImage imageNamed:@"椭圆-1"] forState:UIControlStateNormal];
	[self.bottomToolView addSubview:_videoSlider];

	_progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
	_progressView.progressTintColor = [UIColor colorWithHexString:@"efefef"];
	_progressView.trackTintColor = [UIColor colorWithHexString:@"a5a5a5"];
	[self.bottomToolView addSubview:_progressView];

	_totalTimeLabel = [[UILabel alloc] init];
	_totalTimeLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
	_totalTimeLabel.font = [UIFont systemFontOfSize:14.0f];
	_totalTimeLabel.textAlignment = NSTextAlignmentCenter;
	[self.bottomToolView addSubview:_totalTimeLabel];

	_exitFullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_exitFullScreenBtn setImage:[UIImage imageNamed:@"btn_缩屏"] forState:UIControlStateNormal];
	[_exitFullScreenBtn setImage:[UIImage imageNamed:@"btn_退出全屏"] forState:UIControlStateHighlighted];
	[self.bottomToolView addSubview:_exitFullScreenBtn];
}

- (void)makeSubviewsAction
{
	[self.playBtn addTarget:self action:@selector(clickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self.exitFullScreenBtn addTarget:self action:@selector(clickExitFullScreenBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self.videoSlider addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVideoSlider:)]];

	[self.videoSlider addTarget:self action:@selector(progressSliderTouchBeganAction:) forControlEvents:UIControlEventTouchDown];
	[self.videoSlider addTarget:self action:@selector(progressSliderValueChangedAction:) forControlEvents:UIControlEventValueChanged];
	[self.videoSlider addTarget:self action:@selector(progressSliderTouchEndedAction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
}

- (void)makeSubViewsConstraints
{
	[self.topToolView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self);
		make.top.equalTo(self.mas_top).offset(20);
		make.height.mas_equalTo(38);
	}];

	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.topToolView);
	}];

	[self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left);
		make.bottom.equalTo(self.mas_bottom).offset(-120);
		make.height.mas_equalTo(38);
	}];

	[self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.width.mas_equalTo(28);
		make.left.equalTo(self.bottomToolView.mas_left).offset(10);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.nowTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.playBtn.mas_right).offset(4);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.exitFullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.mas_equalTo(32);
		make.right.equalTo(self.bottomToolView.mas_right).offset(-10);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self.exitFullScreenBtn.mas_left).offset(-10);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.nowTimeLabel.mas_right).offset(10);
		make.right.equalTo(self.totalTimeLabel.mas_left).offset(-10);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.nowTimeLabel.mas_right).offset(10);
		make.right.equalTo(self.totalTimeLabel.mas_left).offset(-10);
		make.centerY.equalTo(self.bottomToolView);
		make.height.mas_equalTo(30);
	}];


}


#pragma mark	--点击事件
- (void)clickPlayBtn:(UIButton *)sender
{

}

- (void)clickExitFullScreenBtn:(UIButton *)sender
{

}

- (void)tapVideoSlider:(UITapGestureRecognizer *)tap
{

}

- (void)progressSliderTouchBeganAction:(id)sender {

}

- (void)progressSliderValueChangedAction:(UISlider *)sender {
    // 拖拽过程中修改playTime
    [self syncPlayTime:(sender.value * self.totalTime)];
}

- (void)progressSliderTouchEndedAction:(UISlider *)sender {

}


#pragma mark	--工具方法
// !!!: 将秒数时间转换成mm:ss
- (NSString *)convertTimeSecond:(NSInteger)second {

    NSInteger durMin = second / 60; // 秒
    NSInteger durSec = second % 60; // 分钟
    NSString *timeString = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];

    return timeString;
}

#pragma mark	--公共方法

- (void)resetLandScapeView
{
	self.videoSlider.value = 0;
	self.progressView.progress = 0;
	self.nowTimeLabel.text = @"00:00";
	self.totalTimeLabel.text = @"00:00";
	self.backgroundColor = [UIColor clearColor];
	self.playBtn.selected = YES;
	self.titleLabel.text = @"";
	self.topToolView.alpha = 1;
	self.bottomToolView.alpha = 1;
}

- (void)playEndHideView
{
	self.topToolView.alpha = 0;
	self.bottomToolView.alpha = 0;
	self.playBtn.alpha = 0;
}


- (void)syncPlayTime:(NSInteger)time
{
	if (time<0) {
		return;
	}
	NSString *progressTimeString = [self convertTimeSecond:time];
	self.nowTimeLabel.text = progressTimeString;
}

- (void)syncTotalTime:(NSInteger)time
{
	if (time<0) {
		return;
	}
	self.totalTime = time;
	NSString *totalTimeString = [self convertTimeSecond:time];
	self.totalTimeLabel.text = totalTimeString;
}




@end
