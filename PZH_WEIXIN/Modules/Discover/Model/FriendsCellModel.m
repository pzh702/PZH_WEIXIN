//
//  FriendsCellModel.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/20.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsCellModel.h"

@implementation FriendsCellModel

- (void)setMsg:(NSString *)msg
{
    _msg = msg;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    CGRect textRect = [msg boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    if (textRect.size.height>60) {
        self.showMore = YES;
        self.isShowed = NO;
    } else {
        self.showMore = NO;
        self.isShowed = YES;
    }
    
    self.msgHeight = textRect.size.height>60?60:textRect.size.height;
    self.msgMaxHeight = textRect.size.height+10;
}

- (void)setImgsArr:(NSArray *)imgsArr
{
    _imgsArr = imgsArr;
    
    CGFloat itemW = [self itemWidthForPicPathArray:imgsArr];
    CGFloat itemH = 0;
    if (imgsArr.count == 1) {
        UIImage *image = imgsArr.firstObject;
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:imgsArr];
    CGFloat margin = 5;
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(imgsArr.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    
    self.photoWidth = w;
    self.photoHeight = h;
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

@end
