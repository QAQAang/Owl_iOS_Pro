//
//  ForgetPwdViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/24.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "UIButton+YPTextFieldButton.h"
#import "UITextField+YPTextField.h"
#import "UIView+YPFrameExtension.h"
#import "ConfirmPwdViewController.h"

static CGFloat const YPTextFieldHeight = 45;
static CGFloat const YPLoinBtnHeight = 45;

@interface ForgetPwdViewController ()
{
    UIImageView *_leftViewPhoneNum;
    UIImageView *_leftViewCode;
    UIButton *_rightView;
    UITextField *_textFieldPhoneNum;
    UITextField *_textFieldCode;
    UIButton *_loginBtn;
    UIButton *_pwdLoginBtn;
}

@property (nonatomic, strong)UIView *fieldView;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger count;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 60;
    
    //设置导航栏
    [self setupNav];
    
    //添加输入框
    [self setupTextFiled];
    
    //设置 下一步 按钮
    [self setupNextBtn];
    
}

#pragma mark - 下一步
- (void)setupNextBtn
{
    _loginBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"下一步" highlightTitle:@"下一步" addTarget:self action:@selector(nextBtnClick)];
    
    _loginBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(_fieldView.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, YPLoinBtnHeight * HEIGHTMAKE);
    
    [self.view addSubview:_loginBtn];
}

#pragma mark - nav
- (void)setupNav
{
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18 * WIDTHMAKE];
    dic[NSForegroundColorAttributeName] = COLOR(65, 64, 64, 1.0);
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

#pragma mark - 添加输入框
- (void)setupTextFiled
{
    UIView *fieldView = [[UIView alloc] initWithFrame:CGRectMake((WIDTHS - 352 * WIDTHMAKE) / 2, STANDNAV(44) + 13 * HEIGHTMAKE, 352 * WIDTHMAKE, YPTextFieldHeight * 2 * HEIGHTMAKE + 1)];
    fieldView.backgroundColor = [UIColor whiteColor];
    fieldView.layer.cornerRadius = 3 * WIDTHMAKE;
    [self.view addSubview:fieldView];
    self.fieldView = fieldView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, YPTextFieldHeight * HEIGHTMAKE, 352 * WIDTHMAKE, 1)];
    line.backgroundColor = ViewBacgroundColor;
    [fieldView addSubview:line];
    
    //1
    _leftViewPhoneNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb"]];
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 86 * WIDTHMAKE, 33 * HEIGHTMAKE)];
    _rightView = [UIButton buttonWithNormalTitle:@"获取验证码" disableTitle:@"" addTarget:self action:@selector(getPwdClick)];
    _rightView.frame = CGRectMake(0, 0, 80 * WIDTHMAKE, 33 * HEIGHTMAKE);
    [codeView addSubview:_rightView];
    
    _textFieldPhoneNum = [UITextField textFiledLeftView:_leftViewPhoneNum rightView:codeView secureText:NO Placeholder:@"请输入手机号"];
    _textFieldPhoneNum.keyboardType = UIKeyboardTypePhonePad;
    _textFieldPhoneNum.frame = CGRectMake(0, 0, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldPhoneNum];
    
    //2
    _leftViewCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"verificationCode"]];
    _textFieldCode = [UITextField textFiledLeftView:_leftViewCode rightView:nil secureText:NO Placeholder:@"请输入验证码"];
    _textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldCode.frame = CGRectMake(0, CGRectGetMaxY(line.frame), 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldCode];
}

#pragma mark - 点击下一步
- (void)nextBtnClick
{
    [self.view endEditing:YES];
    ConfirmPwdViewController *confirmVc = [[ConfirmPwdViewController alloc] init];
    [self.navigationController pushViewController:confirmVc animated:YES];
}


#pragma mark - back
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
