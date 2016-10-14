//
//  AuctionDetailViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionDetailViewController.h"
#import "AuctionDynamicCell.h"
#import "AuctionDynamicTitleCell.h"
#import "GoodsDetailCell.h"
#import "CreditLevelCell.h"
#import "MinePraceView.h"
#import "Tools.h"
@interface AuctionDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UITableView *tableV;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL bTs;

@property (nonatomic, retain)UIView *timeView;

@property (nonatomic, retain)UIButton *earnestButton;

@property (nonatomic, retain)UIView *advanceView;

@property (nonatomic, retain)UIButton *endButton;

@property (nonatomic, retain)UILabel *timeLabel;

@property (nonatomic, retain)NSDate *starTime;

@property (nonatomic, retain)MinePraceView *minePrace;

@end

@implementation AuctionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTableV];
}

#pragma mark - 网络请求

- (void)taskData{
    NSString *string = @"2016-09-14 12:00:00";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    self.starTime = [formatter dateFromString:string];
}

#pragma mark - tableView

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 * HEIGHTMAKE, WIDTHS, HEIGHTS - 136 * HEIGHTMAKE) style:UITableViewStylePlain];
    self.tableV.backgroundColor = [UIColor whiteColor];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[AuctionDynamicTitleCell class] forCellReuseIdentifier:@"title"];
    [self.tableV registerClass:[AuctionDynamicCell class] forCellReuseIdentifier:@"dynamic"];
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV registerClass:[GoodsDetailCell class] forCellReuseIdentifier:@"goods"];
    [self.tableV registerClass:[CreditLevelCell class] forCellReuseIdentifier:@"credit"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    }else if (section == 1){
        return 1;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AuctionDynamicTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            AuctionDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic"];
            return cell;
        }else if (indexPath.row == 4){
            GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goods"];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            return cell;
        }
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }else{
        if (indexPath.row == 3) {
            CreditLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"credit"];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            if (!self.isOn) {
                return 0;
            }else{
                return 30 * HEIGHTMAKE;
            }
        }else if (indexPath.row == 5){
            return 85 * HEIGHTMAKE;
        }else{
            return 50 * HEIGHTMAKE;
        }
    }else if (indexPath.section == 1){
        if (!self.bTs) {
            return 50 * HEIGHTMAKE;
        }else{
            //自适应
            return [Tools getHeightString:@"" FontSize:14 * HEIGHTMAKE Width:WIDTHS];
        }
    }else{
        return 50 * HEIGHTMAKE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 90 * HEIGHTMAKE)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 10 * HEIGHTMAKE, 90 * WIDTHMAKE, 70 * HEIGHTMAKE)];
//        imageV.image =
        [view addSubview:imageV];
        UILabel *starPrace = [[UILabel alloc] initWithFrame:CGRectMake(121 * WIDTHMAKE, 27 * HEIGHTMAKE, 125 * WIDTHMAKE, 13 * HEIGHTMAKE)];
        starPrace.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
        starPrace.textColor = COLOR(60, 60, 60, 1);
        [view addSubview:starPrace];
        UILabel *currentPrace = [[UILabel alloc] initWithFrame:CGRectMake(121 * WIDTHMAKE, 51 * HEIGHTMAKE, 125 * WIDTHMAKE, 13 *  HEIGHTMAKE)];
        currentPrace.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
        currentPrace.textColor = COLOR(60, 60, 60, 1);
        [view addSubview:currentPrace];
        UILabel *personCount = [[UILabel alloc] initWithFrame:CGRectMake(250 * WIDTHMAKE, 27 * HEIGHTMAKE, 110 * WIDTHMAKE, 13 * HEIGHTMAKE)];
        personCount.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
        personCount.textColor = COLOR(60, 60, 60, 1);
        [view addSubview:personCount];
        UILabel *endTime = [[UILabel alloc]  initWithFrame:CGRectMake(250 * WIDTHMAKE, 51 * HEIGHTMAKE, 110 * WIDTHMAKE, 13 * HEIGHTMAKE)];
        endTime.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
        endTime.textColor = COLOR(60, 60, 60, 1);
        [view addSubview:endTime];
        return view;
    }else if (section == 1){
        UILabel *label = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, WIDTHS, 32 * HEIGHTMAKE)];
        label.textColor = COLOR(173, 173, 173, 1);
        label.backgroundColor = COLOR(227, 227, 227, 1);
        label.text = @" 卖家描述";
        label.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
        return label;
    }else{
        UILabel *label = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, WIDTHS, 32 * HEIGHTMAKE)];
        label.textColor = COLOR(173, 173, 173, 1);
        label.backgroundColor = COLOR(227, 227, 227, 1);
        label.text = @" 卖家信息";
        label.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
        return label;
    }
}

#pragma mark - 支付按钮

- (void)creatBottomView{
    self.timeView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 72 * HEIGHTMAKE, WIDTHS, 72 *HEIGHTMAKE)];
    self.timeView.backgroundColor = COLOR(51, 51, 51, 0.8);
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 23 * HEIGHTMAKE)];
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.timeLabel];
    self.starTime = [NSDate date];
    [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES] fire];
    self.earnestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.earnestButton addTarget:self action:@selector(clickEarnest) forControlEvents:UIControlEventTouchUpInside];
    self.earnestButton.backgroundColor = COLOR(255, 88, 10, 1);
    self.earnestButton.frame = CGRectMake(0, 23 * HEIGHTMAKE, WIDTHS, 49 * HEIGHTMAKE);
    [self.earnestButton setTitle:@"参与竞拍\n(保证金额¥0)" forState:UIControlStateNormal];
    self.earnestButton.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [self.timeView addSubview:self.earnestButton];
    self.advanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 23 * HEIGHTMAKE, WIDTHS, 49 * HEIGHTMAKE)];
    self.advanceView.backgroundColor = COLOR(68, 68, 68, 1);
    self.advanceView.alpha = 0;
    self.minePrace = [[MinePraceView alloc] initWithFrame:CGRectMake(0, 0, 167 * WIDTHMAKE, 49 * HEIGHTMAKE)];
    [self.advanceView addSubview:self.minePrace];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.backgroundColor = COLOR(255, 88, 10, 1);
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:@"当前价格：\n去竞拍"];
    NSString *string = [NSString stringWithFormat:@"%@", aString];
    NSRange range = [string rangeOfString:@"去竞拍"];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 * WIDTHMAKE] range:range];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 * WIDTHMAKE] range:NSMakeRange(0, range.location - 1)];
    button.titleLabel.attributedText = aString;
    [button addTarget:self action:@selector(clickAdvance) forControlEvents:UIControlEventTouchUpInside];
    [self.advanceView addSubview:button];
    self.endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endButton.frame = CGRectMake(0, 23 * HEIGHTMAKE, WIDTHS, 49 * HEIGHTMAKE);
    NSMutableAttributedString *eString = [[NSMutableAttributedString alloc] initWithString:@"竞拍结束\n(成功拍下商品请进入我的拍卖订单进行下一步)"];
    NSRange eRange = [[NSString stringWithFormat:@"%@", eString] rangeOfString:@"(成功拍下商品请进入我的拍卖订单进行下一步)"];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 * WIDTHMAKE] range:eRange];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 * WIDTHMAKE] range:NSMakeRange(0, eRange.location - 1)];
    [self.endButton setTitle:@"竞拍结束" forState:UIControlStateNormal];
    self.endButton.backgroundColor = COLOR(167, 167, 167, 1);
    [self.timeView addSubview:self.endButton];
}

- (void)timeMethod{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.starTime];
    CGFloat endTime = 48 * 3600 - timeInterval;
    self.timeLabel.text = [NSString stringWithFormat:@"距离结束:%ld时%ld分%ld秒", (unsigned long)endTime / 3600, (unsigned long)endTime % 3600 / 60, (unsigned long)endTime % 60];
}

// 点击参与竞拍
- (void)clickEarnest{
    
}

// 点击加价
- (void)clickAdvance{
    
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
