//
//  MessageViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@property (nonatomic, copy)NSString *noticeText;
@end

@implementation MessageViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"publish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"closePublish" object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ([self.noticeText isEqualToString:@"publish"]) {
        return UIStatusBarStyleDefault;
    } else if ([self.noticeText isEqualToString:@"closePublish"]) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

#pragma mark - 监听通知
- (void)changeStatusBar:(id)sender
{
    self.noticeText = [sender valueForKeyPath:@"name"];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"publish" object:nil];
}

@end
