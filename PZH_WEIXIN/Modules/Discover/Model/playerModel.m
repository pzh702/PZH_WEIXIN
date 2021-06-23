//
//  playerModel.m
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/6/28.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "playerModel.h"

@implementation playerModel

- (UIImage *)placeholderImage
{
    if (!_placeholderImage) {
        _placeholderImage = [self createImageWithColor:[UIColor blackColor]];
    }
    return _placeholderImage;
}

#pragma mark - other
/**
 *  通过颜色来生成一个纯色图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(1.0f, 1.0f));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
