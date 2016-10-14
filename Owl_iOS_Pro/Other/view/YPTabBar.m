//
//  YPTabBar.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/20.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "YPTabBar.h"
#import "PublishView.h"
#import "UIView+YPFrameExtension.h"
#import "YPNavigationController.h"
#import "LocalViewController.h"

@interface YPTabBar ()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIButton *cancelView;

@end

@implementation YPTabBar
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

#pragma mark - 布局tabBar子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置发布按钮的位置
    [self.publishButton sizeToFit];
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonH = self.height;
    CGFloat tabBarButtonY = 0;
    int index = 0;
    //遍历设置tabBar位置
    for (UIView *tabBarBtn in self.subviews) {
        if (![tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) {
            tabBarButtonX += tabBarButtonW;
        }
        tabBarBtn.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        index++;
    }
}

#pragma mark - 点击发布
- (void)publishClick
{
    PublishView *publishView = [[PublishView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    publishView.switchBlock = ^(NSInteger index, UIView *publishView){
        LocalViewController *localVc = [[LocalViewController alloc] init];
        localVc.pick = YES;
        localVc.index = index;
        localVc.tintColor = COLOR(43, 191, 217, 1);
        localVc.publishView = publishView;
        [self.window.rootViewController presentViewController:[[YPNavigationController alloc] initWithRootViewController:localVc] animated:YES completion:nil];
    };
    [self.window addSubview:publishView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"publish" object:nil userInfo:nil];
}
@end
