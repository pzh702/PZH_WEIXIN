//
//  HomeTableViewCell.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *tagBtn;
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, copy) void(^deleteBlock)(void);

@property (nonatomic, strong) HomeModel *homeModel;

@property (nonatomic, assign) BOOL showRedDot;

@end

NS_ASSUME_NONNULL_END
