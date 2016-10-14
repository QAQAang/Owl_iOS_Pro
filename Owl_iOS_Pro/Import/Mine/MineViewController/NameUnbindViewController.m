//
//  NameUnbindViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/3.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NameUnbindViewController.h"
#import "UITextField+YPTextField.h"
#import "UIButton+YPTextFieldButton.h"
#import "UIView+YPFrameExtension.h"

@interface NameUnbindViewController () <UITextFieldDelegate>
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UITextField *nameField;
@property (nonatomic, strong)UITextField *idField;
@property (nonatomic, strong)UITextField *numField;
@property (nonatomic, strong)UITextField *codeField;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)UIButton *btn;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger count;
@end

@implementation NameUnbindViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 60;
    
    self.view.frame = CGRectMake(0, STANDNAV(44) + 42 * HEIGHTMAKE, WIDTHS, HEIGHTS - STANDNAV(44) + 40 * HEIGHTMAKE);
    self.view.backgroundColor = ViewBacgroundColor;

    [self createView];
    
    //创建输入框
    [self createTextField];
    
    //创建确认按钮
    [self createConfirmBtn];
}

- (void)createConfirmBtn
{
    _confirmBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确认" highlightTitle:@"确  认" addTarget:self action:@selector(confirmBtnClick)];
    _confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(_codeField.frame) + 15 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    _confirmBtn.centerX = self.view.centerX;
    [self.view addSubview:_confirmBtn];
}

- (void)createView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 178.1 * HEIGHTMAKE)];
    _contentView = view;
    [self.view addSubview:view];
}

#define labelWidth 85
- (void)createTextField
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"  姓 名：";
    nameLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    nameLabel.textColor = COLOR(60, 60, 60, 1.0);
    nameLabel.frame = CGRectMake(0, 0, (labelWidth - 20) * WIDTHMAKE, 44 * HEIGHTMAKE);
    _nameField = [UITextField textFieldLeftView:nameLabel rightView:nil text:nil];
    _nameField.frame = CGRectMake(0, 0, WIDTHS, 44 * HEIGHTMAKE);
    [_contentView addSubview:_nameField];
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameField.frame), WIDTHS, 0.5 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(200, 199, 204, 1.0);
    [_contentView addSubview:lineOne];
    
    UILabel *idLabel = [[UILabel alloc] init];
    idLabel.text = @"  身份证号：";
    idLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    idLabel.textColor = COLOR(60, 60, 60, 1.0);
    idLabel.frame = CGRectMake(0, 0, labelWidth * WIDTHMAKE, 44 * HEIGHTMAKE);
    _idField = [UITextField textFieldLeftView:idLabel rightView:nil text:nil];
    _idField.frame = CGRectMake(0, CGRectGetMaxY(lineOne.frame) + 0.3 * HEIGHTMAKE, WIDTHS, 44 * HEIGHTMAKE);
    [_contentView addSubview:_idField];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_idField.frame), WIDTHS, 0.5 * HEIGHTMAKE)];
    lineTwo.backgroundColor = COLOR(200, 199, 204, 1.0);
    [_contentView addSubview:lineTwo];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = @"  新手机号：";
    numLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    numLabel.textColor = COLOR(60, 60, 60, 1.0);
    numLabel.frame = CGRectMake(0, 0, labelWidth * WIDTHMAKE, 44 * HEIGHTMAKE);
    
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 86 * WIDTHMAKE, 33 * HEIGHTMAKE)];
    _btn = [UIButton buttonWithNormalTitle:@"获取验证码" disableTitle:@"" addTarget:self action:@selector(getPwdClick)];
    _btn.frame = CGRectMake(0, 0, 80 * WIDTHMAKE, 33 * HEIGHTMAKE);
    [codeView addSubview:_btn];
    _numField = [UITextField textFieldLeftView:numLabel rightView:codeView text:nil];
    _numField.delegate = self;
    _numField.frame = CGRectMake(0, CGRectGetMaxY(lineTwo.frame) + 0.3 * HEIGHTMAKE, WIDTHS, 44 * HEIGHTMAKE);
    [_contentView addSubview:_numField];
    
    UIView *lineThree = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_numField.frame), WIDTHS, 0.5 * HEIGHTMAKE)];
    lineThree.backgroundColor = COLOR(200, 199, 204, 1.0);
    [_contentView addSubview:lineThree];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"  验证码：";
    codeLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    codeLabel.textColor = COLOR(60, 60, 60, 1.0);
    codeLabel.frame = CGRectMake(0, 0, (labelWidth - 15) * WIDTHMAKE, 44 * HEIGHTMAKE);
    _codeField = [UITextField textFieldLeftView:codeLabel rightView:nil text:nil];
    _codeField.frame = CGRectMake(0, CGRectGetMaxY(lineThree.frame) + 0.3 * HEIGHTMAKE, WIDTHS, 44 * HEIGHTMAKE);
    [_contentView addSubview:_codeField];
}

#pragma mark - getPwdClick
- (void)getPwdClick
{
    _btn.enabled = NO;
    _btn.backgroundColor = [UIColor grayColor];
    [_btn setTitle:@"60s" forState:UIControlStateDisabled];
    _btn.titleLabel.font = [UIFont systemFontOfSize:13.99 * WIDTHMAKE];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];

}

- (void)timerMethod
{
    [_btn setTitle:[NSString stringWithFormat:@"%lds", (long)_count] forState:UIControlStateDisabled];
    if (_count == 0) {
        _count = 60;
        [_timer invalidate];
        _btn.enabled = YES;
        _btn.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _btn.enabled = YES;
        _btn.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

#pragma mark - 限制电话号码位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 11) {
        return NO;
    }
    return YES;
}

#pragma mark - confirmBtnClick
- (void)confirmBtnClick
{
    NSLog(@"确认");
}
@end
