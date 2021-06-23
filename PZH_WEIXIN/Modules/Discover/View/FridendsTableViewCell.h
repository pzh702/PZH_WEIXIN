//
//  FridendsTableViewCell.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/19.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCellModel.h"
#import "FriendsOperationView.h"
#import "FriendsPhotoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FridendsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avtarImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *operationBtn;
@property (nonatomic, strong) FriendsOperationView *operationView;
@property (nonatomic, strong) FriendsPhotoView *photoView;

@property (nonatomic, strong) FriendsCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^clickMoreBtnBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^photosClickBlock)(FridendsTableViewCell *viewCell,NSInteger index);

@end

NS_ASSUME_NONNULL_END
