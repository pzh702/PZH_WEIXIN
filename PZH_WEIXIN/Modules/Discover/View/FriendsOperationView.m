//
//  FriendsOperationView.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/23.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsOperationView.h"

@interface FriendsOperationView ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation FriendsOperationView

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
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = RGB(69, 74, 76);
    
    _likeBtn = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"like"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
    _commentBtn = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"comment"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_likeBtn];
    [self addSubview:_commentBtn];
    [self addSubview:centerLine];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(80);
    }];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(_likeBtn.mas_right).offset(5);
        make.width.mas_equalTo(1);
    }];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(centerLine.mas_right).offset(5);
        make.width.mas_equalTo(80);
    }];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

- (void)likeButtonClicked
{
    if (self.clickLikeBtnBlock) {
        self.clickLikeBtnBlock();
    }
}

- (void)commentButtonClicked
{
    if (self.clickCommentBtnBlock) {
        self.clickCommentBtnBlock();
    }
}

- (void)setIsShowed:(BOOL)isShowed
{
    _isShowed = isShowed;
    if (self.isShowedBlock) {
        self.isShowedBlock(isShowed);
    }
}

@end
