//
//  TagViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/19.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "TagViewController.h"
#import "TagsView.h"

#define kTags   @"Tags"

@interface TagViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) TagsView *tagsView;
@property (nonatomic, assign) CGFloat tempHeight;

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSubViews];
    // Do any additional setup after loading the view.
}

- (void)initSubViews
{
    [ToolUtils addBarTitleWithTitle:@"保存标签" vc:self isLeft:NO action:@selector(saveTags) target:self];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, KScreenWidth-80-10-10-10, 50)];
    _textField.placeholder = @"请输入标签，以空格为分隔符";
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.keyboardType = UIKeyboardTypeAlphabet;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.backgroundColor = KGray2Color;
    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-10-80, 100, 80, 50)];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _confirmBtn.backgroundColor = KGray2Color;
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_textField];
    [self.view addSubview:_confirmBtn];
}

- (void)clickConfirmBtn:(UIButton *)sender
{
    if (self.tagsView.superview && self.tagsView) {
        [self.tagsView removeFromSuperview];
    }
    
    [self showTagsView];
    [MBProgressHUD showLoadingText:@"正在生成标签，请稍候"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self TagsAnimation];
    });
}

//做个动画吧
- (void)TagsAnimation
{
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.tagsView.frame;
        frame.size.height = self.tempHeight;
        self.tagsView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showTagsView
{
    NSArray *tagArr = [self.textField.text componentsSeparatedByString:@" "];
    TagsConfig *config = [TagsConfig new];
    NSArray *selectedTitles = [[[NSUserDefaults standardUserDefaults] objectForKey:kTags] copy];
    config.defaultsTitles = [NSArray new];
    if (selectedTitles.count > 0) {
        config.defaultsTitles = selectedTitles;
    }
    _tagsView = [[TagsView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField.frame)+50, 400, 0) titlesArr:tagArr config:config];
    self.tempHeight = self.tagsView.frame.size.height;
    
    CGRect frame = self.tagsView.frame;
    frame.size.height = 0;
    self.tagsView.frame = frame;
    
    _tagsView.layer.borderWidth = 1;
    _tagsView.layer.borderColor = KGrayColor.CGColor;
    _tagsView.clipsToBounds = YES;
    [self.view addSubview:self.tagsView];
}

- (void)saveTags
{
    for (NSString *str in self.tagsView.selectedTitles) {
        NSLog(@"%@", str);
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.tagsView.selectedTitles forKey:kTags];
}

#pragma mark - UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickConfirmBtn:self.confirmBtn];
    
    return YES;
}

@end
