//
//  ToolUtils.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/17.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "ToolUtils.h"

@implementation ToolUtils

+ (UIView *)getRedDotWithWidth:(CGFloat)width
{
    UIView *redDot = [UIView new];
    redDot.frame = CGRectMake(width-5, -5, 10, 10);
    redDot.layer.cornerRadius = redDot.frame.size.width/2;
    redDot.clipsToBounds = YES;
    redDot.backgroundColor = KRedColor;
    
    return redDot;
}

+ (UIButton *)getRedNumWithNumberStr:(NSString *)numberStr
                               width:(CGFloat)width
{
    UIButton *redBtn = [UIButton new];
    if (numberStr.length>3) {
        return nil;
    }
    UIFont *font = [UIFont systemFontOfSize:12];
    CGFloat oneWordWidth = [@"1" sizeWithAttributes:@{NSFontAttributeName:font}].width+10;
    CGFloat wordsWidth = [numberStr sizeWithAttributes:@{NSFontAttributeName:font}].width+10;
    redBtn.frame = CGRectMake(width-wordsWidth/2, -oneWordWidth/2, wordsWidth, oneWordWidth);
    redBtn.layer.cornerRadius = oneWordWidth/2;
    [redBtn setBackgroundColor:KRedColor];
//    redBtn.layer.backgroundColor = KRedColor.CGColor;
    [redBtn setTitle:numberStr forState:UIControlStateNormal];
    [redBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    redBtn.titleLabel.font = font;
    redBtn.userInteractionEnabled = NO;
    
    return redBtn;
}

+ (void)addBarTitleWithTitle:(NSString *)title
                          vc:(UIViewController *)vc
                      isLeft:(BOOL)isLeft
                      action:(SEL)action
                      target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont systemFontOfSize:18];
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:font}].width+5;
    btn.frame = CGRectMake(0, 0, width, 20);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:KBlackColor forState:UIControlStateNormal];
    if (action == nil) {
        btn.userInteractionEnabled = NO;
    } else {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn sizeToFit];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft) {
        vc.navigationItem.leftBarButtonItem = barItem;
    } else {
        vc.navigationItem.rightBarButtonItem = barItem;
    }
}

+ (void)addBarImgWithImg:(NSString *)imgName
                      vc:(UIViewController *)vc
                  isLeft:(BOOL)isLeft
                  action:(SEL)action
                  target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    if (action == nil) {
        btn.userInteractionEnabled = NO;
    } else {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft) {
        vc.navigationItem.leftBarButtonItem = barItem;
    } else {
        vc.navigationItem.rightBarButtonItem = barItem;
    }
}

+ (NSString *) urlencode:(NSString *)str
{
    NSCharacterSet *chars = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSMutableCharacterSet *mutableChars = [chars mutableCopy];
    [mutableChars removeCharactersInString: @":#[]@!$&'()*+,;=/ "];
    NSString *urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters: mutableChars];
    return urlStr;
}

@end
