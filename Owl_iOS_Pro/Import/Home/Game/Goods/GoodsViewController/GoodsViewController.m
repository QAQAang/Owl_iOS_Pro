//
//  GoodsViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GoodsViewController.h"
#import <AFNetworking.h>
#import "PicViewController.h"
#import "PaierCell.h"
#import "StarCell.h"
#import "LoadingView.h"
#import "PhotoCollectionViewCell.h"
#import "SellerModel.h"
#import "Tools.h"
#import "TitleTableViewCell.h"
#import "LoginViewController.h"
@interface GoodsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain)NSMutableArray *photoArr;

@property (nonatomic, assign)NSInteger centerCount;

@property (nonatomic, retain)UIView *photoBackground;

@property (nonatomic, retain)UITableView *tableV;

@property (nonatomic, retain)NSArray *imgArr;

@property (nonatomic, retain)NSMutableArray *imgWidth;

@property (nonatomic, retain)UICollectionView *collection;

@property (nonatomic, retain)SellerModel *seller;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)NSInteger cellTitleCount;

@property (nonatomic, retain)NSMutableArray *saveArr;

@end

@implementation GoodsViewController

- (NSMutableArray *)photoArr{
    if (_photoArr == nil) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)imgWidth{
    if (_imgWidth == nil) {
        _imgWidth = [NSMutableArray array];
    }
    return _imgWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.goods.title;
    [self creatCollection];
    [self creatTableV];
    [self creatView];
    [self dataTask];
    [self getAllImage];
    [self creatRightBar];
}

- (void)getAllImage{
    self.imgArr = [self.goods.picturePath componentsSeparatedByString:@","];
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 64)];
    [self.view addSubview:loadingView];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSString *url in self.imgArr) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=%@", url]]]];
            [self.imgWidth addObject:[NSString stringWithFormat:@"%lf", image.size.width / image.size.height * 158]];
            [self.photoArr addObject:image];
        }
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.168:8080/goods/getAttentionGoods?userID=%@", self.goods.userId]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data != nil) {
                NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if ([[dic valueForKey:@"msg"] isEqualToString:@""]) {
                    self.saveArr = [dic valueForKey:@"data"];
                }
            }
        }] resume];
        [self.collection reloadData];
        [loadingView removeFromSuperview];
    });
}

- (void)dataTask{
    [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 64) NeedLoading:NO URL:[NSString stringWithFormat:@"192.168.2.168:8080/user/getUserById?userId=%@", self.goods.userId] Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.seller = [[SellerModel alloc] initWithDic:responseObject];
        [self.tableV reloadData];
    } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)creatCollection{
    if ([self.clas isEqualToString:@"equipment"] || [self.clas isEqualToString:@"account"]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(21 * HEIGHTMAKE, 20 * WIDTHMAKE, 21 * HEIGHTMAKE, 20 * WIDTHMAKE);
        layout.minimumInteritemSpacing = 20 * WIDTHMAKE;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 200 * HEIGHTMAKE) collectionViewLayout:layout];
        self.collection.backgroundColor = [UIColor whiteColor];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self.collection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageV.image = self.photoArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self.imgWidth[indexPath.row] floatValue], 158 * HEIGHTMAKE);
}

#pragma mark - tableView

- (void)creatTableV{
    if ([self.clas isEqualToString:@"equipment"] || [self.clas isEqualToString:@"account"]) {
        self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 64) style:UITableViewStylePlain];
    }else{
        self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTHS, HEIGHTS - 64) style:UITableViewStylePlain];
    }
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = COLOR(242, 242, 242, 1);
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 60 * HEIGHTMAKE)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableV.tableFooterView = footView;
    self.tableV.tableHeaderView = self.collection;
    [self.tableV registerClass:[TitleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV registerClass:[PaierCell class] forCellReuseIdentifier:@"paier"];
    [self.tableV registerClass:[StarCell class] forCellReuseIdentifier:@"star"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.clas isEqualToString:@"equipment"] || [self.clas isEqualToString:@"gold"]){
            TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.title.text = self.goods.title;
            }else if (indexPath.row == 1){
                cell.title.text = self.goods.game;
            }else if (indexPath.row == 2){
                cell.title.text = [NSString stringWithFormat:@"%@  %@", self.goods.space, self.goods.server];
            }else if (indexPath.row == 3){
                cell.title.text = self.goods.des_crip_tion;
                cell.title.numberOfLines = self.cellTitleCount;
            }
            return cell;
        }else{
            if (indexPath.row == 0) {
                PaierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paier"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.goodsDetail.text = self.goods.title;
                cell.gameServer.text = [NSString stringWithFormat:@"%@  %@",  self.goods.space, self.goods.server];
                cell.leftLabel.text = [NSString stringWithFormat:@"角色职业：%@\n角色等级：%@", self.goods.profession, self.goods.grades];
                cell.rightLabel.text = [NSString stringWithFormat:@"角色性别：%@", self.goods.sex];
                return cell;
            }else{
                TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row == 2) {
                    cell.title.text = [NSString stringWithFormat:@"价格：%@元", self.goods.price];
                }else if (indexPath.row == 3){
                    cell.title.text = self.goods.des_crip_tion;
                    cell.title.numberOfLines = self.cellTitleCount;
                }
                return cell;
            }
            
        }
    }else{
        if (indexPath.row == 3) {
            StarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"star"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.title.text = [NSString stringWithFormat:@"%@", self.seller.realName];
            }else if (indexPath.row == 1){
                cell.title.text = @"身份认证";
                cell.detailTitle.text = @"待解决";
            }else if (indexPath.row == 2){
                cell.title.text = @"成交笔数";
                cell.detailTitle.text = @"待解决";
            }else if (indexPath.row == 4){
                cell.title.text = @"手机绑定";
                cell.detailTitle.text = @"待解决";
            }else if (indexPath.row == 5){
                cell.title.text = @"密保邮箱";
                cell.detailTitle.text = @"待解决";
            }else if (indexPath.row == 6){
                cell.title.text = @"密保卡";
                cell.detailTitle.text = @"待解决";
            }
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 40 * HEIGHTMAKE)];
        view.backgroundColor = COLOR(242, 242, 242, 1);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 13.5 * HEIGHTMAKE, WIDTHS, 13 * HEIGHTMAKE)];
        label.textColor = COLOR(172, 172, 172, 1);
        label.text = @"卖家信息";
        label.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.clas isEqualToString:@"equipment"] || [self.clas isEqualToString:@"gold"]){
            return 40 * HEIGHTMAKE;
        }else{
            if (indexPath.row == 0) {
                return 136 * HEIGHTMAKE;
            }else{
                if (indexPath.row == 1) {
                    return 0 * HEIGHTMAKE;
                }else if (indexPath.row == 3){
                    if (!self.isOn) {
                        return 40 * HEIGHTMAKE;
                    }else{
                        return [Tools getHeightString:self.goods.des_crip_tion FontSize:14 * HEIGHTMAKE Width:WIDTHS - 20] + 30 * HEIGHTMAKE;
                    }
                }else{
                    return 40 * HEIGHTMAKE;
                }
            }
            
        }
    }else{
        return 40 * HEIGHTMAKE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40 * HEIGHTMAKE;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 3) {
        self.isOn = !self.isOn;
        if (!self.isOn) {
            self.cellTitleCount = 1;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            self.cellTitleCount = 0;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}

#pragma mark - 下单

- (void)creatView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLOR(255, 110, 135, 1);
    [button setTitle:@"下单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(10 * WIDTHMAKE, HEIGHTS - 60 * HEIGHTMAKE, 355 * WIDTHMAKE, 45 * HEIGHTMAKE);
    button.layer.cornerRadius = 10 * WIDTHMAKE;
    [button addTarget:self action:@selector(clickTakeList) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:button aboveSubview:self.tableV];
}

- (void)clickTakeList{
    
}

#pragma mark - 分享／关注

- (void)creatRightBar{
    
    UIBarButtonItem *saveItem;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
        saveItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"未关注"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(clickToSave:)];
    }else{
        NSString *imgName = @"未关注";
        for (NSMutableDictionary *dic in self.saveArr) {
            if ([[dic objectForKey:@"goodsID"] isEqualToString:self.goods.goodsID]) {
                imgName = @"已关注";
                break;
            }
        }
        saveItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(clickToSave:)];
        if ([imgName isEqualToString:@"未关注"]) {
            saveItem.tag = 1212;
        }else{
            saveItem.tag = 2121;
        }
        
    }
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStyleDone target:self action:@selector(clickToShare)];
    saveItem.tintColor = [UIColor whiteColor];
    shareItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[saveItem, shareItem];
}

- (void)clickToSave:(UIBarButtonItem *)sender{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        if (sender.tag == 1212) {
            sender.image = [UIImage imageNamed:@"已关注"];
            [Tools getRequestViewController:self FliterFrame:CGRectMake(0, 0, 0, 0) NeedLoading:NO URL:[NSString stringWithFormat:@"192.168.2.168:8080/goods/attention?userId=%@&goodsId=%@", self.goods.userId, self.goods.goodsID] Parameters:nil Progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } Success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            } Failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }
}

- (void)clickToShare{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        [NSString stringWithFormat:@"eyouApp//:com.taoeou.aang?userID=%@&goodsID=%@&isShare=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"], self.goods.goodsID, @"分享"];
    }
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
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
