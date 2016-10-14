//
//  AuctionHomeViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionHomeViewController.h"
#import "PickGameCell.h"
#import "SearchTextField.h"
#import "NewAuctionCell.h"
@interface AuctionHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UICollectionView *collection;

@property (nonatomic, retain)SearchTextField *searchBar;

@property (nonatomic, retain)UITableView *tableV;

@property (nonatomic, retain)UIScrollView *backgroundView;

@property (nonatomic, retain)NSMutableArray *dataArr;

@end

@implementation AuctionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTableV];
    [self creatSearchView];
    [self creatCollection];
    [self creatTableV];
}

#pragma mark - 网络请求

- (void)dataTask{
    
}

#pragma mark - scrollView

- (void)creatScrollView{
    self.backgroundView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 * HEIGHTMAKE, WIDTHS, HEIGHTS - 113 * HEIGHTMAKE)];
    self.backgroundView.delegate = self;
    self.backgroundView.contentSize = CGSizeMake(WIDTHS, HEIGHTS - 113 * HEIGHTMAKE + 110.5 * 4);
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
}

#pragma mark - searchTextField

- (void)creatSearchView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 * HEIGHTMAKE, WIDTHS, 40 * HEIGHTMAKE)];
    view.backgroundColor = COLOR(255, 88, 10, 1);
    self.searchBar = [[SearchTextField alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 4 * HEIGHTMAKE, 355 * WIDTHMAKE, 32 * HEIGHTMAKE)];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.searchBar];
    [self.view addSubview:view];
}

#pragma mark - collection

- (void)creatCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(110 * WIDTHMAKE, 135 * HEIGHTMAKE);
    layout.sectionInset = UIEdgeInsetsMake(0, 10 * WIDTHMAKE, 0, 10 * WIDTHMAKE);
    layout.minimumLineSpacing = 9 * HEIGHTMAKE;
    layout.minimumInteritemSpacing = 12 * WIDTHMAKE;
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, WIDTHS, 306 * HEIGHTMAKE) collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.scrollEnabled = NO;
    [self.collection registerClass:[PickGameCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self.backgroundView addSubview:self.collection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PickGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, 100 * WIDTHMAKE, 27 * HEIGHTMAKE)];
        label.text = @"您可能会喜欢的商品";
        label.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
        label.textColor = COLOR(60, 60, 60, 1);
        label.backgroundColor = [UIColor whiteColor];
        [head addSubview:label];
        return head;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - tableView

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 415 * HEIGHTMAKE, WIDTHS, HEIGHTS - 464 * HEIGHTMAKE) style:UITableViewStylePlain];
    self.tableV.backgroundColor = [UIColor whiteColor];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 110.5 * HEIGHTMAKE;
    self.tableV.scrollEnabled = NO;
    [self.tableV registerClass:[NewAuctionCell class] forCellReuseIdentifier:@"cell"];
    [self.backgroundView addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewAuctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
