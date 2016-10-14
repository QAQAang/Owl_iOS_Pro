//
//  YPNavigationController.m
//  Game
//
//  Created by 王艳平 on 16/7/18.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "YPNavigationController.h"
#import "PrefixHeader.pch"
@interface YPNavigationController ()

@end

@implementation YPNavigationController

#pragma mark - 初始化
+ (void)initialize
{
    //设置导航栏属性
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17 * WIDTHMAKE];
    attr[NSForegroundColorAttributeName] = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    [bar setBarTintColor:[UIColor colorWithRed:8 / 255.0 green:181 / 255.0 blue:212 / 255.0 alpha:1.0]];
    [bar setTitleTextAttributes:attr];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *highAttr = [NSMutableDictionary dictionary];
    highAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    highAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [item setTitleTextAttributes:highAttr forState:UIControlStateHighlighted];
}

#pragma mark - 设置导航条-返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >= 1) {
        //创建返回按钮
        UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];        
        [backItem setImage:[UIImage imageNamed:@"nav_back_icon"] forState:UIControlStateNormal];
        [backItem setImage:[UIImage imageNamed:@"nav_back_icon"] forState:UIControlStateHighlighted];
        [backItem setFrame:CGRectMake(0, 0, 36 * WIDTHMAKE, 36 * WIDTHMAKE)];
        [backItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backItem.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark - back
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 控制状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
@end
