//
//  FriendsPhotoView.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/23.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotosViewDelegate <NSObject>

- (void)photoTapped:(UIImageView *)imgView;

@end

@interface FriendsPhotoView : UIView

@property (nonatomic, strong) NSArray<UIImage *> *imgPathArr;

@property (nonatomic, weak) id<PhotosViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
