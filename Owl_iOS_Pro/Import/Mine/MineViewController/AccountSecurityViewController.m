//
//  AccountSecurityViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/8.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "MineViewCell.h"
#import "AuthenViewController.h"
#import "SettingSecurityViewController.h"
#import "UnbindViewController.h"

static NSString * const accountSecurityID = @"accountSecurityID";
@interface AccountSecurityViewController ()

@end

@implementation AccountSecurityViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self createTable];
    
}

- (void)createTable
{
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:accountSecurityID];
}


#pragma mark - createNav
- (void)createNav
{
    self.navigationItem.title = @"帐户安全";
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountSecurityID];
    if (indexPath.row == 0) {
        //实名认证
        cell.textLabel.text = @"实名认证";
    } else if (indexPath.row == 1) {
        //密保设置
        cell.textLabel.text = @"密保设置";
    } else if (indexPath.row == 2) {
        //手机解绑
        cell.textLabel.text = @"手机解绑";
    } else {
        //修改密码
        cell.textLabel.text = @"修改密码";
    }
    return cell;
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //实名认证
        AuthenViewController *authenVc = [[AuthenViewController alloc] init];
        [self.navigationController pushViewController:authenVc animated:YES];
    } else if (indexPath.row == 1) {
        //密保设置
        SettingSecurityViewController *ssVc = [[SettingSecurityViewController alloc] init];
        [self.navigationController pushViewController:ssVc animated:YES];
    } else if (indexPath.row == 2) {
        //手机解绑
        UnbindViewController *unbindVc = [[UnbindViewController alloc] init];
        [self.navigationController pushViewController:unbindVc animated:YES];
    } else {
        //修改密码
    }
}

@end
