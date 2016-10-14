//
//  HomeViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#define COMPANYURL @"http://192.168.2.168:8080/company/homepage"
#define GAMEURL @"http://192.168.2.168:8080/game/homepage"

#import "HomeViewController.h"
#import <AFNetworking.h>
#import "HomeGameModel.h"
#import "HomeCompanyModel.h"
#import "CompanyItem.h"
#import "HotGameItem.h"
#import "SearchViewController.h"
#import "SearchTextField.h"
#import "UIView+YPFrameExtension.h"
#import "CompanyViewController.h"
#import "GameViewController.h"
#import "Tools.h"
#import "OutLineView.h"

static NSString * CompanyID = @"company";
static NSString * HotGameID = @"hotgame";
@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

{
    UIScrollView *_scrolView;
}

@property (nonatomic, retain)UICollectionView *titleCollection;

@property (nonatomic, retain)UICollectionView *contentCollection;

@property (nonatomic, retain)NSMutableArray *titleArr;

@property (nonatomic, retain)NSMutableArray *contentArr;

@property (nonatomic, copy)NSString *noticeText;

@end

@implementation HomeViewController

- (NSMutableArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)contentArr{
    if (_contentArr == nil) {
        _contentArr = [NSMutableArray array];
    }
    return _contentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatScrollView];
    [self creatView];
    [self setNav];
    [self taskData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"publish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"closePublish" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:COLOR(8, 181, 212, 1.0)];
}

- (void)taskData{
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113) NeedLoading:YES URL:COMPANYURL Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {

        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.titleArr = [HomeCompanyModel getModel:arr];
        [self.titleCollection reloadData];
        
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 113) NeedLoading:NO URL:GAMEURL Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [[NSMutableDictionary dictionaryWithDictionary:responseObject] valueForKey:@"data"];
        self.contentArr = [HomeGameModel getModel:arr];
        [self.contentCollection reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OutLineView *outLine = [[OutLineView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 64, WIDTHS, HEIGHTS - 113)];
        [self.view addSubview:outLine];
    }];
}

- (void)creatScrollView
{
    _scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS - 49)];
    _scrolView.contentSize = CGSizeMake(0, 850 * HEIGHTMAKE);
    _scrolView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrolView];
}

- (void)creatView{
    UICollectionViewFlowLayout *titleLayout = [[UICollectionViewFlowLayout alloc] init];
    titleLayout.itemSize = CGSizeMake(60 * WIDTHMAKE, 86 * HEIGHTMAKE);
    titleLayout.minimumLineSpacing = 8 * HEIGHTMAKE;
    titleLayout.minimumInteritemSpacing = 30 * HEIGHTMAKE;
    titleLayout.sectionInset = UIEdgeInsetsMake(15 * HEIGHTMAKE, 9.5 * WIDTHMAKE, 15 * HEIGHTMAKE, 9.5 * WIDTHMAKE);
    self.titleCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, 260 * HEIGHTMAKE) collectionViewLayout:titleLayout];
    self.titleCollection.backgroundColor = [UIColor whiteColor];
    self.titleCollection.delegate = self;
    self.titleCollection.dataSource = self;
    [self.titleCollection registerClass:[CompanyItem class] forCellWithReuseIdentifier:CompanyID];
    [_scrolView addSubview:self.titleCollection];
    
    UILabel *gameTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 260 * HEIGHTMAKE, WIDTHS, 38 * HEIGHTMAKE)];
    gameTitle.text = @"  热门游戏";
    gameTitle.textColor = COLOR(80, 80, 80, 1.0);
    gameTitle.font = [UIFont systemFontOfSize:17 * WIDTHMAKE];
    gameTitle.backgroundColor = [UIColor colorWithRed:242.f / 255.f green:242.f / 255.f blue:242.f / 255.f alpha:1];
    [_scrolView addSubview:gameTitle];
    
    UICollectionViewFlowLayout *contentLayout = [[UICollectionViewFlowLayout alloc] init];
    contentLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    contentLayout.minimumLineSpacing = 0.5 * HEIGHTMAKE;
    contentLayout.minimumInteritemSpacing = 0.5 * WIDTHMAKE;
    contentLayout.itemSize = CGSizeMake(WIDTHS / 2 - 0.5 * WIDTHMAKE, 110 * HEIGHTMAKE);
    self.contentCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 298 * HEIGHTMAKE, WIDTHS, 552 * HEIGHTMAKE) collectionViewLayout:contentLayout];
    self.contentCollection.backgroundColor = [UIColor whiteColor];
    self.contentCollection.delegate = self;
    self.contentCollection.dataSource = self;
    self.contentCollection.bounces = NO;
    [self.contentCollection registerClass:[HotGameItem class] forCellWithReuseIdentifier:HotGameID];
    [_scrolView addSubview:self.contentCollection];
}

#pragma mark -collection协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.titleCollection) {
        return self.titleArr.count;
    } else {
        return self.contentArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.titleCollection) {
        CompanyItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:CompanyID forIndexPath:indexPath];
        item.model = self.titleArr[indexPath.row];
        return item;
    } else {
        HotGameItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:HotGameID forIndexPath:indexPath];
        item.model = self.contentArr[indexPath.row];
        return item;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.titleCollection) {
        CompanyViewController *companyVC = [[CompanyViewController alloc] init];
        companyVC.companyName = [self.titleArr[indexPath.row] valueForKey:@"name"];
        NSLog(@"~~~~~~~~%@", companyVC.companyName);
        [self.navigationController pushViewController:companyVC animated:YES];
    }else{
        GameViewController *gameVC = [[GameViewController alloc] init];
        gameVC.gameName = [self.contentArr[indexPath.row] valueForKey:@"name"];
        [self.navigationController pushViewController:gameVC animated:YES];
    }
}

#pragma mark - setNav
- (void)setNav                                  
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_sao_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(saoClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_message_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(msgClick)];
    
    SearchTextField *search = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, 260 * WIDTHMAKE, 32 * HEIGHTMAKE) Text:@"搜索游戏名/商品名/关键词"];
    search.delegate = self;
    self.navigationItem.titleView = search;
}

#pragma mark - 点击扫一扫
- (void)saoClick
{
    NSLog(@"%s",__func__);
}

#pragma mark - 点击消息
- (void)msgClick
{
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
    return NO;
}

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
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
@end
