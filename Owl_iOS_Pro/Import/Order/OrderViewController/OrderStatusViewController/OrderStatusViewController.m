//
//  OrderStatusViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/15.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "NoOrderView.h"
#import "OrderCell.h"


@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createTable];

//    NoOrderView *view = [[NoOrderView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
}

- (void)createTable
{
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 0.1f)];
    self.tableView.contentInset = UIEdgeInsetsMake(STANDNAV(44) + 40 * HEIGHTMAKE, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 214 * HEIGHTMAKE;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 0;
    } else {
        return 10;
    }
}
@end
