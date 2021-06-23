//
//  coverView.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/17.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "coverView.h"

@interface coverView ()

kStrong UIImageView *backgroundImgView;
kStrong UIButton *playBtn;

@end

@implementation coverView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor blackColor];
		[self initSubviews];
	}
	return self;
}

- (void)initSubviews
{
	self.backgroundImgView = [UIImageView new];
	self.playBtn = [UIButton new];
//	[self.playBtn setImage:[UIImage imageNamed:@"btn_playplus"] forState:UIControlStateNormal];
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"使用流量播放"];
	[attr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSRangeFromString(@"流量")];
	[self.playBtn setAttributedTitle:attr forState:UIControlStateNormal];
	[self.playBtn addTarget:self action:@selector(clickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
//	[self.playBtn.titleLabel sizeToFit];
	[self addSubview:self.backgroundImgView];
	[self addSubview:self.playBtn];

	[self.backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.bottom.right.equalTo(self);
	}];
	[self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
		make.height.width.mas_equalTo(self.size.height/4);
	}];
}

//
- (void)clickPlayBtn:(UIButton *)sender
{

}

- (void)coverImageViewWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
	// 设置网络占位图片
    if (url.length) {
        [self.backgroundImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];;
    } else {
        self.backgroundImgView.image = placeholderImage;
    }
}

@end
