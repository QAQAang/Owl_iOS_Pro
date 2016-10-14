//
//  SubscribeViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeCell.h"

static NSString * const subscribeCell = @"subscribe";

@interface SubscribeViewController () <UITableViewDataSource>
@property (nonatomic, strong)UIButton *delBtn;
@property (nonatomic, strong)UIBarButtonItem *item;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation SubscribeViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBacgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNav];
    
    [self createTableView];
    
    [self createDelBtn];
}

- (void)createDelBtn
{
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    delBtn.backgroundColor = COLOR(254, 12, 12, 1.0);
    delBtn.layer.cornerRadius = 5;
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitle:@"删 除" forState:UIControlStateHighlighted];
    delBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, HEIGHTS - 15 * HEIGHTMAKE - 44 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    delBtn.hidden = YES;
    _delBtn = delBtn;
    [self.view addSubview:delBtn];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.rowHeight = 88 * HEIGHTMAKE;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor redColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, 0, WIDTHS, HEIGHTS);
    _tableView.contentInset = UIEdgeInsetsMake(STANDNAV(44), 0, 0, 0);
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[SubscribeCell class] forCellReuseIdentifier:subscribeCell];
}

- (void)setNav
{
    self.navigationItem.title = @"我的关注";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(modify)];
}

#pragma mark - 点击编辑
- (void)modify
{
    NSLog(@"modify");
    _item = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    _delBtn.hidden = NO;
    _tableView.contentInset = UIEdgeInsetsMake(STANDNAV(44), 0, 0, 0);
    _tableView.frame = CGRectMake(0, 0, WIDTHS, HEIGHTS - _tableView.rowHeight);
}

#pragma mark - 点击了删除
- (void)delBtnClick
{
    NSLog(@"点击了删除");
    self.navigationItem.rightBarButtonItem = _item;
    _delBtn.hidden = YES;
    _tableView.contentInset = UIEdgeInsetsMake(STANDNAV(44), 0, 0, 0);
    _tableView.frame = CGRectMake(0, 0, WIDTHS, HEIGHTS);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:subscribeCell];
    
    return cell;
}
@end
