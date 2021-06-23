//
//  FriendsOperationView.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/23.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsOperationView : UIView

@property (nonatomic, assign) BOOL isShowed;
@property (nonatomic, copy) void (^clickLikeBtnBlock)(void);
@property (nonatomic, copy) void (^clickCommentBtnBlock)(void);
@property (nonatomic, copy) void (^isShowedBlock)(BOOL isShowed);

@end

NS_ASSUME_NONNULL_END
