//
//  GameViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/8.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GameViewController.h"
#import "GameTBCell.h"
#import "FilterView.h"
#import "GameModel.h"
#import <AFNetworking.h>
#import "LocalViewController.h"
#import "Tools.h"
#import "GoodsViewController.h"

@interface GameViewController ()<UITableViewDelegate, UITableViewDataSource, FilterViewDelegate>

@property (nonatomic, retain)UIView *pickView;

@property (nonatomic, retain)UITableView *tableV;

@property (nonatomic, retain)NSMutableArray *dataArr;

@property (nonatomic, retain)FilterView *filterView;

@property (nonatomic, retain)UITableView *equipmentTableV;

@property (nonatomic, retain)NSMutableArray *equipmentArr;

@property (nonatomic, retain)UIView *hudView;

@property (nonatomic, retain)UITextField *minText;

@property (nonatomic, retain)UITextField *maxText;

@property (nonatomic, copy)NSString *qStr;

@property (nonatomic, copy)NSString *fStr;

@property (nonatomic, retain)AFHTTPSessionManager *managerCompany;

@end

@implementation GameViewController

- (NSMutableArray *)equipmentArr{
    if (_equipmentArr == nil) {
        _equipmentArr = [NSMutableArray arrayWithObjects:@"武器",@"防具",@"首饰",@"宠物",@"材料", @"宝石", nil];
    }
    return _equipmentArr;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)setFStr:(NSString *)fStr{
    _fStr = fStr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"游戏商品";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatPickView];
    [self creatTableView];
    [self creatFilterView];
    [self dataTask];
}

- (void)dataTask{ 
    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/goods/screen?game=%@", self.gameName];
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 64) NeedLoading:YES URL:str Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.dataArr = [GameModel getModel:arr];
        [self.tableV reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 筛选栏
- (void)creatPickView{
    self.pickView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, 48 * HEIGHTMAKE)];
    self.pickView.backgroundColor = COLOR(242, 242, 242, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 31 * WIDTHMAKE, 29 * HEIGHTMAKE)];
    label.textColor = COLOR(77, 76, 76, 1);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    label.text = @"价格";
    [self.pickView addSubview:label];
    
    self.minText = [[UITextField alloc] initWithFrame:CGRectMake(53 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 48 * WIDTHMAKE, 29 * HEIGHTMAKE)];
    self.minText.borderStyle = UITextBorderStyleRoundedRect;
    [self.pickView addSubview:self.minText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(105 * WIDTHMAKE, 23.5 * HEIGHTMAKE, 21 * WIDTHMAKE, 1 * HEIGHTMAKE)];
    line.backgroundColor = COLOR(210, 210, 210, 1);
    [self.pickView addSubview:line];
    
    self.maxText = [[UITextField alloc] initWithFrame:CGRectMake(130 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 48 * WIDTHMAKE, 29 * HEIGHTMAKE)];
    self.maxText.borderStyle = UITextBorderStyleRoundedRect;
    [self.pickView addSubview:self.maxText];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    confirm.frame = CGRectMake(233 * WIDTHMAKE, 10.5 * HEIGHTMAKE, 45 * WIDTHMAKE, 28 * HEIGHTMAKE);
    [confirm addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    confirm.backgroundColor = COLOR(77, 76, 76, 1);
    confirm.layer.cornerRadius = 5;
    [self.pickView addSubview:confirm];
    
    UIButton *local = [UIButton buttonWithType:UIButtonTypeCustom];
    [local setTitle:@"选区" forState:UIControlStateNormal];
    [local setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    local.titleLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    local.frame = CGRectMake(320 * WIDTHMAKE, 10.5 * HEIGHTMAKE, 45 * WIDTHMAKE, 28 * HEIGHTMAKE);
    [local addTarget:self action:@selector(clickLocal) forControlEvents:UIControlEventTouchUpInside];
    local.backgroundColor = COLOR(2, 187, 146, 1);
    local.layer.cornerRadius = 5;
    [self.pickView addSubview:local];
    [self.view addSubview:self.pickView];
}

#pragma mark - tableView
- (void)creatTableView{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 48 * HEIGHTMAKE, WIDTHS, HEIGHTS - 64 - 97 * HEIGHTMAKE) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 88 * HEIGHTMAKE;
    self.tableV.backgroundColor = COLOR(248, 248, 248, 1);
    [self.tableV registerClass:[GameTBCell class] forCellReuseIdentifier:@"gameCell"];
    [self.view addSubview:self.tableV];
    self.hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113 * HEIGHTMAKE)];
    self.hudView.backgroundColor = COLOR(0, 0, 0, 0.6);
    self.hudView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHudView)];
    [self.hudView addGestureRecognizer:tap];
    [self.view addSubview:self.hudView];
    self.equipmentTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 49 * HEIGHTMAKE, WIDTHS, 1) style:UITableViewStylePlain];
    self.equipmentTableV.delegate = self;
    self.equipmentTableV.dataSource = self;
    self.equipmentTableV.rowHeight = 44 * HEIGHTMAKE;
    self.equipmentTableV.backgroundColor = COLOR(227, 227, 227, 1);
    [self.equipmentTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"equipment"];
    [self.hudView addSubview:self.equipmentTableV];
}

#pragma mark - 下方类tabBar筛选栏
- (void)creatFilterView{
    self.filterView = [[FilterView alloc] initWithFrame:CGRectMake(0, HEIGHTS, WIDTHS, 49 * HEIGHTMAKE)];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    
}

#pragma mark - 筛选栏协议方法
- (void)equipmentMethod{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hudView.alpha = 1;
        
        self.equipmentTableV.frame = CGRectMake(0, HEIGHTS - 249 * HEIGHTMAKE - 128, WIDTHS, 264 * HEIGHTMAKE);
    }];
}

#pragma mark - 蒙板轻拍方法
- (void)tapHudView{
    [UIView animateWithDuration:0.3 animations:^{
        self.hudView.alpha = 0;
        self.equipmentTableV.frame = CGRectMake(0, HEIGHTS - 49 * HEIGHTMAKE, WIDTHS, 1);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableV) {
        return self.dataArr.count;
    }else {
        return self.equipmentArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableV) {
        GameTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCell"];
        cell.model = self.dataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellStyleDefault;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"equipment"];
        cell.backgroundColor = COLOR(227, 227, 227, 1);
        cell.textLabel.text = self.equipmentArr[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16 * WIDTHMAKE];
        cell.selectionStyle = UITableViewCellStyleDefault;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableV) {
        // 下一页
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        GameModel *game = self.dataArr[indexPath.row];
        goods.clas = game.type;
        goods.goods = game;
        [self.navigationController pushViewController:goods animated:YES];
    }else{
        // 筛选请求
        __weak FilterView *weakFilterView = self.filterView;
        [weakFilterView firstRemove:weakFilterView];
    }
}

#pragma mark - 确定
- (void)clickConfirm{
    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/goods/screen&game=%@?min=%@?max=%@", self.gameName, self.minText.text, self.maxText.text];
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113) NeedLoading:YES URL:str Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.dataArr = [GameModel getModel:arr];
        [self.tableV reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma marl - 筛选方法


#pragma mark - 服务器
- (void)clickLocal{
    LocalViewController *localVC = [[LocalViewController alloc] init];
    localVC.gameName = self.gameName;
    localVC.tintColor = COLOR(43, 191, 217, 1);
    localVC.serverStuff = ^(NSString *gameName, NSString *serverName, NSString *areasName){
    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/goods/screen&game=%@?", self.gameName];
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113) NeedLoading:YES URL:str Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.dataArr = [GameModel getModel:arr];
        [self.tableV reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    };
    [self.navigationController pushViewController:localVC animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.filterView.frame = CGRectMake(0, HEIGHTS - 49 * HEIGHTMAKE, WIDTHS, 49 * HEIGHTMAKE);
    } completion:^(BOOL finished) {
    
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
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
