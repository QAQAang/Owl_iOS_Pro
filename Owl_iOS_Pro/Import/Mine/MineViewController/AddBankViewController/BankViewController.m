//
//  BankViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/9.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "BankViewController.h"
#import "AddBankCardViewController.h"
#import "BankCardCell.h"
#import <MJExtension/MJExtension.h>
#import "BankModel.h"

static NSString * const BankCardID = @"BankCardID";
@interface BankViewController ()
//保存银行卡数量
@property (nonatomic, copy)NSMutableArray *bankCardArray;
@property (nonatomic, copy)NSString *BackFourNum;
//保存银行卡模型
@property (nonatomic, copy)NSMutableArray *bankModelArray;
@end

@implementation BankViewController
- (NSMutableArray *)bankCardArray
{
    if (!_bankCardArray) {
        _bankCardArray = [NSMutableArray array];
    }
    return _bankCardArray;
}

- (NSMutableArray *)bankModelArray
{
    if (!_bankModelArray) {
        _bankModelArray = [NSMutableArray array];
    }
    return _bankModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self createTable];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBarTintColor:COLOR(8, 181, 212, 1.0)];
//}

#pragma mark - createNav
- (void)createNav
{
    self.view.backgroundColor = ViewBacgroundColor;
    self.navigationItem.title = @"我的银行卡";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBankClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - createTable
- (void)createTable
{
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
    self.tableView.rowHeight = 125 * HEIGHTMAKE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[BankCardCell class] forCellReuseIdentifier:BankCardID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.bankCardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:BankCardID];
    cell.bankModel = self.bankModelArray[indexPath.row];
    return cell;
}

#pragma mark - 添加银行卡
- (void)addBankClick
{
    __weak typeof(self) weakSelf = self;
    // 跳转添加银行卡
    AddBankCardViewController *addVc = [[AddBankCardViewController alloc] init];
    addVc.bankCardBlock = ^(NSMutableDictionary *bankDict){
        [weakSelf.bankCardArray addObject:bankDict];
        weakSelf.bankModelArray = [BankModel mj_objectArrayWithKeyValuesArray:weakSelf.bankCardArray];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:addVc animated:YES];
}
@end
