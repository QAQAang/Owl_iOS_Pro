//
//  InfoViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "InfoViewController.h"
#import "MineViewCell.h"
#import "UIImage+YPExtension.h"

static NSString * const infoID = @"info";
@interface InfoViewController ()
@property (nonatomic, copy)NSMutableArray *firstSection;
@end

@implementation InfoViewController
#pragma mark - lazy
- (NSMutableArray *)firstSection
{
    if (!_firstSection) {
        _firstSection = [NSMutableArray arrayWithObjects:@"真实姓名", @"身份证号", @"银行卡号", @"手机号码" , nil];
    }
    return _firstSection;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setTable];
    
    self.view.backgroundColor = COLOR(242, 242, 242, 1.0);
}


#pragma  mark - 导航栏信息
- (void)setNav
{
    self.navigationItem.title = @"我的隐私";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - table
- (void)setTable
{
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10 * HEIGHTMAKE;
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:infoID];
}

#pragma mark - UITableViewataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.firstSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoID];
    cell.textLabel.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    cell.textLabel.textColor = COLOR(60, 60, 60, 1.0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell = [[MineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoID];
        cell.textLabel.text = self.firstSection[indexPath.row];
        cell.detailTextLabel.text = @"AKiTa";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row ==1) {
        cell = [[MineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoID];
        cell.textLabel.text = self.firstSection[indexPath.row];
        cell.detailTextLabel.text = @"510000000000000000";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == 2) {
        cell = [[MineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoID];
        cell.textLabel.text = self.firstSection[indexPath.row];
        cell.detailTextLabel.text = @"6228888888888888888";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell = [[MineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoID];
        cell.textLabel.text = self.firstSection[indexPath.row];
        cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"phone"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == 1) {
//        //身份证认证
//        AuthenViewController *authenVc = [[AuthenViewController alloc] init];
//        [self.navigationController pushViewController:authenVc animated:YES];
//    } else if (indexPath.row == 2) {
//        //银行卡绑定
//    }
//}
@end
