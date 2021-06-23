//
//  FriendsEditCollectionViewCell.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/25.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsEditCollectionViewCell.h"

@interface FriendsEditCollectionViewCell ()



@end

@implementation FriendsEditCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGrayColor;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _imgView = [UIImageView new];
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_addBtn setTitleColor:KBlueColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:KBlackColor forState:UIControlStateNormal];
    [_deleteBtn setBackgroundColor:[UIColor grayColor]];
    [_deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_addBtn];
    [self.contentView addSubview:_deleteBtn];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (void)clickAddBtn:(UIButton *)sender
{
    if (self.addBtnBlock) {
        self.addBtnBlock(self.addBtn);
    }
}

- (void)clickDeleteBtn:(UIButton *)sender
{
    if (self.deleteBtn) {
        self.deleteBtnBlock(self.photoImg);
    }
}

- (void)setPhotoImg:(UIImage *)photoImg
{
    _photoImg = photoImg;
    if (photoImg) {
        self.addBtn.hidden = YES;
        self.imgView.hidden = NO;
        self.deleteBtn.hidden = NO;
    } else {
        self.addBtn.hidden = NO;
        self.imgView.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    self.imgView.image = photoImg;
}

@end
