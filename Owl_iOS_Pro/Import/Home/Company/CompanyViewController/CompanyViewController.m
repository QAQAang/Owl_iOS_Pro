//
//  CompanyViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "CompanyViewController.h"
#import "SearchTextField.h"
#import "PickGameCell.h"
#import <AFNetworking.h>
#import "CompanyModel.h"
#import "GameViewController.h"
#import "Tools.h"
@interface CompanyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic ,retain) UIView *searchView;

@property (nonatomic, retain) SearchTextField *searchTF;

@property (nonatomic, retain) UICollectionView *contentView;

@property (nonatomic, retain) NSMutableArray *dataArr;

@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"选择游戏";
    [self.view endEditing:YES];
    [self creatView];
    [self taskData];
}

- (void)taskData{
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113) NeedLoading:YES URL:[NSString stringWithFormat:@"http://192.168.2.168:8080/game/getGameByCompany?company=%@", self.companyName] Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.dataArr = [CompanyModel getModel:arr];
        [self.contentView reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)creatView{
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, STANDNAV(self.navigationController.navigationBar.frame.size.height), WIDTHS, 39 * HEIGHTMAKE)];
    self.searchView.backgroundColor = COLOR(242, 242, 242, 1);
    [self.view addSubview:self.searchView];
    self.searchTF = [[SearchTextField alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 4 * HEIGHTMAKE, WIDTHS - 20 * WIDTHMAKE, 30 * HEIGHTMAKE) Text:@"搜索游戏名/商品名/关键词"];
    self.searchTF.backgroundColor = [UIColor whiteColor];
    self.searchTF.textColor = [UIColor blackColor];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    self.searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索游戏名/商品名/关键词" attributes:attr];
    [self.searchView addSubview:self.searchTF];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(162.5 * WIDTHMAKE, 118 * WIDTHMAKE);
    layout.sectionInset = UIEdgeInsetsMake(10 * HEIGHTMAKE, 20 * WIDTHMAKE, 0, 20 * WIDTHMAKE);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 15;
    self.contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, STANDNAV(self.navigationController.navigationBar.frame.size.height) + 39 * HEIGHTMAKE , WIDTHS, HEIGHTS - 49 - 35 * HEIGHTMAKE) collectionViewLayout:layout];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.dataSource = self;
    self.contentView.delegate = self;
    [self.contentView registerClass:[PickGameCell class] forCellWithReuseIdentifier:@"pick"];
    [self.view addSubview:self.contentView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PickGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pick" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GameViewController *gameVC = [[GameViewController alloc] init];
    gameVC.gameName = [self.dataArr[indexPath.row] valueForKey:@"name"];
    [self.navigationController pushViewController:gameVC animated:YES];
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
