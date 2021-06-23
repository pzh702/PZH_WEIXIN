//
//  HomeViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeUtils.h"
#import "HomeTableViewCell.h"

#define kRandomCount    20
#define kRedDotCount    5

static NSInteger redDotCount;

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *redDotArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray new];
    self.redDotArr = [NSMutableArray new];
    redDotCount = 0;
    // Do any additional setup after loading the view.
    [self setupDataWithCount:kRandomCount];
    [self setupRedDotWithCount:kRandomCount];
    [self initUI];
    
}

- (void)setupDataWithCount:(NSInteger)count
{
    for (NSInteger i=0; i<=count; i++) {
        HomeModel *model = [HomeUtils getRandomData];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

- (void)setupRedDotWithCount:(NSInteger)count
{
    for (NSInteger i=0; i<=kRedDotCount; i++) {
        //在reddotcount和reddotcount+count之间生成随机数
        int index = (int)(redDotCount + (arc4random() % (count+1)));
        [self.redDotArr addObject:[NSNumber numberWithInt:index]];
    }
    redDotCount += count;
    [self.tableView reloadData];
}

- (void)initUI
{
    [ToolUtils addBarTitleWithTitle:@"微信" vc:self isLeft:YES action:nil target:self];
    [ToolUtils addBarImgWithImg:@"add" vc:self isLeft:NO action:@selector(clickAddBtn) target:self];
    
//    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (void)clickAddBtn
{
    
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        [MBProgressHUD showTipsText:@"加载失败,请检查你的网络设置" time:1 superView:self.view];
    });
}

- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        
        [self setupDataWithCount:20];
        [self setupRedDotWithCount:20];
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTableViewCell"];
    }
    //这里要注意，刷新添加新数据后，从缓存池里取出的cell可能是有红点的，如果此处不初始化为no，多次刷新后整个tabbleview的cell都会是带红点的
    cell.showRedDot = NO;
    cell.homeModel = self.dataArr[indexPath.row];
    if ([self.redDotArr containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        cell.showRedDot = YES;
    }
    cell.deleteBlock = ^{
      [self.dataArr removeObjectAtIndex:indexPath.row];
      [self.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
        //这里不刷新的话，从第二次开始就会删除的是下一行的cell，
      [self.tableView reloadData];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.dataArr removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
//    }
//}

@end
