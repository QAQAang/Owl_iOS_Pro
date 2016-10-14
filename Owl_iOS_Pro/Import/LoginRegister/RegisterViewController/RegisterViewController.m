//
//  registerViewController.m
//  Game
//
//  Created by 王艳平 on 16/7/19.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIButton+YPTextFieldButton.h"
#import "UITextField+YPTextField.h"
#import "NickNameViewController.h"
#import <AFNetworking.h>

@interface RegisterViewController () <UITextFieldDelegate>
{
    UIImageView *_leftViewPhoneNum;
    UIImageView *_leftViewCode;
    UIImageView *_leftViewPwd;
    UIButton *_rightViewPwd;
    UIButton *_registerBtn;
}

@property (nonatomic, strong)UITextField *textFieldPhoneNum;

@property (nonatomic, strong)UITextField *textFieldCode;

@property (nonatomic, strong)UITextField *textFieldPwd;

@property (nonatomic, strong)UITextField *textFieldConfirmPwd;

@property (nonatomic, strong) UIButton *rightViewPhoneNum;

@property (nonatomic, strong)UIView *fieldView;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger count;

@end

@implementation RegisterViewController

static CGFloat const YPTextFieldHeight = 45;
static CGFloat const YPRegisterBtnHeight = 45;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 60;
    
    //设置导航栏
    [self setupNav];
    
    //添加输入框
    [self setupTextFiled];
    
    //设置登陆按钮
    [self setupLoginBtn];
    
}

#pragma mark - 注册按钮
- (void)setupLoginBtn
{
    _registerBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"下一步" highlightTitle:@"下一步" addTarget:self action:@selector(nextBtnClick)];
    
    _registerBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(_fieldView.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, YPRegisterBtnHeight * HEIGHTMAKE);
    
    [self.view addSubview:_registerBtn];
}

#pragma mark - nav
- (void)setupNav
{
    self.navigationItem.title = self.NavTitle;
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
    UIView *fieldView = [[UIView alloc] initWithFrame:CGRectMake((WIDTHS - 352 * WIDTHMAKE) / 2, STANDNAV(44) + 13 * HEIGHTMAKE, 352 * WIDTHMAKE, YPTextFieldHeight * 4 * HEIGHTMAKE + 3)];
    fieldView.backgroundColor = [UIColor whiteColor];
    fieldView.layer.cornerRadius = 3 * WIDTHMAKE;
    [self.view addSubview:fieldView];
    self.fieldView = fieldView;
    for (int i = 1; i <= 3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i * YPTextFieldHeight * HEIGHTMAKE, 352 * WIDTHMAKE, 1)];
        line.backgroundColor = ViewBacgroundColor;
        [fieldView addSubview:line];
    }
    
    
    //1
    _leftViewPhoneNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb"]];
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 86 * WIDTHMAKE, 33 * HEIGHTMAKE)];
    _rightViewPhoneNum = [UIButton buttonWithNormalTitle:@"获取验证码" disableTitle:@"" addTarget:self action:@selector(codeBtnClicked)];
    _rightViewPhoneNum.frame = CGRectMake(0, 0, 80 * WIDTHMAKE, 33 * HEIGHTMAKE);
    [codeView addSubview:_rightViewPhoneNum];
    
    _textFieldPhoneNum = [UITextField textFiledLeftView:_leftViewPhoneNum rightView:codeView secureText:NO Placeholder:@"请输入手机号"];
    _textFieldPhoneNum.keyboardType = UIKeyboardTypePhonePad;
    _textFieldPhoneNum.frame = CGRectMake(0, 0, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldPhoneNum];
    
    //2
    _leftViewCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"verificationCode"]];
    _textFieldCode = [UITextField textFiledLeftView:_leftViewCode rightView:nil secureText:NO Placeholder:@"请输入验证码"];
    _textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldCode.frame = CGRectMake(0, CGRectGetMaxY(_textFieldPhoneNum.frame) + 1, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldCode];
    
    //3
    _leftViewPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _rightViewPwd = [UIButton buttonWithImage:@"ipv" selectedImage:@"pv" addTarget:self action:@selector(eyeClick:)];
    _rightViewPwd.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    _textFieldPwd = [UITextField textFiledLeftView:_leftViewPwd rightView:_rightViewPwd secureText:YES Placeholder:@"请输入密码"];
    _textFieldPwd.returnKeyType = UIReturnKeyNext;
    _textFieldPwd.delegate = self;
    _textFieldPwd.frame = CGRectMake(0, CGRectGetMaxY(_textFieldCode.frame) + 1, 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldPwd];
    
    //4
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
        [_textFieldConfirmPwd resignFirstResponder];
    }
    return YES;
}

#pragma mark - 点击下一步
- (void)nextBtnClick
{
    if (self.textFieldCode.text.length == 0 || ![self judgePassWordLegal:self.textFieldPwd.text] || ![self judgePassWordLegal:self.textFieldConfirmPwd.text] || (![self.textFieldPwd.text isEqualToString:self.textFieldConfirmPwd.text])) {
        NSLog(@"输入信息有误啊啊啊啊啊啊啊");
        return;
    }
    
    if ([self.textFieldPwd.text isEqualToString:self.textFieldConfirmPwd.text]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"phone"] = self.textFieldPhoneNum.text;
        param[@"code"] = self.textFieldCode.text;
        param[@"password"] = self.textFieldConfirmPwd.text;
        [manager POST:@"http://192.168.2.168:8080/user/register" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSUInteger index = [[responseObject valueForKeyPath:@"status"] floatValue];
            if (index == 0) {
                NSString *ID = [responseObject[@"data"] valueForKeyPath:@"id"];
                
                [[NSUserDefaults standardUserDefaults] setValue:ID forKeyPath:@"userID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NickNameViewController *nickVc = [[NickNameViewController alloc] init];
                nickVc.userID = ID;
                [self.navigationController pushViewController:nickVc animated:YES];
            } else if (index == 1) {
                NSLog(@"手机号已注册");
            } else if (index == 2) {
                NSLog(@"验证码错误");
            } else if (index == 3) {
                NSLog(@"验证码过期");
            } else {
                NSLog(@"密码格式错误");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    } else {
        NSLog(@"密码不一致");
    }
}

#pragma mark - 判断密码
/**
 * 功能： 判断长度大于6位小于20位并是否同时包含且只有数字和字母
 */
- (BOOL)judgePassWordLegal:(NSString *)text{
    
    BOOL result = false;
    if ([text length] >= 6){
        
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:text];
    }
    return result;
}

#pragma mark - back
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)codeBtnClicked
{
    
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getPwdClick) object:nil];
    [self performSelector:@selector(getPwdClick) withObject:nil afterDelay:0.25f];
}

#pragma mark - getPwdClick
- (void)getPwdClick
{
    if (![self isMobile:self.textFieldPhoneNum.text]) {
        NSLog(@"手机号码不正确啊啊啊啊啊");
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"phone"] = self.textFieldPhoneNum.text;
        param[@"purpose"] = @"register";
        [manager POST:@"http://192.168.2.168:8080/user/getCode" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSUInteger index = [[responseObject valueForKeyPath:@"status"] floatValue];
            if (index == 0) {
                NSLog(@"获取验证码成功");
                
                _rightViewPhoneNum.enabled = NO;
                _rightViewPhoneNum.backgroundColor = [UIColor grayColor];
                
                [_rightViewPhoneNum setTitle:@"60s" forState:UIControlStateDisabled];
                _rightViewPhoneNum.titleLabel.font = [UIFont systemFontOfSize:13.99 * WIDTHMAKE];
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
                
            } else if (index == 1) {
                NSLog(@"手机号已注册");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)timerMethod
{
    [_rightViewPhoneNum setTitle:[NSString stringWithFormat:@"%lds", (long)--_count] forState:UIControlStateDisabled];
    if (_count == 0) {
        _count = 60;
        [_timer invalidate];
        _rightViewPhoneNum.enabled = YES;
        _rightViewPhoneNum.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_rightViewPhoneNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _rightViewPhoneNum.enabled = YES;
        _rightViewPhoneNum.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
        [_rightViewPhoneNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
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


#pragma mark -判断手机号
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
- (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

@end
