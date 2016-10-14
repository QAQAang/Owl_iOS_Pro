//
//  AccountHomeViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/19.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountHomeViewController.h"
#import "MineViewCell.h"
#import "UIImage+YPExtension.h"
#import "NickNameViewController.h"
#import "InfoViewController.h"
#import "PublishFooterView.h"
#import "UIView+YPFrameExtension.h"
#import <AFNetworking.h>

static NSString * const ID = @"mineCell";
@interface AccountHomeViewController () <UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong)UITextField *nickNameField;
@end

@implementation AccountHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createTable];
}

#pragma mark - table
- (void)createTable
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.scrollEnabled = YES;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 23 * HEIGHTMAKE;
    self.tableView.rowHeight = 44 * HEIGHTMAKE;
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
    
    //footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 100)];
    UITextView *descText = [[UITextView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 20 * WIDTHMAKE, 90 * HEIGHTMAKE)];
    descText.layer.cornerRadius = 3 * WIDTHMAKE;
    descText.delegate = self;
    [footer addSubview:descText];
    self.tableView.tableFooterView = footer;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的昵称";
        UITextField *nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WIDTHS - 100 * WIDTHMAKE, cell.contentView.height)];
        nickNameField.textAlignment = NSTextAlignmentRight;
        nickNameField.text = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"nickname"];
        nickNameField.textColor = COLOR(60, 60, 60, 1.0);
        nickNameField.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
        nickNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        nickNameField.returnKeyType = UIReturnKeyDone;
        nickNameField.delegate = self;
        cell.accessoryView = nickNameField;
        self.nickNameField = nickNameField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"我的隐私";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"成交量";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.textLabel.text = @"信用等级";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        //我的隐私
        InfoViewController *infoVc = [[InfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:infoVc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *personLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 23 * HEIGHTMAKE)];
    personLabel.text = @"     个人简介";
    personLabel.textColor = COLOR(80, 80, 80, 1.0);
    personLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    return personLabel;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField == self.nickNameField) && ([[NSUserDefaults standardUserDefaults] valueForKeyPath:@"accessToken"])) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
#warning 返回应该提交一次请求
    __weak typeof(self) weakSelf = self;
    if (textField == self.nickNameField) {
        //请求修改昵称
        [self.nickNameField resignFirstResponder];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"id"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"];
        param[@"nickname"] = self.nickNameField.text;
        
        [manager POST:@"http://192.168.2.168:8080/user/perfect" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //修改昵称成功后更改个人昵称
            weakSelf.changeNickNameBlock(weakSelf.nickNameField.text);
            
            [[NSUserDefaults standardUserDefaults] setValue:weakSelf.nickNameField.text forKeyPath:@"nickname"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    
}

@end
