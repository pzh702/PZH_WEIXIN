//
//  FriendsViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/19.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsHeaderView.h"
#import "FridendsTableViewCell.h"
#import "FriendsEditViewController.h"
#import "GKPhotoBrowser.h"

@interface FriendsViewController () <UITableViewDelegate,UITableViewDataSource,GKPhotoBrowserDelegate>

kStrong NSMutableArray *dataArr;
kStrong FriendsEditViewController *editVC;
kStrong UIPageControl *pageControl;
kWeak GKPhotoBrowser *browser;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray new];
    [self setupDataWithCount:10];
    [self initSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)initSubViews
{
    [ToolUtils addBarTitleWithTitle:@"发布" vc:self isLeft:NO action:@selector(clickCamera) target:self];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 80;
    
    FriendsHeaderView *headerView = [[FriendsHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 260)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FridendsTableViewCell class] forCellReuseIdentifier:@"FridendsTableViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)clickCamera
{
    self.editVC = [[FriendsEditViewController alloc] init];
    kWeakSelf(self);
    self.editVC.editCallBackBlock = ^(FriendsCellModel * _Nonnull model) {
        [weakself.tableView scrollToTop];
        [weakself.dataArr insertObject:model atIndex:0];
        [weakself.tableView reloadData];
    };
    [self.navigationController pushViewController:self.editVC animated:YES];
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    [self setupDataWithCount:10];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    });
}

- (void)setupDataWithCount:(NSInteger)count
{
    NSArray *avtarImgNamesArr = @[@"icon0.jpg",
    @"icon1.jpg",
    @"icon2.jpg",
    @"icon3.jpg",
    @"icon4.jpg",
    ];
    NSArray *namesArr = @[@"pzh_702",
    @"蔡徐坤",
    @"孙笑川",
    @"臭弟弟",
    @"特朗普"];
    NSArray *msgArr = @[@"黄色的树林里分出两条路，可惜我不能同时去涉足，我在那路口久久伫立，我向着一条路极目望去，直到它消失在丛林深处。但我却选了另外一条路，它荒草萋萋，十分幽寂，显得更诱人、更美丽，虽然在这两条小路上，都很少留下旅人的足迹，虽然那天清晨落叶满地，两条路都未经脚印污染。呵，留下一条路等改日再见！但我知道路径延绵无尽头，恐怕我难以再回返。也许多少年后在某个地方，我将轻声叹息把往事回顾，一片树林里分出两条路，而我选了人迹更少的一条，从此决定了我一生的道路。",
    @"★タクシー代がなかったので、家まで歩いて帰った。★もし事故が発生した场所、このレバーを引いて列车を止めてください。（丁）为了清楚地表示出一个短语或句节，其后须标逗号。如：★この薬を、夜寝る前に一度、朝起きてからもう一度、饮んでください。★私は、空を飞ぶ鸟のように、自由に生きて行きたいと思った。*****为了清楚地表示词语与词语间的关系，须标逗号。标注位置不同，有时会使句子的意思发生变化。如：★その人は大きな音にびっくりして、横から飞び出した子供にぶつかった。★その人は、大きな音にびっくりして横から飞び出した子供に、ぶつかった。",
    @"AFNetworking is a delightful networking library for iOS and Mac OS X.",
    @"Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler",
    @"Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; Then took the other, as just as fair, And having perhaps the better claim, Because it was grassy and wanted wear; Though as for that the passing there Had worn them really about the same, And both that morning equally lay In leaves no step had trodden black. Oh, I kept the first for another day! Yet knowing how way leads on to way, I doubted if I should ever come back. I shall be telling this with a sigh Somewhere ages and ages hence: Two roads diverged in a wood, and I- I took the one less traveled by, And that has made all the difference. "
    ];
    NSArray *timesArr = @[@"昨天下午",@"11:20",@"3月1日",@"21:03",@"3月15日",@"刚刚",@"1分钟前",@"10分钟前",@"今天"];
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
    @"pic1.jpg",
    @"pic2.jpg",
    @"pic3.jpg",
    @"pic4.jpg",
    @"pic5.jpg",
    @"pic6.jpg",
    @"pic7.jpg",
    @"pic8.jpg"
    ];
    for (NSInteger i = 0; i<count; i++) {
        int avtarRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int msgRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(5);
        
        FriendsCellModel *model = [FriendsCellModel new];
        model.avtarName = avtarImgNamesArr[avtarRandomIndex];
        model.name = namesArr[nameRandomIndex];
        model.msg = msgArr[msgRandomIndex];
        model.time = timesArr[timeRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray<UIImage *> *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:[UIImage imageNamed:picImageNamesArray[randomIndex]]];
        }
        if (temp.count) {
            model.imgsArr = [temp copy];
        }
        
        [self.dataArr addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FridendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridendsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FridendsTableViewCell"];
    }
    cell.indexPath = indexPath;
    cell.clickMoreBtnBlock = ^(NSIndexPath * _Nonnull indexPath) {
        FriendsCellModel *model = self.dataArr[indexPath.row];
        model.isShowed = !model.isShowed;
        [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
    };
	
    cell.photosClickBlock = ^(FridendsTableViewCell * _Nonnull viewCell, NSInteger index) {
        NSMutableArray *photos = [NSMutableArray new];
        [viewCell.model.imgsArr enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GKPhoto *photo = [GKPhoto new];
            photo.sourceImageView = viewCell.photoView.subviews[idx];
//            photo.image = obj;
//            photo.imageView = viewCell.photoView.subviews[idx];
            [photos addObject:photo];
        }];

        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = photos.count;
        self.pageControl.currentPage = index;
        self.pageControl.hidesForSinglePage = YES;
        
        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
        browser.showStyle = GKPhotoBrowserShowStyleZoom;        // 缩放显示
        browser.hideStyle = GKPhotoBrowserHideStyleZoomScale;   // 缩放隐藏
        browser.loadStyle = GKPhotoBrowserLoadStyleIndeterminateMask; // 不明确的加载方式带阴影
        browser.maxZoomScale = 4.0f;
        browser.doubleZoomScale = 2.0f;
        
        [browser setupCoverViews:@[self.pageControl] layoutBlock:^(GKPhotoBrowser * _Nonnull photoBrowser, CGRect superFrame) {
           CGFloat pointY = 0;
            if (photoBrowser.isLandspace) {
                pointY = superFrame.size.height - 20;
            }else {
                pointY = superFrame.size.height - 10 - (KIsiPhoneX ? kSafeBottomSpace : 0);
            }

            self.pageControl.center = CGPointMake(superFrame.size.width * 0.5, pointY);
        }];
        browser.delegate = self;
        [browser showFromVC:self];
        self.browser = browser;
    };
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsCellModel *model = self.dataArr[indexPath.row];
    CGFloat height = model.photoHeight+10;
    if (model.isShowed) {
        return model.showMore?model.msgMaxHeight+88+5+height:model.msgMaxHeight+88+5+height;
    } else {
        return model.showMore?model.msgHeight+88+5+height:model.msgHeight+88+5+height;
    }
}

#pragma mark    --GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser didChangedIndex:(NSInteger)index{
    self.pageControl.currentPage = index;
}

- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index{
    
}

@end
