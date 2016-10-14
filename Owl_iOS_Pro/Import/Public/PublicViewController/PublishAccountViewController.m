//
//  PublishAccountViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/31.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishAccountViewController.h"
#import "PublishHeaderView.h"
#import "PublishFooterView.h"
#import "UIView+YPFrameExtension.h"
#import "PublishCell.h"
#import "PublishInputCell.h"
#import "PublishSaleTypeCell.h"
#import "PublishCellModel.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking.h>
#import "SelectedOnLineCell.h"
#import "PublishEquipmentViewController.h"
#import "SelectedEquipmentCell.h"

@class PublishEquipmentViewController;
@interface PublishAccountViewController () <UITextViewDelegate>
@property (nonatomic, copy)NSMutableArray *selectedImageArray;
@property (nonatomic, strong)PublishFooterView *footerView;
@end

@implementation PublishAccountViewController
- (NSMutableArray *)selectedImageArray
{
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray array];
    }
    return _selectedImageArray;
}

- (NSMutableDictionary *)param
{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        _param[@"userId"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"];
        if ([self isKindOfClass:[PublishEquipmentViewController class]]) {
            _param[@"type"] = @"equipment";
            _param[@"equippedType"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"equipType"];
        } else {
            _param[@"type"] = @"account";
        }
        _param[@"title"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"title"];
        _param[@"game"] = self.gameNameT;
        _param[@"server"] = self.serverNameT;
        _param[@"space"] = self.areasNameT;
        _param[@"profession"] = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKeyPath:@"professional"]];
        _param[@"sex"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"sex"];
        _param[@"grades"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"level"];
        _param[@"QQfriend"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"friend"];
        _param[@"sellerType"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"saler"];
        _param[@"way"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"saleType"];
        if ([[[NSUserDefaults standardUserDefaults] valueForKeyPath:@"saleType"] isEqualToString:@"竞价"]) {
            _param[@"deadTime"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"bidTime"];
        }
        _param[@"price"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"price"];
        _param[@"online"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"onLine"];
        _param[@"Bcard"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"IDCard"];
        _param[@"Bphone"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"phone"];
        _param[@"Bemail"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"email"];
        _param[@"encrypted"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"securityCard"];
        _param[@"description"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"descText"];
    }
    return _param;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self removeUserDefault];
    
    [self createNav];
    
    [self createTable];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyBoardWillShow:(NSNotification *)note
{
    if (self.footerView.textView.isFirstResponder) {
        
        CGRect keyBoardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        CGFloat height = keyBoardFrame.origin.y;
        CGFloat textView_maxY = CGRectGetMaxY(self.tableView.tableFooterView.frame);
        CGFloat space = -self.tableView.contentOffset.y + textView_maxY;
        CGFloat transformY = height - space;
        if (transformY < 0) {
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.view.frame;
                frame.origin.y = transformY;
                self.view.frame = frame;
            }];
        }
    }
}

- (void)keyBoardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}


- (void)removeUserDefault
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"title"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"descText"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"friend"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saler"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"professional"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"level"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"price"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"onLine"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saleType"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bidTime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"securityCard"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"equipType"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"stock"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IDCard"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - createnav
- (void)createNav
{
    self.navigationItem.title = @" 发布帐号";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPublish)];
}

- (void)confirmPublish
{
    [self.view endEditing:YES];
    
    NSString *price = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"price"];
    
    if ([price floatValue] <= 0) {
        NSLog(@"没有价格");
        return;
    }

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json", nil];
    
    [manager POST:@"http://192.168.2.168:8080/goods/publish" parameters:self.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in self.selectedImageArray) {
            NSData *data = UIImagePNGRepresentation(image);
            NSString *fileName = [NSString stringWithFormat:@"%lu.png",(unsigned long)[self.selectedImageArray indexOfObject:image]];
            NSLog(@"%@",data);
            [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-----%@------",responseObject);
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        [self removeUserDefault];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@++++++",error);
    }];

}

- (NSMutableArray *)accountFirstArr
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PublishAccount.plist" ofType:nil];
    return [PublishCellModel mj_objectArrayWithFile:path];
}

#pragma mark - table
- (void)createTable
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    PublishHeaderView *headerView = [[PublishHeaderView alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 134.5 * HEIGHTMAKE)];
    headerView.viewController = self;
    headerView.goodsTitleBlock = ^(NSString *title){
        [[NSUserDefaults standardUserDefaults] setValue:title forKeyPath:@"title"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    headerView.selectedImageArrayBlcock = ^(NSMutableArray *selectedImageArray){
        self.selectedImageArray = selectedImageArray;
    };
    self.tableView.tableHeaderView = headerView;
    
    
    [self.tableView registerClass:[PublishCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[PublishInputCell class] forCellReuseIdentifier:InputID];
    [self.tableView registerClass:[PublishSaleTypeCell class] forCellReuseIdentifier:SaleTypeID];
    [self.tableView registerClass:[SelectedOnLineCell class] forCellReuseIdentifier:SelectOnLineID];
    [self.tableView registerClass:[SelectedEquipmentCell class] forCellReuseIdentifier:equipID];
    
    //footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 100)];
    PublishFooterView *footerView = [[PublishFooterView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 20 * WIDTHMAKE, 90 * HEIGHTMAKE)];
    footerView.textView.delegate = self;
    self.footerView = footerView;
    [footer addSubview:footerView];
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    
    [[NSUserDefaults standardUserDefaults] setValue:textView.text forKeyPath:@"descText"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.accountFirstArr.count - 4;
    } else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3 || indexPath.row == 4) {
            PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            
            UIButton *btn = (UIButton *)cell.firstBtn;
            NSString *text = btn.currentTitle;
            if (indexPath.row == 3) {
                [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"friend"];
            } else {
                [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"saler"];
            }
            
            cell.chooseBlock = ^(NSString *optionTitle) {
                if (indexPath.row == 3) {
                    [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"friend"];
                } else {
                    [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"saler"];
                }
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 6) {
            PublishInputCell *cell = [tableView dequeueReusableCellWithIdentifier:InputID];
            if (indexPath.row == 6 || indexPath.row == 2) {
                cell.field.keyboardType = UIKeyboardTypeNumberPad;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            cell.fieldTextBlock = ^(NSString *fieldText) {
                if (indexPath.row == 0) {
                    [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"professional"];
                } else if (indexPath.row == 2) {
                    [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"level"];
                } else {
                    [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"price"];
                }
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 1) {
            SelectedEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:equipID];
            cell.equipArray = [NSMutableArray arrayWithObjects:@"无", @"男", @"女", nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.accountFirstArr[indexPath.row];
            cell.toDoBlock = ^(BOOL isSelected){
                [self.view endEditing:YES];
            };
            cell.selectEquipBlock = ^(NSString *sex){
                [[NSUserDefaults standardUserDefaults] setValue:sex forKeyPath:@"sex"];
            };
            [[NSUserDefaults standardUserDefaults] synchronize];
            return cell;
        } else if (indexPath.row == 7) {
            SelectedOnLineCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectOnLineID];
            cell.model = self.accountFirstArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.noteVcBlock = ^(BOOL isSeleceted){
                [self.view endEditing:YES];
            };
            
            cell.selectOnLineBlock = ^(NSString *onLineTime){
                [[NSUserDefaults standardUserDefaults] setValue:onLineTime forKeyPath:@"onLine"];
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
        cell.model = self.accountFirstArr[indexPath.row + self.accountFirstArr.count - 4];
        
        UIButton *btn = (UIButton *)cell.firstBtn;
        NSString *text = btn.currentTitle;
        if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"phone"];
        } else if (indexPath.row == 2) {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"email"];
        } else if (indexPath.row == 3) {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"securityCard"];
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"IDCard"];
        }
        
        cell.chooseBlock = ^(NSString *optionTitle){
            if (indexPath.row == 1) {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"phone"];
            } else if (indexPath.row == 2) {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"email"];
            } else if (indexPath.row == 3) {
                [[NSUserDefaults standardUserDefaults] setValue:optionTitle forKeyPath:@"securityCard"];
            } else {
                [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"IDCard"];
            }
        };
        [[NSUserDefaults standardUserDefaults] synchronize];
        return cell;
    }
}

#pragma mark -  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10 * HEIGHTMAKE;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 23 * HEIGHTMAKE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = COLOR(60, 60, 60, 1.0);
    label.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    if (section == 0) {
        label.text = @"   绑定方式";
        return label;
    } else {
        label.text = @"   为保障双方权益及商品的真实性，发布商品需缴纳保障金5元";
        return label;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
