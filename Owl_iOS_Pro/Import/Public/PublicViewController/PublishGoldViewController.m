//
//  PublishGoldViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/15.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishGoldViewController.h"
#import "PublishFooterView.h"
#import "PublishCellModel.h"
#import <MJExtension/MJExtension.h>
#import "PublishCell.h"
#import "PublishInputCell.h"
#import "SelectedOnLineCell.h"
#import <AFNetworking.h>

static NSString * const ID = @"cell";
static NSString * const InputID = @"PublishInputCell";
static NSString * const TimeID = @"selectedOnlineCell";
@interface PublishGoldViewController () <UITextViewDelegate>
@property (nonatomic, copy)NSMutableArray *goldArr;
@property (nonatomic, copy)NSMutableDictionary *param;
@property (nonatomic, copy)NSMutableArray *selectedImageArray;
@property (nonatomic, strong)PublishFooterView *footerView;
@end

@implementation PublishGoldViewController

- (NSMutableArray *)selectedImageArray
{
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray array];
    }
    return _selectedImageArray;
}

- (NSMutableArray *)goldArr
{
    if (!_goldArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PublishGold.plist" ofType:nil];
        _goldArr = [PublishCellModel mj_objectArrayWithFile:path];
    }
    return _goldArr;
}

- (NSMutableDictionary *)param
{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        _param[@"userId"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"];
        _param[@"type"] = @"gold";
        _param[@"way"] = @"定价";
        _param[@"game"] = self.gameNameT;
        _param[@"server"] = self.serverNameT;
        _param[@"space"] = self.areasNameT;
        _param[@"title"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"title"];
        _param[@"sellerType"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"saler"];
        _param[@"price"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"price"];
        _param[@"online"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"onLine"];
        _param[@"stock"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"stock"];
        _param[@"description"] = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"descText"];
    }
    return _param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self removeUserDefault];
    
    [self createNav];
    
    [self createTable];
}

- (void)createNav
{
    self.view.backgroundColor = ViewBacgroundColor;
    self.navigationItem.title = @"发布游戏币";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confirmClick)];
}

- (void)removeUserDefault
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"title"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saler"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"price"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"onLine"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"stock"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"descText"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - confirmClick
- (void)confirmClick
{
    [self.view endEditing:YES];
    
    NSString *price = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"price"];
    
    if ([price floatValue] <= 0) {
        NSLog(@"没有价格");
    } else {
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
    NSLog(@"- - - - - - - ");
    
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


#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    [[NSUserDefaults standardUserDefaults] setValue:textView.text forKeyPath:@"descText"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)createTable
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.tableView registerClass:[PublishCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[PublishInputCell class] forCellReuseIdentifier:InputID];
    [self.tableView registerClass:[SelectedOnLineCell class] forCellReuseIdentifier:TimeID];
    
    //headerView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 44.6 * HEIGHTMAKE)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UITextField *headerLabel = [[UITextField alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 10 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17 * WIDTHMAKE];
    attr[NSForegroundColorAttributeName] = COLOR(199, 199, 199, 1.0);
    [headerLabel setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"商品标题" attributes:attr]];
    [headerLabel addTarget:self action:@selector(titleChange:) forControlEvents:UIControlEventEditingChanged];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:headerLabel];
    //line
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerLabel.frame), WIDTHS, 0.6 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(200, 199, 204, 1.0);
    [headerView addSubview:lineOne];
    self.tableView.tableHeaderView = headerView;

    //footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 100)];
    PublishFooterView *footerView = [[PublishFooterView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 20 * WIDTHMAKE, 90 * HEIGHTMAKE)];
    footerView.textView.delegate = self;
    self.footerView = footerView;
    [footer addSubview:footerView];
    
    self.tableView.tableFooterView = footer;
}

- (void)titleChange:(UITextField *)title
{
    [[NSUserDefaults standardUserDefaults] setValue:title.text forKeyPath:@"title"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goldArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.model = self.goldArr[indexPath.row];
        
        UIButton *btn = (UIButton *)cell.firstBtn;
        NSString *text = btn.currentTitle;
        [[NSUserDefaults standardUserDefaults] setValue:text forKeyPath:@"saler"];
        
        cell.chooseBlock = ^(NSString *optionText){
            [[NSUserDefaults standardUserDefaults] setValue:optionText forKeyPath:@"saler"];
        };
        [[NSUserDefaults standardUserDefaults] synchronize];
        return cell;
    } else if (indexPath.row == 2) {
        SelectedOnLineCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.goldArr[indexPath.row];
        cell.noteVcBlock = ^(BOOL isSelected){
            [self.view endEditing:YES];
        };
        
        cell.selectOnLineBlock = ^(NSString *selectTimeText){
            [[NSUserDefaults standardUserDefaults] setValue:selectTimeText forKeyPath:@"onLine"];
        };
        [[NSUserDefaults standardUserDefaults] synchronize];
        return cell;
    } else {
        PublishInputCell *cell = [tableView dequeueReusableCellWithIdentifier:InputID];
        
        cell.field.keyboardType = UIKeyboardTypeNumberPad;
        cell.model = self.goldArr[indexPath.row];
        cell.fieldTextBlock = ^(NSString *fieldText){
            if (indexPath.row == 1) {
                [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"price"];
            } else {
                [[NSUserDefaults standardUserDefaults] setValue:fieldText forKeyPath:@"stock"];
            }
        };
        [[NSUserDefaults standardUserDefaults] synchronize];
        return cell;
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
    label.text = @"   为保障双方权益及商品的真实性，发布商品需缴纳保障金5元";
    return label;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
