//
//  playerControlView.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/28.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "playerControlView.h"
#import "MMMaterialDesignSpinner.h"

@interface playerControlView ()

kStrong MMMaterialDesignSpinner *activity;
kStrong UIView *fastView;
kStrong UIProgressView *fastProgressView;
kStrong UILabel *fastTimeLabel;
kStrong UIImageView *fastImgView;
kStrong UIButton *failBtn;
kStrong UIButton *rePlayBtn;
kStrong UIView *watchRecordView;
kStrong UIButton *closeWatchRecordBtn;
kStrong	UILabel *watchRecordLabel;
kStrong UIButton *jumpPlayBtn;
//kAssign BOOL isShowing;
kAssign BOOL isPlayEnd;
kStrong playerStatusModel *playerStatusModel;

@end

@implementation playerControlView

+ (instancetype)initWithStatusModel:(playerStatusModel *)statusModel
{
	playerControlView *instance = [[self alloc] init];
	instance.playerStatusModel = statusModel;
	return instance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initSubviews];
		[self addSubviews];
		[self makeSubviewsAction];
		[self makeSubviewsConstraints];
		self.landScapeView.hidden = YES;
		[self resetPlayerControlView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self layoutIfNeeded];
}

- (void)initSubviews
{
	_portraitView = [portraitPlayerView new];
	_landScapeView = [landScapePlayerView new];
	_activity = [MMMaterialDesignSpinner new];
	_activity.lineWidth = 1;
	_activity.duration = 1;
	_activity.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
	_fastView = [UIView new];
	_fastView.backgroundColor = RGB(0, 0, 0);
	_fastView.alpha = 0.8;
	_fastView.layer.cornerRadius = 4;
	_fastView.layer.masksToBounds = YES;
	_fastImgView = [UIImageView new];
	_fastTimeLabel = [UILabel new];
	_fastTimeLabel.textColor = KWhiteColor;
	_fastTimeLabel.textAlignment = NSTextAlignmentCenter;
	_fastTimeLabel.font = [UIFont systemFontOfSize:14];
	_fastProgressView = [UIProgressView new];
	_fastProgressView.progressTintColor = KClearColor;
	_fastProgressView.trackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
	_failBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	[_failBtn setTitle:@"加载失败，点击重试" forState:UIControlStateNormal];
	[_failBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
	_failBtn.titleLabel.font = [UIFont systemFontOfSize:14];
	_failBtn.backgroundColor = RGB(0, 0, 0);
	_failBtn.alpha = 0.7;
	_rePlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_rePlayBtn setImage:[UIImage imageNamed:@"ZFPlayer_repeat_video"] forState:UIControlStateNormal];
	_watchRecordView                     = [[UIView alloc] init];
	_watchRecordView.backgroundColor     = [UIColor colorWithHexString:@"000000"];
	_watchRecordView.alpha = 0.8;
	_watchRecordView.layer.cornerRadius  = 2;
	_watchRecordView.layer.masksToBounds = YES;
	_closeWatchRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_closeWatchRecordBtn setImage:[UIImage imageNamed:@"btn_关闭"] forState:UIControlStateNormal];
	_watchRecordLabel               = [[UILabel alloc] init];
	_watchRecordLabel.text          = @"上次观看至88:00";
	_watchRecordLabel.textColor     = [UIColor whiteColor];
	_watchRecordLabel.textAlignment = NSTextAlignmentCenter;
	_watchRecordLabel.font          = [UIFont systemFontOfSize:16.0];
	_jumpPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_jumpPlayBtn setTitle:@"跳转播放" forState:UIControlStateNormal];
	[_jumpPlayBtn setTitleColor:[UIColor colorWithHexString:@"#ed341c"] forState:UIControlStateNormal];
	_jumpPlayBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
}

- (void)addSubviews
{
	[self addSubview:self.portraitView];
    [self addSubview:self.landScapeView];
    [self addSubview:self.activity];
    [self addSubview:self.rePlayBtn];
    [self addSubview:self.failBtn];

    [self addSubview:self.fastView];
    [self.fastView addSubview:self.fastImgView];
    [self.fastView addSubview:self.fastTimeLabel];
    [self.fastView addSubview:self.fastProgressView];

    [self addSubview:self.watchRecordView];
    [self.watchRecordView addSubview:self.closeWatchRecordBtn];
    [self.watchRecordView addSubview:self.watchRecordLabel];
    [self.watchRecordView addSubview:self.jumpPlayBtn];
}

- (void)makeSubviewsAction
{
	[self.failBtn addTarget:self action:@selector(failBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.rePlayBtn addTarget:self action:@selector(repeatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeWatchRecordBtn addTarget:self action:@selector(closeWatchrRecordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.jumpPlayBtn addTarget:self action:@selector(jumpPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)makeSubviewsConstraints
{

    [self.portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];

    [self.landScapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];

    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.with.height.mas_equalTo(45);
    }];

    [self.rePlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

    [self.failBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(33);
    }];

    [self.fastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(80);
        make.center.equalTo(self);
    }];

    [self.fastImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(32);
        make.height.mas_offset(32);
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self.fastView.mas_centerX);
    }];

    [self.fastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.with.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.fastImgView.mas_bottom).offset(2);
    }];

    [self.fastProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(12);
        make.trailing.mas_equalTo(-12);
        make.top.mas_equalTo(self.fastTimeLabel.mas_bottom).offset(10);
    }];

    [self.watchRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(260);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.watchRecordLabel.mas_right).offset(80);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-50);
    }];

    [self.closeWatchRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(30);
        make.height.mas_offset(30);
        make.top.left.mas_equalTo(self.watchRecordView);
    }];

    [self.watchRecordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.closeWatchRecordBtn.mas_right);
        make.top.height.mas_equalTo(self.watchRecordView);
//        make.width.mas_equalTo(140); // ?
    }];

    [self.jumpPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.watchRecordLabel.mas_trailing).offset(3);
        make.trailing.top.height.mas_equalTo(self.watchRecordView);
    }];
}

#pragma mark	--点击事件
/** 播放失败按钮的点击 */
- (void)failBtnClick:(UIButton *)sender {

}

/** 重播按钮的点击 */
- (void)repeatBtnClick:(UIButton *)sender {

}

/** 关闭播放记录按钮事件 */
- (void)closeWatchrRecordBtnClick:(UIButton *)sender {

}

/** 跳转播放按钮事件 */
- (void)jumpPlayBtnClick:(UIButton *)sender {

}

#pragma mark	--公共方法
- (void)autoHideControlView
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControl) object:nil];
    [self performSelector:@selector(hideControl) withObject:nil afterDelay:3];
}

- (void)cancelAutoHideControlView
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControl) object:nil];
}

- (void)resetPlayerControlView
{
	[self.portraitView resetPortraitView];
	[self.landScapeView resetLandScapeView];

	self.fastView.hidden = YES;
	self.rePlayBtn.hidden = YES;
	self.failBtn.hidden = YES;
	self.backgroundColor = [UIColor clearColor];
	self.isShowing = NO;
	self.isPlayEnd = NO;
	self.watchRecordView.hidden = YES;
	self.viewTime = 0;
}

/**
 *  开始准备播放
 */
- (void)startReadyToPlay {
    if (self.viewTime) {
//        [self showWatchrRecordView:self.viewTime];
    }

    // 显示controlView
    [self showControl];
}

/** 显示状态栏 */
- (void)showStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/** 显示控制层 */
- (void)showControl {
    if (self.isShowing) {
        [self hideControl];
        return;
    }
    [self cancelAutoHideControlView];
	[UIView animateWithDuration:0.3 animations:^{
//        [self showControlView];
		if (self.playerStatusModel.isFullScreen) {
			self.landScapeView.hidden = NO;
			self.portraitView.hidden = YES;
		} else {
			self.portraitView.hidden = NO;
			self.landScapeView.hidden = YES;
		}
		[self showStatusBar];
    } completion:^(BOOL finished) {
        self.isShowing = YES;
        [self autoHideControlView];
    }];
}

/** 隐藏控制层 */
- (void)hideControl {
    if (!self.isShowing) { return; }
    [self cancelAutoHideControlView];
	[UIView animateWithDuration:0.3 animations:^{
//        [self hideControlView];
		self.landScapeView.hidden = YES;
		self.portraitView.hidden = YES;
		if (self.playerStatusModel.isFullScreen && !self.isPlayEnd) {
			[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
		}
    }completion:^(BOOL finished) {
        self.isShowing = NO;
    }];
}

- (void)showWatchRecordView:(NSInteger)viewTime
{
	NSInteger proMin = viewTime / 60; // 秒
    NSInteger proSec = viewTime % 60; // 分钟
    self.watchRecordLabel.text = [NSString stringWithFormat:@"上次观看至 %02zd:%02zd", proMin, proSec];
    self.watchRecordView.hidden = NO;

	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWatchRecordView) object:nil];
	[self performSelector:@selector(hideWatchRecordView) withObject:nil afterDelay:5.0];
}

- (void)hideWatchRecordView
{
	self.watchRecordView.hidden = YES;
	self.viewTime = 0;
}

- (void)showFastView:(NSInteger)draggedTime totalTime:(NSInteger)totalTime isForWard:(BOOL)forward
{
	[self.activity stopAnimating];

	
}


@end
