//
//  BaseViewController.h
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;

/**
 *  
 */
//@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

/**
 *  是否显示返回按钮,默认情况是YES
 */
//@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 导航栏添加文本按钮

 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮

 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

- (void)headerRereshing;

- (void)footerRereshing;

@end

NS_ASSUME_NONNULL_END
