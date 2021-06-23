//
//  playerControlView.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/28.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerStatusModel.h"
#import "landScapePlayerView.h"
#import "portraitPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol playerControlViewDelegate <NSObject>
@optional
/**加载失败*/
- (void)clickFailBtn;
/**重播*/
- (void)clickReplayBtn;
/**跳转播放*/
- (void)clickJumpBtn;

@end

@interface playerControlView : UIView

@property (nonatomic, weak)id<playerControlViewDelegate>delegate;
@property (nonatomic, assign)BOOL isShowing;
kStrong landScapePlayerView *landScapeView;
kStrong portraitPlayerView *portraitView;
kAssign NSInteger viewTime;

- (instancetype)initWithStatusModel:(playerStatusModel *)statusModel;

- (void)resetPlayerControlView;

- (void)showStatusBar;

- (void)showControl;
- (void)hideControl;

//- (void)setIsShowing:(BOOL)isShowing;

- (void)cancelAutoHideControlView;
- (void)autoHideControlView;

- (void)showWatchRecordView:(NSInteger)viewTime;
- (void)hideWatchRecordView;

- (void)showFastView:(NSInteger)draggedTime totalTime:(NSInteger)totalTime isForWard:(BOOL)forward;
- (void)hideFastView;

- (void)startReadyPlay;
- (void)readyPlay;
- (void)loadFailed;
- (void)loading;
- (void)playDidEnd;

- (void)playEndHideControlView;

@end

NS_ASSUME_NONNULL_END
