//
//  FriendsPhotoView.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/23.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsPhotoView.h"

@interface FriendsPhotoView ()

@property (nonatomic, strong) NSArray *imgViewsArr;

@end

@implementation FriendsPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imgViewsArr = [temp copy];
}

- (void)setImgPathArr:(NSArray *)imgPathArr
{
    _imgPathArr = imgPathArr;
    
    for (long i = _imgPathArr.count; i < self.imgViewsArr.count; i++) {
        UIImageView *imageView = [self.imgViewsArr objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_imgPathArr.count == 0) {
        self.height = 0;
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_imgPathArr];
    CGFloat itemH = 0;
    if (_imgPathArr.count == 1) {
        UIImage *image = _imgPathArr.firstObject;
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_imgPathArr];
    CGFloat margin = 5;
    
    [_imgPathArr enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imgViewsArr objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = obj;
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_imgPathArr.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(photoTapped:)]) {
        [self.delegate photoTapped:(UIImageView *)tap.view];
    }
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
