//
//  SettingSecurityViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SettingSecurityViewController.h"
#import "SecurityQuestionHeaderView.h"
#import "SecurityAnswerFooterView.h"

static NSString * const headerID = @"header";
static NSString * const FooterID = @"footer";
@interface SettingSecurityViewController () <UITableViewDelegate, UITableViewDataSource, SecurityQuestionHeaderViewDelegete>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *firstQArr;
@property (nonatomic, strong)NSMutableArray *secondQArr;
@property (nonatomic, strong)NSMutableArray *thirdQArr;

@property (nonatomic, strong)NSMutableDictionary *foldInfoDict;
@property (nonatomic, strong)SecurityQuestionHeaderView *headerView;

@end

@implementation SettingSecurityViewController
#pragma mark - lazy
- (NSMutableArray *)firstQArr
{
    if (!_firstQArr) {
        _firstQArr = [NSMutableArray arrayWithObjects:@"您母亲的生日?", @"您父亲的生日?", @"您的出生地?", nil];
    }
    return _firstQArr;
}

- (NSMutableArray *)secondQArr
{
    if (!_secondQArr) {
        _secondQArr = [NSMutableArray arrayWithObjects:@"您最喜欢的颜色？", @"您最喜欢的球队？", @"您最喜欢的书籍？", nil];
    }
    return _secondQArr;
}

- (NSMutableArray *)thirdQArr
{
    if (!_thirdQArr) {
        _thirdQArr = [NSMutableArray arrayWithObjects:@"您高中班主任的姓名是？", @"您高中学校名是？", @"对您影响最大的人是？", nil];
    }
    return _thirdQArr;
}


#pragma mark - init
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = ViewBacgroundColor;
    
    _foldInfoDict = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"0",
                                                                    @"1":@"0",
                                                                    @"2":@"0"
                                                                    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTable];
}

- (void)createTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, HEIGHTS - STANDNAV(44)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView registerClass:[SecurityQuestionHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
    [_tableView registerClass:[SecurityAnswerFooterView class] forHeaderFooterViewReuseIdentifier:FooterID];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 44 * HEIGHTMAKE)];
    view.backgroundColor = [UIColor redColor];
    _tableView.tableFooterView = view;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    BOOL folded = [[_foldInfoDict objectForKey:key] boolValue];
    if (section == 0) {
        return folded ? self.firstQArr.count : 0;
    } else if (section == 1) {
        return folded ? self.secondQArr.count : 0;
    } else {
        return folded ? self.thirdQArr.count : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.firstQArr[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.secondQArr[indexPath.row];
    } else {
        cell.textLabel.text = self.thirdQArr[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44 * HEIGHTMAKE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44 * HEIGHTMAKE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 54 * HEIGHTMAKE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    
    if (section == 0) {
        [_headerView setFoldHeaderSectionTitle:@"  密保一:" questionLabel:@" 请选择问题" section:0 canFold:YES];
    } else if (section == 1) {
        [_headerView setFoldHeaderSectionTitle:@"  密保二:" questionLabel:@" 请选择问题" section:1 canFold:YES];
    } else {
        [_headerView setFoldHeaderSectionTitle:@"  密保三:" questionLabel:@" 请选择问题" section:2 canFold:YES];
    }
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    BOOL folded = [[_foldInfoDict valueForKey:key] boolValue];
    _headerView.fold = folded;
    _headerView.delegate = self;
    return _headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SecurityAnswerFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterID];
    if (section == 0) {
        [footerView setTitle:@"   答 案:" answer:nil placeHolder:@"请输入答案一" section:0];
    } else if (section == 1) {
        [footerView setTitle:@"   答 案:" answer:nil placeHolder:@"请输入答案二" section:1];
    } else {
        [footerView setTitle:@"   答 案:" answer:nil placeHolder:@"请输入答案三" section:2];
    }

    return footerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *questionLabel = cell.textLabel.text;
    [self foldHeaderInSection:indexPath.section questionLabel:questionLabel];
}

#pragma mark - SecurityQuestionHeaderViewDelegete
- (void)foldHeaderInSection:(NSInteger)section questionLabel:(NSString *)question
{
    NSString *preKey = [NSString stringWithFormat:@"%d",(int)self.preSection];
    BOOL preFolded = [[_foldInfoDict objectForKey:preKey] boolValue];
    if ((self.preSection != section) && (preFolded == YES)) {
        NSString *preFold = preFolded ? @"0" : @"1";
        [_foldInfoDict setValue:preFold forKey:preKey];
        NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:self.preSection];
        [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
    
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    BOOL folded = [[_foldInfoDict objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDict setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:section];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
    _headerView.questionLabel.text = question;
    self.preSection = section;
}
@end
