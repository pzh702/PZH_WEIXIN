//
//  TagsView.m
//  TagDemo
//
//  Created by 4399 on 2020/3/5.
//  Copyright © 2020 4399. All rights reserved.
//

#import "TagsView.h"

#define TITLE_FONT  40

@implementation TagsConfig

@end

@implementation TagsView

- (instancetype)initWithFrame:(CGRect)frame
                       titlesArr:(NSArray *)titlesArr
                       config:(TagsConfig *)config
{
    if (self = [super initWithFrame:frame]) {
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
        
        CGFloat widthFlag = 0;
        CGFloat heightFlag = 0;
        NSInteger flagX = 1;    //第几列
        NSInteger flagY = 1;    //第几行
        CGFloat lastX = 0;  //记录上一次x位置
        for (NSInteger i = 1; i <= titlesArr.count; i++) {
            NSString *title = titlesArr[i-1];
            UIFont *font = [UIFont systemFontOfSize:TITLE_FONT];
            CGFloat titleLength = [title sizeWithAttributes:@{NSFontAttributeName : font}].width;
            CGFloat titleHeight = [title sizeWithAttributes:@{NSFontAttributeName : font}].height;
            
            CGFloat width = lastX+titleLength+10;    //整个view的长度
            if (width > frame.size.width) {
                flagX = 1;
                flagY++;
                lastX = 0;
            }
            CGFloat x = lastX+10; //button的x位置
            CGFloat y = 10*flagY+(titleHeight+10)*(flagY-1);
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, titleLength+10, titleHeight+10)];
            lastX = CGRectGetMaxX(btn.frame);
            [btn setTitle:title forState:UIControlStateNormal];
            if ([config.defaultsTitles containsObject:title]) {
                [btn setSelected:YES];
            }else{
                [btn setSelected:NO];
            }
            btn.layer.cornerRadius = 5;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            btn.layer.borderWidth = 1;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.titleLabel.font = font;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            flagX++;
            heightFlag = CGRectGetMaxY(btn.frame)+10;
            widthFlag = MAX(widthFlag, CGRectGetMaxX(btn.frame)+10);
            
        }
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, widthFlag, heightFlag);
        self.backgroundColor = [UIColor whiteColor];
        self.selectedTitles = [config.defaultsTitles mutableCopy];
//        for (NSString *title in config.defaultsTitles) {
//            [self.selectedTitles addObject:title];
//        }
    }
    return self;
}

- (void)clickBtn:(UIButton *)sender
{
    if (sender.selected) {
        if ([self.selectedTitles containsObject:sender.titleLabel.text]) {
            [self.selectedTitles removeObject:sender.titleLabel.text];
        }
        [sender setSelected:NO];
    } else {
        if (![self.selectedTitles containsObject:sender.titleLabel.text]) {
            [self.selectedTitles addObject:sender.titleLabel.text];
        }
        [sender setSelected:YES];
    }
}


    

@end
