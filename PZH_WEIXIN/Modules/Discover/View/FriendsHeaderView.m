//
//  FriendsHeaderView.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/19.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsHeaderView.h"

@implementation FriendsHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _backgroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pbg.jpg"]];
    
    _avatarImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic8.jpg"]];
    _avatarImgView.layer.borderWidth = 3;
    _avatarImgView.layer.borderColor = KWhiteColor.CGColor;
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"pzh_702";
    _nameLabel.textColor = KWhiteColor;
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [self addSubview:_backgroundImgView];
    [self addSubview:_avatarImgView];
    [self addSubview:_nameLabel];
    
    [_backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    
    [_avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_avatarImgView.mas_left).offset(-20);
        make.centerY.equalTo(_avatarImgView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
}

@end
