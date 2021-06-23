//
//  FridendsTableViewCell.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/19.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FridendsTableViewCell.h"

@interface FridendsTableViewCell ()<PhotosViewDelegate>



//@property (nonatomic, strong) CGFloat max

@end

@implementation FridendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)initSubViews
{
    _avtarImgView = [UIImageView new];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = RGB(54, 71, 121);
    
    _msgLabel = [UILabel new];
    _msgLabel.font = [UIFont systemFontOfSize:15];
    _msgLabel.textAlignment = NSTextAlignmentJustified;
    _msgLabel.numberOfLines = 3;
    
    _moreBtn = [UIButton new];
    [_moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_moreBtn setTitleColor:RGB(92, 140, 193) forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _photoView = [FriendsPhotoView new];
    self.photoView.delegate = self;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    _operationBtn = [UIButton new];
    [_operationBtn setImage:[UIImage imageNamed:@"operationMore"] forState:UIControlStateNormal];
    [_operationBtn addTarget:self action:@selector(clickOperationBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _operationView = [FriendsOperationView new];
    _operationView.isShowed = NO;
    __weak typeof(self) weakSelf = self;
    _operationView.isShowedBlock = ^(BOOL isShowed) {
        if (isShowed) {
            [UIView animateWithDuration:0.5 animations:^{
                [weakSelf.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(180);
                }];
                [weakSelf.contentView layoutIfNeeded];
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                [weakSelf.operationView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(0);
                }];
                [weakSelf.contentView layoutIfNeeded];
            }];
        }
    };
    
    [self.contentView addSubview:_avtarImgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_msgLabel];
    [self.contentView addSubview:_moreBtn];
    [self.contentView addSubview:_photoView];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_operationBtn];
    [self.contentView addSubview:_operationView];
    
    UIView *superView = self.contentView;
    [_avtarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(10);
        make.top.equalTo(superView.mas_top).offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avtarImgView.mas_right).offset(10);
        make.top.equalTo(_avtarImgView.mas_top);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
    [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.right.equalTo(superView.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
    }];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_msgLabel.mas_left);
        make.top.equalTo(_msgLabel.mas_bottom);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_msgLabel.mas_left);
        make.top.equalTo(_moreBtn.mas_bottom).offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_msgLabel.mas_left);
        make.top.equalTo(_photoView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    [_operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLabel);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(40);
    }];
    [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationBtn);
        make.right.equalTo(_operationBtn.mas_left);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(36);
    }];
}

- (void)clickMoreBtn:(UIButton *)sender
{
    if (self.clickMoreBtnBlock) {
        self.clickMoreBtnBlock(self.indexPath);
    }
}

- (void)clickOperationBtn:(UIButton *)sender
{
    self.operationView.isShowed = !self.operationView.isShowed;
}

- (void)setModel:(FriendsCellModel *)model
{
    _model = model;
    
    self.avtarImgView.image = [UIImage imageNamed:model.avtarName];
    self.nameLabel.text = model.name;
    self.msgLabel.text = model.msg;
    self.photoView.imgPathArr = model.imgsArr;
    self.timeLabel.text = model.time;
    
    CGFloat width = model.photoWidth;
    CGFloat height = model.photoHeight;
    
    if (model.isShowed) {
//        [self.msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(model.msgMaxHeight);
//
//        }];
        self.msgLabel.numberOfLines = 0;
        [self.msgLabel sizeToFit];
    } else {
//        [self.msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(model.msgHeight);
//        }];
        self.msgLabel.numberOfLines = 3;
    }
    
    if (model.showMore) {
        self.moreBtn.hidden = NO;
        if (model.isShowed) {
            [self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
//        [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(20);
//        }];
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.moreBtn.mas_bottom).offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }else{
        self.moreBtn.hidden = YES;
//        [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.msgLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }
}

#pragma mark    --PhotosViewDelegate
- (void)photoTapped:(UIImageView *)imgView{
    if (self.photosClickBlock) {
        self.photosClickBlock(self, imgView.tag);
    }
}

@end
