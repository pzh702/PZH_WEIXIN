//
//  FriendsEditViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/25.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "FriendsEditViewController.h"
#import "FriendsEditCollectionViewCell.h"
#import <TZImagePickerController.h>
#import <AVFoundation/AVFoundation.h>
#import <TZImageManager.h>
#import <TZLocationManager.h>

static const NSInteger maxPhotoCount = 9;

@interface FriendsEditViewController ()<UIImagePickerControllerDelegate, TZImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

kStrong NSMutableArray<UIImage *> *selectedImages;
kStrong NSMutableArray<PHAsset *> *selectedAccest;
kStrong CLLocation *location;
kStrong UIImagePickerController *imagePickerVc;
kStrong UITextView *textView;

@end

@implementation FriendsEditViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观

            _imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];

        // 红色
        _imagePickerVc.navigationBar.tintColor = [UIColor redColor];
        UIBarButtonItem *tzBarItem, *BarItem;

            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];

        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ToolUtils addBarTitleWithTitle:@"确定" vc:self isLeft:NO action:@selector(clickConfirm) target:self];
    
    self.selectedAccest = [NSMutableArray array];
    self.selectedImages = [NSMutableArray array];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = KGrayColor.CGColor;
    _textView.textColor = KBlackColor;
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header.hidden = YES;
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.frame = CGRectMake(0, 250, KScreenWidth, 400);
    [self.collectionView registerClass:[FriendsEditCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FriendsEditCollectionViewCell class])];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}

- (void)clickConfirm
{
    FriendsCellModel *model = [FriendsCellModel new];
    model.avtarName = @"icon0.jpg";
    model.name = @"pzh_702";
    model.msg = self.textView.text;
    model.time = @"刚刚";
    model.imgsArr = [self.selectedImages copy];
    
    if (self.editCallBackBlock) {
        self.editCallBackBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertAction:(UIButton *)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    //相当于之前的[actionSheet show];
    actionSheet.popoverPresentationController.sourceView = sender;
    actionSheet.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)choosePhoto
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPhotoCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    if (maxPhotoCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = self.selectedAccest; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    //    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    kWeakSelf(self);
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        weakself.selectedImages = [NSMutableArray arrayWithArray:photos];
        weakself.selectedAccest = [NSMutableArray arrayWithArray:assets];
        
        [weakself.collectionView reloadData];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)takePhoto
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限 做一个友好的提示
        [MBProgressHUD showTipsText:@"请在iPhone的""设置-隐私-相机""中允许访问相机" time:1 superView:self.view];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        
        // 拍照之前还需要检查相册权限
    } else if (authStatus == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [MBProgressHUD showTipsText:@"请在iPhone的""设置-隐私-相机""中允许访问相机" time:1 superView:self.view];
        
    } else if (authStatus == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = locations.lastObject;
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        
        self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:self.imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *assets, NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (/* DISABLES CODE */ (NO)) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                            imagePicker.needCircleCrop = NO;
                            imagePicker.circleCropRadius = 100;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [self.selectedAccest addObject:asset];
    [self.selectedImages addObject:image];
    [self.collectionView reloadData];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}




#pragma mark    --collection delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsEditCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FriendsEditCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[FriendsEditCollectionViewCell alloc] init];
    }
    kWeakSelf(self)
    if (indexPath.item == self.selectedImages.count) {
        cell.photoImg = nil;
        cell.addBtnBlock = ^(UIButton *addBtn) {
            [weakself alertAction:addBtn];
        };
        cell.deleteBtnBlock = nil;
    } else {
        cell.photoImg = self.selectedImages[indexPath.item];
        cell.addBtnBlock = nil;
        cell.deleteBtnBlock = ^(UIImage *photoImg) {
            [weakself.selectedAccest removeObjectAtIndex:indexPath.item];
            [weakself.selectedImages removeObject:photoImg];
            [weakself.collectionView reloadData];
        };
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectedImages.count+1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/5, kScreenWidth/5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}



@end
