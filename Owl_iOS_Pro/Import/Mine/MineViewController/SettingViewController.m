//
//  SettingViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SettingViewController.h"
#import "MineViewCell.h"
#import "UIView+YPFrameExtension.h"
#import "UIButton+YPTextFieldButton.h"
#import "FeedBackViewController.h"
#import "MineViewController.h"


static NSString * const settingID = @"setting";
@interface SettingViewController ()
{
    BOOL _isMsgPush;
    
}

@property(nonatomic, strong)UIButton *button;
@end

@implementation SettingViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(242, 242, 242, 1.0);
    
    [self setNav];
    
    [self setTable];
    
    [self setButton];
    
    if (self.isLogOut) {
        self.button.hidden = YES;
    } else {
        self.button.hidden = NO;
    }
}

#pragma mark - 创建退出登录按钮
- (void)setButton
{
    UIButton *button = [UIButton buttonWithLoginRegisterNormalTitle:@"退出登录" highlightTitle:@"退出登录" addTarget:self action:@selector(logOutClick:)];
    button.frame = CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 20 * WIDTHMAKE, 44 * HEIGHTMAKE);
    button.centerX = self.view.centerX;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 44 *HEIGHTMAKE)];
    [view addSubview:button];
    self.button = button;
    self.tableView.tableFooterView = view;
}

#pragma mark - setNav
- (void)setNav
{
    self.navigationItem.title = @"设置";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - setTable
- (void)setTable
{
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10 * HEIGHTMAKE;
    //不设置tableHeaderView顶部会有一块空白区域
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:settingID];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID];
    cell.textLabel.font = [UIFont systemFontOfSize:17 * HEIGHTMAKE];
    cell.textLabel.textColor = COLOR(60, 60, 60, 1.0);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"意见反馈";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"清除缓存";
    } else {
        cell.textLabel.text = @"消息推送";
        UISwitch *sw = [[UISwitch alloc] init];
        [sw addTarget:self action:@selector(isMsgPush:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = sw;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //跳转意见反馈
        FeedBackViewController *fbVc = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:fbVc animated:YES];
    } else if (indexPath.row == 1) {
        //清除缓存
    }
}

#pragma mark - 消息推送
- (void)isMsgPush:(UISwitch *)sw
{
    _isMsgPush = sw.isOn;
    NSLog(@"%d",_isMsgPush);
}

#pragma mark - 注销
- (void)logOutClick:(UIButton *)btn
{
    //注销
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icon"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fastPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pwd"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    self.headerBlock();
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
