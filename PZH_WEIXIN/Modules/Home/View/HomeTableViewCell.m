//
//  HomeTableViewCell.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "HomeTableViewCell.h"

#define kButtonWidth    80
#define kShouldSlideX   -2
#define kCriticalTranslationX   30

@interface HomeTableViewCell ()

@property (nonatomic, assign) BOOL isSlided;    //是否已经滑动显示
@property (nonatomic, assign) BOOL shouldSlided;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.redBtn.backgroundColor = KRedColor;
//    if (selected) {
//        self.deleteBtn.hidden = YES;
//        self.tagBtn.hidden = YES;
//    } else {
//        self.deleteBtn.hidden = NO;
//        self.tagBtn.hidden = NO;
//    }
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [self setupGestureRecognizer];
    }
    return self;
}

- (void)initSubViews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgView = [UIImageView new];
    _imgView.layer.cornerRadius = 5;
//    _imgView.clipsToBounds = YES;
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor blackColor];
    
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor lightGrayColor];
    
    _deleteBtn = [UIButton new];
    _deleteBtn.backgroundColor = [UIColor redColor];
    [_deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _tagBtn = [UIButton new];
    _tagBtn.backgroundColor =[UIColor lightGrayColor];
    [_tagBtn addTarget:self action:@selector(clickTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tagBtn setTitle:@"标记未读" forState:UIControlStateNormal];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_messageLabel];
    [self insertSubview:_deleteBtn belowSubview:self.contentView];
    [self insertSubview:_tagBtn belowSubview:self.contentView];
    
    UIView *superView = self.contentView;
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(_imgView.mas_right).offset(10);
        make.right.equalTo(superView.mas_right).offset(-80);
        make.height.mas_equalTo(26);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(80);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(10);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.mas_equalTo(18);
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    [_tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(_deleteBtn.mas_left);
        make.width.mas_equalTo(80);
    }];
}

- (void)clickDeleteBtn:(UIButton *)sender
{
//    self.showRedDot = NO;
//    if (self.isSlided) {
//        [self cellSlideAnimationWithX:0];
//    }
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (void)clickTagBtn:(UIButton *)sender
{
    self.showRedDot = YES;
    if (self.isSlided) {
        [self cellSlideAnimationWithX:0];
    }
}

- (void)setupGestureRecognizer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    _pan = pan;
    pan.delegate = self;
    pan.delaysTouchesBegan = YES;
    [self.contentView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.delegate = self;
    tap.enabled = NO;
    _tap = tap;
    [self.contentView addGestureRecognizer:tap];
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    if (self.contentView.left <= kShouldSlideX) {
        _shouldSlided = YES;
    }

    if (fabs(point.y) < 1.0) {
        if (_shouldSlided) {
            [self slideWithTranslation:point.x];
        } else if (fabs(point.x) >= 1.0) {
            [self slideWithTranslation:point.x];
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat x = 0;
        if (self.contentView.left < -kCriticalTranslationX && !self.isSlided) {
            x = -(kButtonWidth + kButtonWidth);
        }
        [self cellSlideAnimationWithX:x];
        _shouldSlided = NO;
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (self.isSlided) {
        [self cellSlideAnimationWithX:0];
    }
}

- (void)cellSlideAnimationWithX:(CGFloat)x
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentView.left = x;
    } completion:^(BOOL finished) {
        self.isSlided = (x != 0);
    }];
}

- (void)slideWithTranslation:(CGFloat)value
{
    if (self.contentView.left < -(kButtonWidth + kButtonWidth) * 1.1 || self.contentView.frame.origin.x > 30) {
        value = 0;
    }
    self.contentView.left += value;
}

- (void)setIsSlided:(BOOL)isSlided
{
    _isSlided = isSlided;
    
    _tap.enabled = isSlided;
}

- (void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    
    self.imgView.image = [UIImage imageNamed:homeModel.imgName];
    self.nameLabel.text = homeModel.name;
    self.messageLabel.text = homeModel.message;
    self.timeLabel.text = homeModel.time;
}

- (void)setShowRedDot:(BOOL)showRedDot
{
    _showRedDot = showRedDot;
    if (showRedDot) {
        if (self.imgView.subviews.count > 0) {
            
        } else {
//            [self.imgView addSubview:[ToolUtils getRedDotWithWidth:50]];
            self.redBtn = [ToolUtils getRedNumWithNumberStr:@"99" width:50];
            [self.imgView addSubview:self.redBtn];
        }
    } else {
        if (self.imgView.subviews.count > 0) {
            [self.imgView removeAllSubviews];
        } else {
            
        }
    }
}

#pragma mark - gestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.contentView.left <= kShouldSlideX && otherGestureRecognizer != _pan && otherGestureRecognizer != _tap) {
        return NO;
    }
    return YES;
}

@end
