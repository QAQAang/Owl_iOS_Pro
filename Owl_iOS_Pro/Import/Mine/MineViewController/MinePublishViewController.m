//
//  MinePublishViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MinePublishViewController.h"
#import "Tools.h"
#import "MinePublishCell.h"
#import "GameModel.h"

@interface MinePublishViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy)NSMutableArray *publishArr;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MinePublishViewController
- (NSMutableArray *)publishArr
{
    if (!_publishArr) {
        _publishArr = [NSMutableArray array];
    }
    return _publishArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self createTable];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"];
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, STANDNAV(44), WIDTHS, HEIGHTS - STANDNAV(44)) NeedLoading:YES URL:@"http://192.168.2.168:8080/goods/getGoodsByUser" Parameters:param Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.publishArr = [GameModel getModel:responseObject[@"data"]];
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)createNav
{
    self.navigationItem.title = @"我的发布";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = ViewBacgroundColor;
}

- (void)createTable
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(STANDNAV(44), 0, 0, 0);
    tableView.rowHeight = 120;
    [tableView registerClass:[MinePublishCell class] forCellReuseIdentifier:@"publish"];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.publishArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MinePublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publish"];
    cell.model = self.publishArr[indexPath.row];
    return cell;
}
@end
