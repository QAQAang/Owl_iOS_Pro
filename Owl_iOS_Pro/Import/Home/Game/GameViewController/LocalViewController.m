//
//  LocalViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/6.
//  Copyright © 2016年 Aang. All rights reserved.
//
#define NETURL @"http://139.224.27.190:8080/Eyou/game/getByLetter"
#import "LocalViewController.h"
#import <AFNetworking.h>
#import "GameModel.h"
#import "Tools.h"
#import "PublishAccountViewController.h"
#import "PublishEquipmentViewController.h"
#import "PublishGoldViewController.h"
#import "PublishView.h"
typedef enum {
    EnumToGame=0,
    EnumToServer,
    EnumToAreas
}GameNSever;

@interface LocalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UIView *leftView;

@property (nonatomic, retain)UITableView *rightView;

@property (nonatomic, retain)NSMutableDictionary *gameDic;

@property (nonatomic, retain)NSMutableArray *letterArr;

@property (nonatomic, retain)NSMutableArray *serverArr;

@property (nonatomic, retain)NSMutableArray *areasArr;

@property (nonatomic, retain)UIButton *gameButton;

@property (nonatomic, retain)UIButton *qButton;

@property (nonatomic, retain)UIButton *fButton;

@property (nonatomic, assign)GameNSever seletEnum;

@property (nonatomic, copy)NSString *gameNameT;

@property (nonatomic, copy)NSString *serverNameT;

@property (nonatomic, copy)NSString *areasNameT;

@end

@implementation LocalViewController

-(NSMutableDictionary *)gameDic{
    if (_gameDic == nil) {
        _gameDic = [NSMutableDictionary dictionary];
    }
    return _gameDic;
}

- (NSMutableArray *)letterArr{
    if (_letterArr == nil) {
        _letterArr = [NSMutableArray array];
    }
    return _letterArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择服务器";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gameNameT = self.gameName;
    [self creatTableV];
    [self creatLeftView];
    [self creatButton];
    [self creatBar];
    if (_pick) {
        [self gameTaskData];
    }else{
        [self servertaskData:self.gameName SeverName:@""];
    }
}

- (void)gameTaskData{
    [Tools getRequestViewController:self FliterFrame:CGRectMake(3 / WIDTHS, 64, WIDTHS / 3 * 2, HEIGHTS - 64) NeedLoading:YES URL:NETURL Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        NSString *letter;
        for (int i = 0; i < array.count; i++) {
            if (![letter isEqualToString:[array[i] valueForKey:@"letter"]]) {
                NSMutableArray *arr = [NSMutableArray arrayWithObjects:array[i], nil];
                [self.gameDic setObject:arr forKey:[array[i] valueForKey:@"letter"]];
                letter = [array[i] valueForKey:@"letter"];
                [self.letterArr addObject:letter];
            }else{
                [[self.gameDic valueForKey:letter] addObject:array[i]];
            }
        }
        [self.rightView reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)servertaskData:(NSString *)gameName SeverName:(NSString *)severName{
    NSString *str;
    
    if ([severName isEqualToString:@""]) {
        str = [NSString stringWithFormat:@"http://192.168.2.168:8080/gameSpace/getSpace?game=%@", gameName];
    }else{
        str = [NSString stringWithFormat:@"http://192.168.2.168:8080/gameSpace/getServer?game=%@&space=%@", gameName, severName];
    }
    [Tools getRequestViewController:self FliterFrame:CGRectMake(WIDTHS / 3, 64, WIDTHS / 3 * 2, HEIGHTS - 64) NeedLoading:YES URL:str Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([severName isEqualToString:@""]) {
            self.serverArr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
            self.seletEnum = EnumToServer;
        }else{
            self.areasArr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
            
        }
        [self.rightView reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)creatBar{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    if (!(self.publishView == nil)) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatLeftView{
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS / 3, HEIGHTS - 64)];
    self.leftView.backgroundColor = [UIColor colorWithRed:242.f / 255 green:242.f / 255 blue:242.f / 255 alpha:1];
    [self.view addSubview:self.leftView];
}

- (void)creatButton{
    self.gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gameButton.layer.shadowOffset = CGSizeMake(0, 1);
    [self.gameButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
    self.gameButton.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [self.gameButton.titleLabel adjustsFontSizeToFitWidth];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS / 3, 50 * HEIGHTMAKE)];
    view1.tag = 1000;
    view1.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:view1];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 50 * HEIGHTMAKE, WIDTHS / 3, 50 * HEIGHTMAKE)];
    view2.tag = 1001;
    view2.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:view2];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 100 * HEIGHTMAKE, WIDTHS / 3, 50 * HEIGHTMAKE)];
    view3.tag = 1002;
    view3.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:view3];
    if (!_pick) {
        view1.backgroundColor = [UIColor whiteColor];
        self.gameButton.frame = CGRectMake(5 * WIDTHMAKE, 5 * HEIGHTMAKE, WIDTHS / 3 - 10 * WIDTHMAKE, 40 * HEIGHTMAKE);
        self.gameButton.backgroundColor = [UIColor whiteColor];
        [self.gameButton setTitle:self.gameName forState:UIControlStateNormal];
        self.gameButton.layer.borderWidth = 1;
        [self.gameButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        self.gameButton.layer.borderColor = self.tintColor.CGColor;
        self.gameButton.layer.cornerRadius = 5;
    }else{
        [self.gameButton addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.leftView addSubview:self.gameButton];
    self.qButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qButton.layer.shadowOffset = CGSizeMake(0, 1);
    [self.qButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
    self.qButton.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [self.qButton addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.qButton.titleLabel adjustsFontSizeToFitWidth];
    [self.leftView addSubview:self.qButton];
    self.fButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fButton.layer.shadowOffset = CGSizeMake(0, 1);
    [self.fButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
    self.fButton.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [self.fButton addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.fButton sizeToFit];
    [self.fButton.titleLabel adjustsFontSizeToFitWidth];
    [self.leftView addSubview:self.fButton];
}

- (void)clickRightBar{
    if ([self.fButton.titleLabel.text isEqualToString:@""] || self.fButton.titleLabel.text == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择未完成" message:@"请选择服务器" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else{
        if ([self.publishView isKindOfClass:[PublishView class]]) {
            if (self.index == 0) {
                //发布帐号
                PublishAccountViewController *accountVc = [[PublishAccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
                accountVc.gameNameT = self.gameNameT;
                accountVc.areasNameT = self.areasNameT;
                accountVc.serverNameT = self.serverNameT;
                [self.navigationController pushViewController:accountVc animated:YES];
            } else if (self.index == 1) {
                //发布游戏币
                PublishGoldViewController *goldVc = [[PublishGoldViewController alloc] initWithStyle:UITableViewStyleGrouped];
                goldVc.gameNameT = self.gameNameT;
                goldVc.areasNameT = self.areasNameT;
                goldVc.serverNameT = self.serverNameT;
                [self.navigationController pushViewController:goldVc animated:YES];
            } else {
                //发布装备
                PublishEquipmentViewController *equipVc = [[PublishEquipmentViewController alloc] initWithStyle:UITableViewStyleGrouped];
                equipVc.gameNameT = self.gameNameT;
                equipVc.areasNameT = self.areasNameT;
                equipVc.serverNameT = self.serverNameT;
                [self.navigationController pushViewController:equipVc animated:YES];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            self.serverStuff(self.gameNameT, self.serverNameT, self.areasNameT);
        }

    }
    
}

- (void)clickMethod:(UIButton *)button{
    if (button == self.gameButton) {
        self.qButton.frame = CGRectMake(0, 0, 0, 0);
        self.fButton.frame = CGRectMake(0, 0, 0, 0);
        self.gameButton.layer.borderWidth = 0;
        self.gameButton.layer.cornerRadius = 0;
        UIView *view2 = [self.view viewWithTag:1001];
        view2.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self.gameButton.layer.shadowOpacity = 0.5;
            [self.gameButton setTitle:@"选择游戏" forState:UIControlStateNormal];
            self.gameButton.layer.borderWidth = 0;
            [self.gameButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
            self.gameButton.frame = CGRectMake(0, 0, WIDTHS / 3, 50 * HEIGHTMAKE);
        } completion:^(BOOL finished) {
            self.pick = YES;
            self.seletEnum = EnumToGame;
            [self.rightView reloadData];
        }];
    }else if (button == self.qButton){
        self.fButton.frame = CGRectMake(0, 0, 0, 0);
        self.qButton.layer.borderWidth = 0;
        self.qButton.layer.cornerRadius = 0;
        [self.qButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
        UIView *view = [self.view viewWithTag:1000];
        view.backgroundColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.3 animations:^{
            self.qButton.layer.shadowOpacity = 0.5;
            [self.qButton setTitle:@"选择大区" forState:UIControlStateNormal];
            self.qButton.frame = CGRectMake(0, 50 * WIDTHMAKE, WIDTHS / 3, 50 * HEIGHTMAKE);
        } completion:^(BOOL finished) {
            self.seletEnum = EnumToServer;
            [self.rightView reloadData];
        }];
    }
}

- (void)creatTableV{
    self.rightView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTHS / 3, 64, WIDTHS / 3 * 2, HEIGHTS - 64) style:UITableViewStylePlain];
    self.rightView.delegate = self;
    self.rightView.dataSource = self;
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self.rightView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.rightView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.seletEnum == EnumToGame) {
        return self.gameDic.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.seletEnum == EnumToGame) {
        NSArray *array =  self.gameDic[self.letterArr[section]];
        return array.count;
    }else if (self.seletEnum == EnumToServer){
        return self.serverArr.count;
    }else{
        return self.areasArr.count;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.seletEnum == EnumToGame) {
        return self.letterArr;
    }else{
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.seletEnum == EnumToGame) {
        return self.letterArr[section];
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    cell.textLabel.textColor = COLOR(48, 48, 48, 1);
    if (self.seletEnum == EnumToGame) {
        cell.textLabel.text = [self.gameDic[self.letterArr[indexPath.section]][indexPath.row] valueForKey:@"name"];
    }else if (self.seletEnum == EnumToServer){
        cell.textLabel.text = self.serverArr[indexPath.row];
    }else{
        cell.textLabel.text = self.areasArr[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * HEIGHTMAKE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGRect cellIntableV = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellInBounds = [tableView convertRect:cellIntableV toView:self.view];
    if (self.seletEnum == EnumToGame) {
        self.gameButton.frame = cellInBounds;
        self.gameButton.backgroundColor = [UIColor whiteColor];
        self.gameNameT = [self.gameDic[self.letterArr[indexPath.section]][indexPath.row] valueForKey:@"name"];
        [self.gameButton setTitle:self.gameNameT forState:UIControlStateNormal];
        self.gameButton.layer.cornerRadius = 0;
        UIView *view = [self.view viewWithTag:1000];
        view.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self.gameButton.frame = CGRectMake(0, 0, WIDTHS / 3, 50 * HEIGHTMAKE);
            self.gameButton.layer.shadowColor = [UIColor grayColor].CGColor;
            self.gameButton.layer.shadowOpacity = 0.5;
            self.gameButton.layer.borderWidth = 0;
            [self.gameButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            self.seletEnum = EnumToServer;
            self.pick = NO;
            [self servertaskData:[self.gameDic[self.letterArr[indexPath.section]][indexPath.row] valueForKey:@"name"] SeverName:@""];
        }];
        
    }else if (self.seletEnum == EnumToServer){
        self.qButton.frame = cellInBounds;
        self.qButton.backgroundColor = [UIColor whiteColor];
        self.serverNameT = self.serverArr[indexPath.row];
        [self.qButton setTitle:self.serverNameT forState:UIControlStateNormal];
        self.qButton.layer.shadowColor = [UIColor grayColor].CGColor;
        [self.qButton setTitleColor:COLOR(48, 48, 48, 1) forState:UIControlStateNormal];
        self.qButton.layer.shadowOpacity = 0.5;
        self.qButton.layer.cornerRadius = 0;
        UIView *view = [self.view viewWithTag:1000];
        view.backgroundColor = [UIColor whiteColor];
        UIView *view2 = [self.view viewWithTag:1001];
        view2.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self.qButton.frame = CGRectMake(0, 50 * HEIGHTMAKE, WIDTHS / 3, 50 * HEIGHTMAKE);
            self.qButton.layer.borderWidth = 0;
            self.gameButton.frame = CGRectMake(5 * WIDTHMAKE, 5 * HEIGHTMAKE, WIDTHS / 3 - 10 * WIDTHMAKE, 40 * HEIGHTMAKE);
            self.gameButton.layer.shadowOpacity = 0;
            self.gameButton.layer.borderWidth = 1;
            self.gameButton.layer.borderColor = self.tintColor.CGColor;
            self.gameButton.layer.cornerRadius = 5;
            [self.gameButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            self.seletEnum = EnumToAreas;
            [self servertaskData:self.gameNameT SeverName:self.serverArr[indexPath.row]];
            [self.rightView reloadData];
        }];
    }else if (self.seletEnum == EnumToAreas){
        self.fButton.frame = cellInBounds;
        self.fButton.backgroundColor = [UIColor whiteColor];
        self.areasNameT = self.areasArr[indexPath.row];
        [self.fButton setTitle:self.areasNameT forState:UIControlStateNormal];
        self.fButton.layer.shadowColor = [UIColor grayColor].CGColor;
        self.fButton.layer.shadowOpacity = 0.5;
        self.fButton.layer.cornerRadius = 0;
        [self.qButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        UIView *view = [self.view viewWithTag:1000];
        view.backgroundColor = [UIColor whiteColor];
        UIView *view2 = [self.view viewWithTag:1001];
        view2.backgroundColor = [UIColor whiteColor];
        UIView *view3 = [self.view viewWithTag:1002];
        view3.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self.fButton.frame = CGRectMake(0, 100 * HEIGHTMAKE, WIDTHS / 3, 50 * HEIGHTMAKE);
            self.qButton.layer.shadowOpacity = 0;
            self.qButton.layer.borderWidth = 1;
            self.qButton.layer.borderColor = self.tintColor.CGColor;
            self.qButton.layer.cornerRadius = 5;
            self.qButton.frame = CGRectMake(5 * WIDTHMAKE, 50 * HEIGHTMAKE, WIDTHS / 3 - 10 * WIDTHMAKE, 40 * HEIGHTMAKE);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
