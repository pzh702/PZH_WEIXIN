//
//  DiscoverViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/18.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "DiscoverViewController.h"
#import "TagViewController.h"
#import "FriendsViewController.h"
#import "WeatherViewController.h"
#import "PZH_WEIXIN-Swift.h"
#import "ImageEditViewController.h"

#define kTitle  @"title"
#define kClass  @"destVC"
#define kLeftImg    @"leftImage"
#define kRightImg   @"rightImage"

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)setupData
{
    self.dataArr = [NSMutableArray new];
    NSArray *sectionOne =@[@{kTitle:@"朋友圈",kClass:@"FriendsViewController",kLeftImg:@"pengyouquan",kRightImg:@""}];
    NSArray *sectionTwo =@[@{kTitle:@"扫一扫",kClass:@"",kLeftImg:@"saoyisao",kRightImg:@""},@{kTitle:@"摇一摇",kClass:@"",kLeftImg:@"yaoyiyao",kRightImg:@""}];
    NSArray *sectionThree =@[@{kTitle:@"漂流瓶",kClass:@"",kLeftImg:@"piaoliuping",kRightImg:@""},@{kTitle:@"附近",kClass:@"",kLeftImg:@"fujin",kRightImg:@""}];
    NSArray *sectionFour =@[@{kTitle:@"天气查询",kClass:@"WeatherViewController",kLeftImg:@"",kRightImg:@""},@{kTitle:@"自定义标签",kClass:@"TagViewController",kLeftImg:@"",kRightImg:@""},@{kTitle:@"Swift测试",kClass:@"SwiftViewController",kLeftImg:@"",kRightImg:@""},@{kTitle:@"图片处理",kClass:@"ImageEditViewController",kLeftImg:@"",kRightImg:@""}];
    
    [self.dataArr addObject:sectionOne];
    [self.dataArr addObject:sectionTwo];
    [self.dataArr addObject:sectionThree];
    [self.dataArr addObject:sectionFour];
}

- (void)initUI
{
    [ToolUtils addBarTitleWithTitle:@"发现" vc:self isLeft:YES action:nil target:self];
    [ToolUtils addBarImgWithImg:@"add" vc:self isLeft:NO action:@selector(clickAddBtn) target:self];
    
    self.tableView.mj_footer.hidden = YES;
    self.tableView.mj_header.hidden = YES;
    self.tableView.tableFooterView.backgroundColor = KGrayColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = KGrayColor;
//    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (void)clickAddBtn
{
    NSLog(@"扫一扫");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *model = self.dataArr[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model[kLeftImg]];
    cell.textLabel.text = model[kTitle];
    
    NSArray *sectionArr = self.dataArr[indexPath.section];
    if (indexPath.section == self.dataArr.count-1 && indexPath.row == sectionArr.count-1) {//去除最后一条cell的分割线
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(cell.bounds));
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArr = self.dataArr[section];
    return sectionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArr.count-1) {
        return 0.5;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *model = self.dataArr[indexPath.section][indexPath.row];
    UIViewController *destVC = [[NSClassFromString(model[kClass]) alloc] init];
    if ([model[kClass] containsString:@"Swift"]) {
//         destVC = NSClassFromString(model[kClass]).init();
        destVC = [[SwiftViewController alloc] init];
    }
    if (destVC) {
        [self.navigationController pushViewController:destVC animated:YES];
    }
}


@end
