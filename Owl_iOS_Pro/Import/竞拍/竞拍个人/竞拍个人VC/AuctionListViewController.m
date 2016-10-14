//
//  AuctionListViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionListViewController.h"
#import "AuctionListViewController.h"
#import "AuctioningViewController.h"
#import "AuctionedViewController.h"
@interface AuctionListViewController ()

@property (nonatomic, retain)UIScrollView *contentScroll;

@property (nonatomic, retain)UIView *line;

@end

@implementation AuctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildVC];
    [self creatScroll];
}
#pragma mark - 网络请求
- (void)taskData{
    
}

- (void)addChildVC{
    AuctionListViewController *list = [[AuctionListViewController alloc] init];
    [self addChildViewController:list];
    AuctioningViewController *auctioning = [[AuctioningViewController alloc] init];
    [self addChildViewController:auctioning];
    AuctionedViewController *aucioned = [[AuctionedViewController alloc] init];
    [self addChildViewController:aucioned];
}

- (void)creatScroll{
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 99 * HEIGHTMAKE, WIDTHS, HEIGHTS - 99 * HEIGHTMAKE)];
    self.contentScroll.backgroundColor = COLOR(227, 227, 227, 1);
    self.contentScroll.contentSize = CGSizeMake(WIDTHS * 3, HEIGHTS - 99 * HEIGHTMAKE);
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS * i, 0, WIDTHS, HEIGHTS - 99 * HEIGHTMAKE)];
        [view addSubview:self.childViewControllers[i].view];
        [self.contentScroll addSubview:view];
    }
    self.contentScroll.pagingEnabled = YES;
    [self.view addSubview:self.contentScroll];
}

#pragma mark - title

- (void)creatTitle{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1 * WIDTHMAKE, 64 * HEIGHTMAKE, WIDTHS + 2 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    view.layer.borderColor = COLOR(65, 64, 64, 1).CGColor;
    view.layer.borderWidth = 1 * WIDTHMAKE;
    [self.view addSubview:view];
    UIButton *button1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(45 * WIDTHMAKE, 0, 45 * WIDTHMAKE, 35 * HEIGHTMAKE);
    [button1 setTitle:@"竞拍中" forState:UIControlStateNormal];
    button1.tag = 2000;
    [button1 setTitleColor:COLOR(65, 64, 64, 1) forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(165 * WIDTHMAKE, 0, 45 * WIDTHMAKE, 35 * HEIGHTMAKE);
    [button2 setTitle:@"已拍下" forState:UIControlStateNormal];
    button2.tag = 2001;
    [button2 setTitleColor:COLOR(65, 64, 64, 1) forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [button2 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(285 * WIDTHMAKE, 0, 45 * WIDTHMAKE, 35 * HEIGHTMAKE);
    button3.tag = 2002;
    [button3 setTitle:@"已拍下" forState:UIControlStateNormal];
    [button3 setTitleColor:COLOR(65, 64, 64, 1) forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    [button3 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button3];
    self.line = [[UIView alloc] initWithFrame:CGRectMake(45 * WIDTHMAKE, 34 * HEIGHTMAKE, 45 * WIDTHMAKE, 2 * HEIGHTMAKE)];
    self.line.backgroundColor = COLOR(255, 88, 10, 1);
    [view addSubview:self.line];
}

- (void)clickButton:(UIButton *)sender{
    if (sender.tag == 2000) {
        [UIView animateWithDuration:0.3 animations:^{
            self.line.frame = CGRectMake(45 * WIDTHMAKE, 34 * HEIGHTMAKE, 45 * WIDTHMAKE, 2 * HEIGHTMAKE);
        }];
        [self.contentScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (sender.tag == 2001){
        [UIView animateWithDuration:0.3 animations:^{
            self.line.frame = CGRectMake(165 * WIDTHMAKE, 34 * HEIGHTMAKE, 45 * WIDTHMAKE, 2 * HEIGHTMAKE);
        }];
        [self.contentScroll setContentOffset:CGPointMake(WIDTHS, 0) animated:YES];
    }else if (sender.tag == 2002){
        [UIView animateWithDuration:0.3 animations:^{
            self.line.frame = CGRectMake(285 * WIDTHMAKE, 34 * HEIGHTMAKE, 45 * WIDTHMAKE, 2 * HEIGHTMAKE);
        }];
        [self.contentScroll setContentOffset:CGPointMake(WIDTHS * 2, 0) animated:YES];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.line.frame = CGRectMake(45 * WIDTHMAKE + self.contentScroll.contentOffset.x * 285 * WIDTHMAKE / WIDTHS * 2, 34 * HEIGHTMAKE, 45 * WIDTHMAKE, 2 * HEIGHTMAKE);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.contentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.contentScroll removeObserver:self forKeyPath:@"contentOffset"];
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
