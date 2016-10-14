//
//  MineViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/28.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+YPExtension.h"
#import "UIView+YPFrameExtension.h"
#import "MineViewCell.h"
#import <MBProgressHUD.h>
#import "SettingViewController.h"
#import "SubscribeViewController.h"
#import "AccountManagerBtn.h"
#import "AccountMangerViewController.h"
#import "AccountSecurityViewController.h"
#import "BankViewController.h"
#import "LoginViewController.h"
#import "SalerAuthenViewController.h"
#import <AFNetworking.h>
#import "MinePublishViewController.h"


static NSString * const ID = @"mineCell";
@interface MineViewController ()
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, copy)NSString *noticeText;
@property (nonatomic, strong)UIView *logOutView;
@property (nonatomic, strong)UIView *logInView;
@property (nonatomic, strong)UILabel *nameLabel;
@end

@implementation MineViewController
- (UIView *)logIn{
    _logInView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 160)];
    _logInView.backgroundColor = COLOR(8, 181, 212, 1.0);
    //创建头像
    _icon = [[UIImageView alloc] init];
    _icon.bounds = CGRectMake(0, 0, 68 * WIDTHMAKE, 68 * HEIGHTMAKE);
    _icon.center = CGPointMake(60 * WIDTHMAKE, _logInView.height / 2);
    [_logInView addSubview:_icon];
    //创建昵称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_icon.frame) + 9 * WIDTHMAKE, 72.5 * HEIGHTMAKE, 0, 0);
    [_logInView addSubview:_nameLabel];
    
    //帐户管理
    AccountManagerBtn *btn = [[AccountManagerBtn alloc] initWithFrame:CGRectMake(300 * WIDTHMAKE, 90 * HEIGHTMAKE, 0, 0)];
    [btn addTarget:self action:@selector(accountManagerClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"更多账户"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"更多账户"] forState:UIControlStateHighlighted];
    NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
    norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    norAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"帐户管理" attributes:norAttr] forState:UIControlStateNormal];
    [btn sizeToFit];
    [_logInView addSubview:btn];
    return _logInView;
}

- (UIView *)logOut
{
    _logOutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 160)];
    _logOutView.backgroundColor = COLOR(8, 181, 212, 1.0);
    _icon = [[UIImageView alloc] init];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"icon.png"];
        [_icon setImage:[UIImage imageWithContentsOfFile:filePath]];
    } else {
        [_icon setImage:[UIImage imageWithCircle:@"默认头像"]];
    }
    _icon.bounds = CGRectMake(0, 0, 68 * WIDTHMAKE, 68 * HEIGHTMAKE);
    _icon.center = CGPointMake(60 * WIDTHMAKE, _logOutView.height / 2);
    [_logOutView addSubview:_icon];
    
    UIButton *loginRegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [loginRegisterBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"登录/注册" attributes:attr] forState:UIControlStateNormal];
    loginRegisterBtn.frame = CGRectMake(CGRectGetMaxX(_icon.frame) + 9 * WIDTHMAKE, 72.5 * HEIGHTMAKE, 0, 0);
    [loginRegisterBtn sizeToFit];
    [loginRegisterBtn addTarget:self action:@selector(loginRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [_logOutView addSubview:loginRegisterBtn];
    return _logOutView;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
#warning 先请求判断是否登录
    [super viewDidLoad];
    
    [self setTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"publish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"closePublish" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBarTintColor:COLOR(8, 181, 212, 1.0)];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18 * WIDTHMAKE];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark - setTableView
- (void)setTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:ID];

    self.tableView.tableHeaderView = [self logOut];
}


- (void)loginRegisterClick
{
    __weak typeof(self) weakSelf = self;
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    //QQ
    loginVc.qqBlock = ^(NSString *nickname, NSString *icon){
        
        weakSelf.tableView.tableHeaderView = [weakSelf logIn];
        
        _nameLabel.text = nickname;
        [_nameLabel sizeToFit];
        
        UIImage *imageIcon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon]]].circleImage;
        [weakSelf.icon setImage:imageIcon];
        //保存到沙盒
        NSData *imageData = UIImagePNGRepresentation(imageIcon);
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *totalPath = [documentPath stringByAppendingPathComponent:@"icon.png"];
        [imageData writeToFile:totalPath atomically:NO];
        
        [[NSUserDefaults standardUserDefaults] setValue:nickname forKeyPath:@"nickname"];
        [[NSUserDefaults standardUserDefaults] setValue:icon forKeyPath:@"icon"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    
    //手机号登录
    loginVc.changeHeaderBlock = ^(NSString *nickname, NSString *userID, NSString *phone, NSString *icon, NSString *pwd){
        
         weakSelf.tableView.tableHeaderView = [weakSelf logIn];
        
        _nameLabel.text = [NSString stringWithFormat:@"%@",nickname];
        [_nameLabel sizeToFit];
        
        [[NSUserDefaults standardUserDefaults] setValue:nickname forKeyPath:@"nickname"];
        [[NSUserDefaults standardUserDefaults] setValue:userID forKeyPath:@"userID"];
        [[NSUserDefaults standardUserDefaults] setValue:phone forKeyPath:@"phone"];
        [[NSUserDefaults standardUserDefaults] setValue:icon forKeyPath:@"icon"];
        [[NSUserDefaults standardUserDefaults] setValue:pwd forKeyPath:@"pwd"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                             @"text/html",
                                                             @"image/jpeg",
                                                             @"image/png",
                                                             @"application/octet-stream",
                                                             @"text/json", nil];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"path"] = icon;
        [manager POST:@"http://192.168.2.168:8080/file/download" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //设置头像
            UIImage *imageIcon = [UIImage imageWithData:responseObject].circleImage;
            [weakSelf.icon setImage:imageIcon];
            //保存到沙盒
            NSData *imageData = UIImagePNGRepresentation(imageIcon);
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *totalPath = [documentPath stringByAppendingPathComponent:@"icon.png"];
            [imageData writeToFile:totalPath atomically:NO];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    };
    
    [self.navigationController pushViewController:loginVc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的发布";
            cell.imageView.image = [UIImage imageNamed:@"发布"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"我的关注";
            cell.imageView.image = [UIImage imageNamed:@"关注"];
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"帐户安全";
            cell.imageView.image = [UIImage imageNamed:@"帐户安全"];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"我的银行卡";
            cell.imageView.image = [UIImage imageNamed:@"银行卡"];
        } else {
            cell.textLabel.text = @"商家认证";
            cell.imageView.image = [UIImage imageNamed:@"商家认证"];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"设置"];
        } else {
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"关于我们"];
        }
    } else {
        cell.textLabel.text = @"检查更新";
        cell.imageView.image = [UIImage imageNamed:@"检查更新"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 2) {
        MBProgressHUD *view = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        view.center = self.view.center;
        view.frame = CGRectMake(0, 0, 100, 100);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.center.x, view.center.y, 60, 30)];
        label.text = @"ing......";
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [view addSubview:label];
        
        [view hideAnimated:YES afterDelay:2];
        [self.view addSubview:view];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //跳转设置界面
            SettingViewController *settingVc = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
            settingVc.isLogOut = self.tableView.tableHeaderView == self.logOutView;
            settingVc.headerBlock = ^{
                [weakSelf.icon setImage:nil];
                weakSelf.tableView.tableHeaderView = [weakSelf logOut];
            };
            [self.navigationController pushViewController:settingVc animated:YES];
        } else {
            //跳转关于我们界面
        }
    } else {
        if (indexPath.row == 3) {
            //跳转帐户安全
            AccountSecurityViewController *accSecurityVc = [[AccountSecurityViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:accSecurityVc animated:YES];
        } else if (indexPath.row == 1) {
            //跳转我的关注
            SubscribeViewController *subVc = [[SubscribeViewController alloc] init];
            [self.navigationController pushViewController:subVc animated:YES];
        } else if (indexPath.row == 2) {
            //跳转银行卡
            BankViewController *bankVc = [[BankViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:bankVc animated:YES];
        } else if (indexPath.row == 4){
           //跳转商家认证
            SalerAuthenViewController *salerAuthenVc = [[SalerAuthenViewController alloc] init];
            [self.navigationController pushViewController:salerAuthenVc animated:YES];
        } else {
            //跳转我的发布
            MinePublishViewController *minePublish = [[MinePublishViewController alloc] init];
            [self.navigationController pushViewController:minePublish animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 10 * HEIGHTMAKE;
    }
}


#pragma mark - 更改状态栏
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


#pragma mark - 管理帐户
- (void)accountManagerClick
{
    AccountMangerViewController *accountVc = [[AccountMangerViewController alloc] init];
    accountVc.iconImage = self.icon.image;
    accountVc.changeNameBlock = ^(NSString *nickName){
        self.nameLabel.text = nickName;
        [self.nameLabel sizeToFit];
    };
    accountVc.changeIconBlock = ^(UIImage *icon){
        [self.icon setImage:icon.circleImage];
    };
    [self.navigationController pushViewController:accountVc animated:YES];
}

@end



