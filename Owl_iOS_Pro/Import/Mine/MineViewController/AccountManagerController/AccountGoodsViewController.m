//
//  AccountGoodsViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/19.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountGoodsViewController.h"
#import "NoOrderView.h"

@interface AccountGoodsViewController ()

@end

@implementation AccountGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createTable];
}

#pragma mark - createTable
- (void)createTable
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NoOrderView *noOrder = [[NoOrderView alloc] initWithFrame:self.view.bounds];
    noOrder.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:noOrder];
}
@end
