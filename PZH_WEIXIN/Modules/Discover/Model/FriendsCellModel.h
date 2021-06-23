//
//  FriendsCellModel.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/20.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsCellModel : NSObject

@property (nonatomic, copy) NSString *avtarName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray<UIImage *> *imgsArr;

@property (nonatomic, assign) CGFloat msgMaxHeight;
@property (nonatomic, assign) CGFloat msgHeight;
@property (nonatomic, assign) CGFloat photoWidth;
@property (nonatomic, assign) CGFloat photoHeight;
@property (nonatomic, assign) BOOL showMore;    //是否要显示更多按钮
@property (nonatomic, assign) BOOL isShowed;    //是否已经展开

@end

NS_ASSUME_NONNULL_END
