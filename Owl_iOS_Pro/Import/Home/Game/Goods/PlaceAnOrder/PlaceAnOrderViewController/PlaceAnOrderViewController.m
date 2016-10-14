//
//  PlaceAnOrderViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PlaceAnOrderViewController.h"
#import "PlaceAnOrderCell.h"
@interface PlaceAnOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)UITableView *tableV;

@end

@implementation PlaceAnOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTableV];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 * HEIGHTMAKE, WIDTHS, HEIGHTS - 113 * HEIGHTMAKE) style:UITableViewStylePlain];
    self.tableV.backgroundColor = COLOR(227, 227, 227, 1);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV registerClass:[PlaceAnOrderCell class] forCellReuseIdentifier:@"order"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (indexPath.row == 0) {
            cell.textLabel.text = self.model.name;
        }else if (indexPath.row == 1){
            cell.textLabel.text = self.model.game;
        }else if (indexPath.row == 2){
            cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",self.model.space, self.model.server];
        }else if (indexPath.row == 3){
            cell.textLabel.text = self.model.price;
        }
        return cell;
    }else {
        PlaceAnOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order"];
        if (indexPath.row == 0) {
            cell.label.text = @"收货角色";
            cell.textField.placeholder = @"请输入角色名称";
        }else if (indexPath.row == 1){
            cell.label.text = @"角色等级";
            cell.textField.placeholder = @"请输入角色等级";
        }else if (indexPath.row == 2){
            cell.label.text = @"您的联系qq";
            cell.textField.placeholder = @"请输入联系您的QQ号码";
        }else if (indexPath.row == 3){
            cell.label.text = @"您的手机号码";
            cell.textField.placeholder = @"请输入11位手机号码";
        }
        return cell;
    }
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
