//
//  TagsView.h
//  TagDemo
//
//  Created by 4399 on 2020/3/5.
//  Copyright © 2020 4399. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//button内边距为5，外边距为10，圆角为5，颜色白色，选中红色，字号14，字体默认，字体颜色黑色，
@interface TagsConfig : NSObject

@property (nonatomic,copy)NSArray *defaultsTitles;  //默认选中的

@end

@interface TagsView : UIView

@property (nonatomic,strong)NSMutableArray *selectedTitles;  //选中的


- (instancetype)initWithFrame:(CGRect)frame
                    titlesArr:(NSArray *)titlesArr
                       config:(TagsConfig *)config;

@end

NS_ASSUME_NONNULL_END
