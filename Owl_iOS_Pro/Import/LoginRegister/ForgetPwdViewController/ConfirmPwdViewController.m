//
//  ConfirmPwdViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/24.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ConfirmPwdViewController.h"
#import "UIButton+YPTextFieldButton.h"
#import "UITextField+YPTextField.h"

@interface ConfirmPwdViewController () <UITextFieldDelegate>
{
    UIImageView *_leftViewPwd;
    UIButton *_rightViewPwd;
    UITextField *_textFieldPwd;
    UITextField *_textFieldConfirmPwd;
    UIButton *_confirmBtn;
}
@property (nonatomic, strong)UIView *fieldView;
@end

@implementation ConfirmPwdViewController

static CGFloat const YPTextFieldHeight = 45;
static CGFloat const YPRegisterBtnHeight = 45;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //添加输入框
    [self setupTextFiled];
    
    //设置确认按钮
    [self setupConfirmBtn];
    
}

#pragma mark - 确认按钮
- (void)setupConfirmBtn
{
    _confirmBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确认" highlightTitle:@"确 认" addTarget:self action:@selector(confirmBtnClick)];
    
    _confirmBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(_fieldView.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, YPRegisterBtnHeight * HEIGHTMAKE);
    
    [self.view addSubview:_confirmBtn];
}

#pragma mark - nav
- (void)setupNav
{
    self.title = @"修改密码";
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18 * WIDTHMAKE];
    dic[NSForegroundColorAttributeName] = COLOR(65, 64, 64, 1.0);
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    
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
    _leftViewPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _rightViewPwd = [UIButton buttonWithImage:@"ipv" selectedImage:@"pv" addTarget:self action:@selector(eyeClick:)];
    _rightViewPwd.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    _textFieldPwd = [UITextField textFiledLeftView:_leftViewPwd rightView:_rightViewPwd secureText:YES Placeholder:@"请输入密码"];
    _textFieldPwd.returnKeyType = UIReturnKeyNext;
    _textFieldPwd.delegate = self;
    _textFieldPwd.frame = CGRectMake(0, 0, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldPwd];
    
    //2
    _leftViewPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _rightViewPwd = [UIButton buttonWithImage:@"ipv" selectedImage:@"pv" addTarget:self action:@selector(eyeClick:)];
    _rightViewPwd.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    _textFieldConfirmPwd = [UITextField textFiledLeftView:_leftViewPwd rightView:_rightViewPwd secureText:YES Placeholder:@"请输入确认密码"];
    _textFieldConfirmPwd.returnKeyType = UIReturnKeyDone;
    _textFieldConfirmPwd.delegate = self;
    _textFieldConfirmPwd.frame = CGRectMake(0, CGRectGetMaxY(_textFieldPwd.frame) + 1, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldConfirmPwd];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textFieldPwd) {
        [_textFieldConfirmPwd becomeFirstResponder];
    } else if (textField == _textFieldConfirmPwd) {
        [self confirmBtnClick];
        [_textFieldConfirmPwd resignFirstResponder];
    }
    return YES;
}

#pragma mark - 点击确认
- (void)confirmBtnClick
{
    NSLog(@"%s",__func__);
    [_textFieldConfirmPwd resignFirstResponder];
}


#pragma mark - back
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 密码是否可见
- (void)eyeClick:(UIButton *)eyeBtn
{
    eyeBtn.selected = !eyeBtn.isSelected;
    
    if (eyeBtn == _rightViewPwd) {
        _textFieldConfirmPwd.secureTextEntry = !eyeBtn.isSelected;
    } else {
        _textFieldPwd.secureTextEntry = !eyeBtn.isSelected;
    }
    [self.view endEditing:YES];
}

@end
