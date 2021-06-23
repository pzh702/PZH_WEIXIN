//
//  playerModel.h
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/28.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface playerModel : NSObject

/** 视频标题 */
@property (nonatomic, copy  ) NSString     *title;
/** 视频URL */
@property (nonatomic, strong) NSURL        *videoURL;
/** 视频封面本地图片 */
@property (nonatomic, strong) UIImage      *placeholderImage;
/**
 * 视频封面网络图片url
 * 如果和本地图片同时设置，则忽略本地图片，显示网络图片
 */
@property (nonatomic, copy  ) NSString     *placeholderImageURLString;
/** 视频分辨率 */
@property (nonatomic, strong) NSDictionary *resolutionDic;
/** 从xx秒开始播放视频(默认0) */
@property (nonatomic, assign) NSInteger    seekTime;
/** 上次播放至xx秒(默认0) */
@property (nonatomic, assign) NSInteger    viewTime;
/** 视频的ID */
@property (nonatomic, assign) NSInteger    videoId;

@end

NS_ASSUME_NONNULL_END
