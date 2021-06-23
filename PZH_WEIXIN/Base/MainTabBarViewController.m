//
//  MainTabBarViewController.m
//  PZH_WEIXIN
//
//  Created by administrator on 2020/3/14.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "HomeViewController.h"
#import "MineTableViewController.h"
#import "ContactsTableViewController.h"
#import "DiscoverViewController.h"
#import "RootViewController.h"

#define kClass  @"rootVC"
#define kTitle  @"title"
#define kImage  @"image"
#define kImageH @"imageH"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *childItemsArray = @[
                                   @{kClass  : @"HomeViewController",
                                     kTitle  : @"微信",
                                     kImage  : @"tabbar_mainframe",
                                     kImageH : @"tabbar_mainframeH"},
    
                                   @{kClass  : @"ContactsTableViewController",
                                     kTitle  : @"通讯录",
                                     kImage  : @"tabbar_contacts",
                                     kImageH : @"tabbar_contactsH"},
    
                                   @{kClass  : @"DiscoverViewController",
                                     kTitle  : @"发现",
                                     kImage  : @"tabbar_discover",
                                     kImageH : @"tabbar_discoverH"},
    
                                   @{kClass  : @"MineTableViewController",
                                     kTitle  : @"我",
                                     kImage  : @"tabbar_me",
                                     kImageH : @"tabbar_meH"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[NSClassFromString(dict[kClass]) alloc] init];
//        vc.title = dict[kTitle];
        RootViewController *rootVC = [[RootViewController alloc] initWithRootViewController:vc];
        rootVC.tabBarItem.title = dict[kTitle];
        rootVC.tabBarItem.image = [UIImage imageNamed:dict[kImage]];
        [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(0, 190, 12)} forState:UIControlStateSelected];
        rootVC.tabBarItem.selectedImage = [[UIImage imageNamed:dict[kImageH]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:rootVC];
    }];
    
}



@end
