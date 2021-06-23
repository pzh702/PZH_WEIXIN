//
//  FriendsEditViewController.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/25.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendsCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendsEditViewController : BaseViewController

kCopy void(^editCallBackBlock)(FriendsCellModel *model);

@end

NS_ASSUME_NONNULL_END
