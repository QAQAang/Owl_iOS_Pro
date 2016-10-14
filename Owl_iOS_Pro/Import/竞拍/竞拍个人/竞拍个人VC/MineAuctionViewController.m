//
//  MineAuctionViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MineAuctionViewController.h"
#import "MineViewCell.h"
@interface MineAuctionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UIImageView *headImg;

@property (nonatomic, retain)UILabel *userName;

@property (nonatomic, retain)UITableView *tableV;

@end

@implementation MineAuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [self creatNav];
}

#pragma mark - 导航栏相关
- (void)creatNav{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110 * WIDTHMAKE, 100 * HEIGHTMAKE)];
    view.backgroundColor = [UIColor clearColor];
    self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(21 * WIDTHMAKE, 50 * HEIGHTMAKE, 68 * WIDTHMAKE, 68 * WIDTHMAKE)];
    self.headImg.layer.cornerRadius = 34 * WIDTHMAKE;
    self.headImg.image = [UIImage imageNamed:@"默认头像"];
    [view addSubview:self.headImg];
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 134 * HEIGHTMAKE, 110 * WIDTHMAKE, 14 * HEIGHTMAKE)];
    self.userName.text = @"123141413513";
    [view addSubview:self.userName];
    self.navigationItem.titleView = view;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect rect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x, rect.origin.y, [UIScreen mainScreen].bounds.size.width, 218 * HEIGHTMAKE);
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment: - 154 * HEIGHTMAKE forBarMetrics: UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundVerticalPositionAdjustment: - 154 * HEIGHTMAKE forBarMetrics: UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    CGRect rect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x, rect.origin.y, [UIScreen mainScreen].bounds.size.width, 44 * HEIGHTMAKE);
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment: 0 forBarMetrics: UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundVerticalPositionAdjustment: 0 forBarMetrics: UIBarMetricsDefault];
}

#pragma mark - tableView
- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 * HEIGHTMAKE, WIDTHS, HEIGHTS - 218) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = COLOR(227, 227, 227, 1);
    [self.tableV registerClass:[MineViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"竞拍中"];
            cell.textLabel.text = @"竞拍中";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"已拍下"];
            cell.textLabel.text = @"已拍下";
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"已结束"];
            cell.textLabel.text = @"已结束";
        }
    }else{
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"竞拍流程"];
            cell.textLabel.text = @"竞拍流程";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"保证金须知"];
            cell.textLabel.text = @"保证金须知";
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
