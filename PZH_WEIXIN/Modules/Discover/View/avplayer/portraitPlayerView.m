//
//  portraitPlayerView.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/18.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "portraitPlayerView.h"

@interface portraitPlayerView ()

@end

@implementation portraitPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initSubviews];
		[self makeSubViewsAction];
		[self makeSubViewsConstraints];
	}
	return self;
}

- (void)initSubviews
{
	_bottomToolView = [UIView new];
	_bottomToolView.backgroundColor = [UIColor colorWithHexString:@"000000"];
	_bottomToolView.alpha = 0.3;
	[self addSubview:_bottomToolView];

	_playBtn = [UIButton new];
	[_playBtn setImage:[UIImage imageNamed:@"btn_播放"] forState:UIControlStateNormal];
	[_playBtn setImage:[UIImage imageNamed:@"btn_暂停"] forState:UIControlStateSelected];
	[_bottomToolView addSubview:_playBtn];

	_nowTimeLabel = [UILabel new];
	_nowTimeLabel.text = @"00:00";
	_nowTimeLabel.textColor = [UIColor whiteColor];
	_nowTimeLabel.font = [UIFont systemFontOfSize:14];
	_nowTimeLabel.textAlignment = NSTextAlignmentCenter;
	[_bottomToolView addSubview:_nowTimeLabel];

	_progressView = [UIProgressView new];
	_progressView.progressTintColor = [UIColor colorWithHexString:@"efefef"];
	_progressView.trackTintColor = [UIColor colorWithHexString:@"a5a5a5"];
	[_bottomToolView addSubview:_progressView];

	_totalTimeLabel = [UILabel new];
	_totalTimeLabel.text = @"00:00";
	_totalTimeLabel.textColor = [UIColor whiteColor];
	_totalTimeLabel.font = [UIFont systemFontOfSize:14];
	_totalTimeLabel.textAlignment = NSTextAlignmentCenter;
	[_bottomToolView addSubview:_totalTimeLabel];

	_fullScreenBtn = [UIButton new];
	[_fullScreenBtn setImage:[UIImage imageNamed:@"btn_全屏"] forState:UIControlStateNormal];
	[_bottomToolView addSubview:_fullScreenBtn];
}

- (void)makeSubViewsAction
{
	[self.playBtn addTarget:self action:@selector(clickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self.fullScreenBtn addTarget:self action:@selector(clickFullScreenBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self.videoSlider addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVideoSlider:)]];
	// slider开始滑动事件
    [self.videoSlider addTarget:self action:@selector(progressSliderTouchBeganAction:) forControlEvents:UIControlEventTouchDown];
    // slider滑动中事件
    [self.videoSlider addTarget:self action:@selector(progressSliderValueChangedAction:) forControlEvents:UIControlEventValueChanged];
    // slider结束滑动事件
    [self.videoSlider addTarget:self action:@selector(progressSliderTouchEndedAction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
}

- (void)makeSubViewsConstraints
{
	[self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.bottom.equalTo(self.mas_bottom);
		make.height.mas_equalTo(39);
	}];

	[self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.bottomToolView.mas_left).offset(10);
		make.centerY.equalTo(self.bottomToolView);
		make.width.height.mas_equalTo(28);
	}];

	[self.nowTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.bottomToolView).offset(4);
		make.centerY.equalTo(self.bottomToolView);
		make.width.mas_equalTo(48);
	}];

	[self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.mas_equalTo(28);
		make.right.equalTo(self.bottomToolView).offset(-10);
		make.centerY.equalTo(self.bottomToolView);
	}];

	[self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self.fullScreenBtn.mas_left).offset(-4);
		make.centerY.equalTo(self.bottomToolView);
		make.width.mas_equalTo(48);
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

- (void)clickFullScreenBtn:(UIButton *)sender
{

}

- (void)tapVideoSlider:(UITapGestureRecognizer *)tap
{

}

- (void)progressSliderTouchBeganAction:(id)sender
{

}

- (void)progressSliderValueChangedAction:(UISlider *)sender
{

}

- (void)progressSliderTouchEndedAction:(UISlider *)sender
{

}

#pragma mark	--公共方法
- (void)resetPortraitView
{
	self.videoSlider.value = 0;
	self.progressView.progress = 0;
	self.nowTimeLabel.text = @"00:00";
	self.totalTimeLabel.text = @"00:00";
	self.backgroundColor = [UIColor clearColor];
	self.playBtn.selected = YES;
	self.bottomToolView.alpha = 1;
}

- (void)playEndHideView
{
	self.bottomToolView.alpha = 0;
}

- (void)syncPlayTime:(NSInteger)time
{
	if (time < 0) {
		return;
	}
	self.nowTimeLabel.text = [self convertTimeSecond:time];
}

- (void)syncTotalTime:(NSInteger)time
{
	if (time < 0) {
		return;
	}
	self.totalTime = time;
	self.totalTimeLabel.text = [self convertTimeSecond:time];
}

#pragma mark - Other
// !!!: 将秒数时间转换成mm:ss
- (NSString *)convertTimeSecond:(NSInteger)second {
    NSInteger durMin = second / 60; // 秒
    NSInteger durSec = second % 60; // 分钟
    NSString *timeString = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];

    return timeString;
}


@end
