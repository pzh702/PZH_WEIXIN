//
//  FriendsEditCollectionViewCell.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/25.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsEditCollectionViewCell : UICollectionViewCell

kStrong UIImage *photoImg;
kStrong UIButton *addBtn;
kStrong UIButton *deleteBtn;
kStrong UIImageView *imgView;
kCopy   void(^addBtnBlock)(UIButton *addBtn);
kCopy   void(^deleteBtnBlock)(UIImage *photoImg);

@end
