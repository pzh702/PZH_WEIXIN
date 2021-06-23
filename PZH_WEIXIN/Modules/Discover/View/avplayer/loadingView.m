//
//  loadingView.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/17.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "loadingView.h"
#import "MMMaterialDesignSpinner.h"

@interface loadingView ()

kStrong MMMaterialDesignSpinner *activity;

@end

@implementation loadingView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor blackColor];
		[self initSubviews];
		[self.activity startAnimating];
	}
	return self;
}

- (void)initSubviews
{
	[self addSubview:self.activity];
	[self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
		make.width.height.mas_equalTo(50);
	}];
}


- (MMMaterialDesignSpinner *)activity {
    if (!_activity) {
        _activity = [[MMMaterialDesignSpinner alloc] init];
        _activity.lineWidth = 1;
        _activity.duration  = 1;
        _activity.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    }
    return _activity;
}

@end
