//
//  AuctionTabBar.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionTabBar.h"
#import "AuctionHomeViewController.h"
@interface AuctionTabBar ()

@end

@implementation AuctionTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    AuctionHomeViewController *auction = [[AuctionHomeViewController alloc] init];
    auction.title = @"拍卖";
    auction.navigationController.navigationBar.translucent = NO;
    auction.navigationController.navigationBar.barTintColor = COLOR(255, 88, 10, 1);
    UINavigationController *navRoot = [[UINavigationController alloc] initWithRootViewController:auction];
    [self addChildViewController:navRoot];
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
