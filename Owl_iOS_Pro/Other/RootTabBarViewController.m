//
//  RootTabBarViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"

#import "MessageViewController.h"
#import "MineViewController.h"
#import "YPNavigationController.h"
#import "YPTabBar.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tabbar子控制器
    [self setupChildViewController];
    
    //设置tabbar字体属性
    [self setupTextAttrs];

}

#pragma mark - 添加tabbar子控制器
- (void)setupChildViewController
{
#warning !!!
    //首页
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    self.homeVc = homeVc;
    [self setupOneChildViewController:homeVc image:@"首页" selImage:@"首页blue" title:@"首页"];
    //我的
    MineViewController *mineVc = [[MineViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.mineVc = mineVc;
    [self setupOneChildViewController:mineVc image:@"个人" selImage:@"个人blue" title:@"个人"];
    //订单
    OrderViewController *orderVc = [[OrderViewController alloc] init];
    self.orderVc = orderVc;
    [self setupOneChildViewController:orderVc image:@"订单" selImage:@"订单blue" title:@"订单"];
    //客服
    MessageViewController *messageVc = [[MessageViewController alloc] init];
    self.messageVc = messageVc;
    [self setupOneChildViewController:messageVc image:@"客服" selImage:@"客服blue" title:@"客服"];
    
    //添加发布按钮
    [self setValue:[[YPTabBar alloc] init] forKeyPath:@"tabBar"];
}

#pragma mark - 添加一个子控制器
- (void)setupOneChildViewController:(UIViewController *)vc image:(NSString *)image selImage:(NSString *)selImage title:(NSString *)title
{
    YPNavigationController *nav = [[YPNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:nav];
}

#pragma mark - 设置tabbar字体属性
- (void)setupTextAttrs
{
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //normal
    NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
    norAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:140 / 255.0 green:140 / 255.0 blue:140 / 255.0 alpha:1.0];
    norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:norAttr forState:UIControlStateNormal];
    
    //selcted
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    selAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:8 / 255.0 green:181 / 255.0 blue:212 / 255.0 alpha:1.0];
    selAttr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:selAttr forState:UIControlStateSelected];
}

@end
