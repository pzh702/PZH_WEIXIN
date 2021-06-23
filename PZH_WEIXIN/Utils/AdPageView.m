//
//  AdPageView.m
//  PZH_WeiXin
//
//  Created by 4399 on 2020/3/11.
//  Copyright © 2020 4399. All rights reserved.
//

#import "AdPageView.h"

#define CountTime   5   //倒计时5秒

@interface AdPageView ()

@property(nonatomic,copy)TapBlock tapBlock;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation AdPageView

- (instancetype)initWithFrame:(CGRect)frame
                     tapBlock:(TapBlock)tapBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        //广告图片
        _imgView = [[UIImageView alloc] initWithFrame:frame];
        _imgView.image = [UIImage imageNamed:@"weixin_ad.jpg"];
        _imgView.userInteractionEnabled = YES;
        _imgView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd)];
        [_imgView addGestureRecognizer:tap];
        
        //跳过按钮
        _timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 60 -24, kTopHeight, 60, 30)];
        [_timeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_timeBtn setTitle:[NSString stringWithFormat:@"跳过%d", CountTime] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timeBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _timeBtn.layer.cornerRadius = 4;
        
        [self addSubview:_imgView];
        [self addSubview:_timeBtn];
        
        self.tapBlock = tapBlock;
#ifdef Show_Ad
        [self showAd];
#endif
    }
    return self;
}

- (void)tapAd
{
    if (self.tapBlock) {
        self.tapBlock();
    }
    [self dismiss];
}

- (void)dismiss
{
    if (self.superview) {
        [UIView animateWithDuration:0.5f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)showAd
{
    //GCD定时
//    __block NSInteger timeOut = CountTime;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        if (timeOut <= 0) {
//            dispatch_source_cancel(timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self dismiss];
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self->_timeBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)timeOut] forState:UIControlStateNormal];
//            });
//            timeOut--;
//        }
//    });
//    dispatch_resume(timer);
    //runloop定时
    _count = CountTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)countDown
{
    _count--;
    [_timeBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_count] forState:UIControlStateNormal];
    if (_count <= 0) {
        
        [self dismiss];
    }
}

@end
