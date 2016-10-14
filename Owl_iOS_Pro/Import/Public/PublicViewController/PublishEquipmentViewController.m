//
//  PublishEquipmentViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/15.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishEquipmentViewController.h"
#import "PublishCellModel.h"
#import <MJExtension/MJExtension.h>
#import "PublishCell.h"
#import "PublishInputCell.h"
#import "PublishSaleTypeCell.h"
#import "SelectedEquipmentCell.h"
#import "SelectedOnLineCell.h"



@interface PublishEquipmentViewController ()

@end

@implementation PublishEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布装备";
  
}

- (NSMutableArray *)accountFirstArr
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PublishEquip.plist" ofType:nil];
    return [PublishCellModel mj_objectArrayWithFile:path];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            
            UIButton *btn = (UIButton *)cell.firstBtn;
            NSString *text = btn.currentTitle;
            if (indexPath.row == 1) {
                [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"friend"];
            } else {
                [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"saler"];
            }
            
            cell.chooseBlock = ^(NSString *optionText){
                if (indexPath.row == 1) {
                    [[NSUserDefaults standardUserDefaults] setValue:optionText forKeyPath:@"friend"];
                } else {
                    [[NSUserDefaults standardUserDefaults] setValue:optionText forKeyPath:@"saler"];
                }
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 4 || indexPath.row == 6) {
            PublishInputCell *cell = [tableView dequeueReusableCellWithIdentifier:InputID];
            cell.field.keyboardType = UIKeyboardTypeNumberPad;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            cell.fieldTextBlock = ^(NSString *fieldText){
                if (indexPath.row == 4) {
                    [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"price"];
                } else {
                    [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"stock"];
                }
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 5) {
            SelectedOnLineCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectOnLineID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            cell.noteVcBlock = ^(BOOL isSelected){
                [self.view endEditing:YES];
            };
            
            cell.selectOnLineBlock = ^(NSString *selectTimeText){
                [[NSUserDefaults standardUserDefaults] setValue:selectTimeText forKeyPath:@"onLine"];
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 0) {
            SelectedEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:equipID];
            cell.equipArray = [NSMutableArray arrayWithObjects:@"武器", @"防具", @"首饰", @"宠物", @"材料", @"宝石", nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            cell.toDoBlock = ^(BOOL isSeleceted){
                [self.view endEditing:YES];
            };
            
            cell.selectEquipBlock = ^(NSString *selectedEquipText){
                [[NSUserDefaults standardUserDefaults] setValue:selectedEquipText forKeyPath:@"equipType"];
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else {
            PublishSaleTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:SaleTypeID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            
            UIButton *btn = (UIButton *)cell.firstBtn;
            NSString *text = btn.currentTitle;
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"saleType"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            cell.noteBidBlock = ^(BOOL isSelected){
                [self.view endEditing:YES];
            };
            
            cell.chooseSalerBlock = ^(NSString *salerText, NSString *deadTime){
                [[NSUserDefaults standardUserDefaults] setValue:salerText forKeyPath:@"saleType"];
                [[NSUserDefaults standardUserDefaults] setValue:deadTime forKeyPath:@"bidTime"];
            };
            
            cell.chooseTimeBlock = ^(NSString *timeText){
                [[NSUserDefaults standardUserDefaults] setValue:timeText forKeyPath:@"bidTime"];
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        }
    } else {
        PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.accountFirstArr[indexPath.row + self.accountFirstArr.count - 3];
        
        UIButton *btn = (UIButton *)cell.firstBtn;
        NSString *text = btn.currentTitle;
        if (indexPath.row == 0) {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"phone"];
        } else if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"email"];
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"securityCard"];
        }
        
        cell.chooseBlock = ^(NSString *optionTitle){
            if (indexPath.row == 0) {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"phone"];
            } else if (indexPath.row == 1) {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"email"];
            } else {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"securityCard"];
            }
        };
        [[NSUserDefaults standardUserDefaults] synchronize];
        return cell;
    }
}

@end
