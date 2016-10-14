//
//  ConfirmBankCardViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/9.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ConfirmBankCardViewController.h"
#import "UIButton+YPTextFieldButton.h"

@interface ConfirmBankCardViewController ()
@property (nonatomic, strong)UITextField *numField;
@property (nonatomic, strong)UITextField *codeField;
@property (nonatomic, strong)UIButton *confirmBtn;

@property (nonatomic, strong)UIButton *rightView;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger count;
@end

@implementation ConfirmBankCardViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 60;
    
    [self createNav];
    
    [self createUI];
}

- (void)createNav
{
    self.navigationItem.title = @"添加银行卡";
    self.view.backgroundColor = ViewBacgroundColor;
}

- (void)createUI
{
    UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 35 * HEIGHTMAKE)];
    warnLabel.text = @"  信息加密处理，仅用于银行验证";
    warnLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    warnLabel.textColor = [UIColor grayColor];
    [self.view addSubview:warnLabel];
    
    UITextField *numField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(warnLabel.frame) + 1, WIDTHS, 44 * HEIGHTMAKE)];
    numField.backgroundColor = [UIColor whiteColor];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    numLabel.text = @"  手机号";
    NSMutableDictionary *numAttr = [NSMutableDictionary dictionary];
    numAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    numAttr[NSForegroundColorAttributeName] = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [numField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"银行预留手机号" attributes:numAttr]];
    numField.leftView = numLabel;
    numField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 86 * WIDTHMAKE, 33 * HEIGHTMAKE)];
    _rightView = [UIButton buttonWithNormalTitle:@"获取验证码" disableTitle:@"" addTarget:self action:@selector(getPwdClick)];
    _rightView.frame = CGRectMake(0, 0, 80 * WIDTHMAKE, 33 * HEIGHTMAKE);
    [codeView addSubview:_rightView];
    
    numField.rightView = codeView;
    numField.rightViewMode = UITextFieldViewModeAlways;
    
    numField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:numField];
    self.numField = numField;
    
    UITextField *codeField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numField.frame) + 1, WIDTHS, 44 * HEIGHTMAKE)];
    codeField.backgroundColor = [UIColor whiteColor];
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    codeLabel.text = @"  验证码";
    NSMutableDictionary *codeAttr = [NSMutableDictionary dictionary];
    codeAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    codeAttr[NSForegroundColorAttributeName] = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [codeField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:codeAttr]];
    codeField.leftView = codeLabel;
    codeField.leftViewMode = UITextFieldViewModeAlways;
    codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [codeField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:codeField];
    self.codeField = codeField;
    
    UIButton *confirmBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确定" highlightTitle:@"确定" addTarget:self action:@selector(confirmBtnClick)];
    confirmBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(codeField.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, 45 * HEIGHTMAKE);
    [confirmBtn setTitle:@"确定" forState:UIControlStateDisabled];
    [confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    
    if (!self.numField.hasText) {
        self.confirmBtn.enabled = NO;
        [self.confirmBtn setBackgroundColor:[UIColor grayColor]];
    }
}

#pragma mark - confirmBtnClick
- (void)confirmBtnClick
{
    NSLog(@"confirm");
}

#pragma mark - 监听文字改变
- (void)textChanged:(UITextField *)textField
{
    if (textField.hasText) {
        self.confirmBtn.enabled = YES;
        [self.confirmBtn setBackgroundColor:[UIColor colorWithRed:1.0 green:110 / 255.0 blue:135 / 255.0 alpha:1.0]];
    } else {
        self.confirmBtn.enabled = NO;
        [self.confirmBtn setBackgroundColor:[UIColor grayColor]];
    }
}

#pragma mark - getPwdClick
- (void)getPwdClick
{
    [self.view endEditing:YES];
    _rightView.enabled = NO;
    _rightView.backgroundColor = [UIColor grayColor];
    
    [_rightView setTitle:@"60s" forState:UIControlStateDisabled];
    _rightView.titleLabel.font = [UIFont systemFontOfSize:13.99 * WIDTHMAKE];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
}

- (void)timerMethod
{
    [_rightView setTitle:[NSString stringWithFormat:@"%lds", (long)--_count] forState:UIControlStateDisabled];
    if (_count == 0) {
        _count = 60;
        [_timer invalidate];
        _rightView.enabled = YES;
        _rightView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_rightView setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _rightView.enabled = YES;
        _rightView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_rightView setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
@end
