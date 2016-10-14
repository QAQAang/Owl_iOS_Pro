//
//  ViewController.m
//  Game
//
//  Created by 王艳平 on 16/7/18.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "LoginViewController.h"
#import "FastLoginViewController.h"
#import "RegisterViewController.h"
#import "UITextField+YPTextField.h"
#import "UIButton+YPTextFieldButton.h"
#import "UIView+YPFrameExtension.h"
#import "ForgetPwdViewController.h"
#import <AFNetworking.h>
//#import <TencentOpenAPI/TencentOAuth.h>


static CGFloat const YPTextFieldHeight = 45;
static CGFloat const YPLoinBtnHeight = 45;
//TencentSessionDelegate
@interface LoginViewController () <UITextFieldDelegate>

{
    
    UIImageView *_leftView;
    UIButton *_rightEyeBtn;
    UIButton *_loginBtn;
    UIButton *_fastLoginBtn;
    UIButton *_forgetPwd;
}
@property (nonatomic, strong)UITextField *textFieldUser;
@property (nonatomic, strong)UITextField *textFieldPwd;
@property (nonatomic, strong)UIView *fieldView;
@property (nonatomic, strong)UIView *thirdLoginView;
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)UIButton *qqBtn;
@property (nonatomic, strong)UIButton *weixinBtn;
@property (nonatomic, strong)UIButton *sinaBtn;
//@property (nonatomic, strong)TencentOAuth *tencentOAuth;
@property (nonatomic, assign)NSUInteger index;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //设置导航栏
    [self setupNav];
    
    //添加输入框
    [self setupTextFiled];
    
    //设置登陆按钮
    [self setupLoginBtn];
    
    //快速登陆
    [self setupFastLogin];
    
    //忘记密码
    [self setupForgetPwd];
    
    //第三方登录
    [self setupThirdLogin];
    
//    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105579525" andDelegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _fastLoginBtn.frame = CGRectMake(WIDTHS - 49 * WIDTHMAKE - _forgetPwd.frame.size.width, _forgetPwd.frame.origin.y, 0, 0);
    [_fastLoginBtn sizeToFit];
    
    _label.center = _topView.center;
    
    _leftView.x = (WIDTHS - 284 * WIDTHMAKE - _label.width) / 2;
    _leftView.centerY = _topView.centerY;
    _leftView.width = 138 * WIDTHMAKE;
    _leftView.height = 1;
    
    _rightView.frame = CGRectMake(CGRectGetMaxX(_label.frame) + 4 * WIDTHMAKE, _leftView.y, _leftView.width, _leftView.height);
    
    _qqBtn.x = 100 * WIDTHMAKE;
    _qqBtn.y = CGRectGetMaxY(_leftView.frame) + 39 * HEIGHTMAKE;
    
    _weixinBtn.x = WIDTHS - CGRectGetMaxX(_qqBtn.frame);
    _weixinBtn.y = _qqBtn.y;
}


#pragma mark - nav
- (void)setupNav
{
    self.title = @"用户登录";
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18 * WIDTHMAKE];
    dic[NSForegroundColorAttributeName] = COLOR(65, 64, 64, 1.0);
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    //注册按钮
    UIBarButtonItem *regiseterBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerClick)];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    dict[NSForegroundColorAttributeName] = COLOR(8, 181, 212, 1.0);
    [regiseterBtn setTitleTextAttributes:dict forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = regiseterBtn;
    
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
    _leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb"]];
    _textFieldUser = [UITextField textFiledLeftView:_leftView rightView:nil secureText:NO Placeholder:@"请输入手机号"];
    if ([[NSUserDefaults standardUserDefaults] valueForKeyPath:@"phone"]) {
        _textFieldUser.text = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"phone"];
    }
    _textFieldUser.keyboardType = UIKeyboardTypePhonePad;
    _textFieldUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldUser.clearsOnBeginEditing = YES;
    _textFieldUser.frame = CGRectMake(0, 0 , 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldUser];
    
    //2
    _leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _rightEyeBtn = [UIButton buttonWithImage:@"ipv" selectedImage:@"pv" addTarget:self action:@selector(eyeClick)];
    _rightEyeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    _textFieldPwd = [UITextField textFiledLeftView:_leftView rightView:_rightEyeBtn secureText:YES Placeholder:@"请输入登录密码"];
    _textFieldPwd.returnKeyType = UIReturnKeyDone;
    _textFieldPwd.delegate = self;
    _textFieldPwd.frame = CGRectMake(0, CGRectGetMaxY(line.frame), 352 * WIDTHMAKE, YPTextFieldHeight * HEIGHTMAKE);
    [fieldView addSubview:_textFieldPwd];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loginBtnClick];
    [self.view endEditing:YES];
    return YES;
}


#pragma mark - 登陆按钮
- (void)setupLoginBtn
{
    _loginBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"登录" highlightTitle:@"登录" addTarget:self action:@selector(loginBtnClick)];
    
    _loginBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(_fieldView.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, YPLoinBtnHeight * HEIGHTMAKE);
    
    [self.view addSubview:_loginBtn];
}


#pragma mark - 忘记密码
- (void)setupForgetPwd
{
    _forgetPwd = [UIButton buttonWithNormalTitle:@"忘记密码" highlightTitle:@"忘记密码" addTarget:self action:@selector(forgetPwdBtnClick)];
    _forgetPwd.frame = CGRectMake(49 * WIDTHMAKE, CGRectGetMaxY(_loginBtn.frame) + 24 * HEIGHTMAKE, 0, 0);
    [_forgetPwd sizeToFit];
    
    [self.view addSubview:_forgetPwd];
}

#pragma mark - 快速登陆
- (void)setupFastLogin
{
    _fastLoginBtn = [UIButton buttonWithNormalTitle:@"快速登录" highlightTitle:@"快速登录" addTarget:self action:@selector(fastLoginBtnClick)];
    [self.view addSubview:_fastLoginBtn];

}

#pragma mark - 第三方登录
- (void)setupThirdLogin
{
    UIView *thirdLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 151 * HEIGHTMAKE, WIDTHS, 151 * HEIGHTMAKE)];
    thirdLoginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:thirdLoginView];
    self.thirdLoginView = thirdLoginView;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 15 * HEIGHTMAKE)];
    [thirdLoginView addSubview:topView];
    self.topView = topView;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"第三方登录";
    label.textColor = COLOR(110, 110, 110, 110);
    label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    [label sizeToFit];
    [topView addSubview:label];
    self.label = label;
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    [topView addSubview:leftView];
    self.leftView = leftView;
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    [topView addSubview:rightView];
    self.rightView = rightView;
    
    //qq
    UIButton *qqBtn = [UIButton buttonWithImage:@"qq" addTarget:self action:@selector(qqbtnClick)];
    [thirdLoginView addSubview:qqBtn];
    self.qqBtn = qqBtn;
    
    //weixin
    UIButton *weixinBtn = [UIButton buttonWithImage:@"weixin" addTarget:self action:@selector(weixinBtnClick)];
    [thirdLoginView addSubview:weixinBtn];
    self.weixinBtn = weixinBtn;
    
}

#pragma mark - fastLoginBtn
- (void)fastLoginBtnClick
{
    FastLoginViewController *flVC = [[FastLoginViewController alloc] init];
    [self.navigationController pushViewController:flVC animated:YES];
}

#pragma mark - 点击登陆
- (void)loginBtnClick
{
    [self loginRequest:self.textFieldUser.text pwd:self.textFieldPwd.text];
    
}

#pragma mark - 登录验证
- (void)loginRequest:(NSString *)phoneText pwd:(NSString *)pwdText
{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phoneText;
    param[@"type"] = @"password";
    param[@"password"] = pwdText;
    [manager POST:@"http://192.168.2.168:8080/user/login" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSUInteger index = [[responseObject valueForKeyPath:@"status"] floatValue];
        if (index == 0) {
            //用户已登录
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //登录成功后改变个人中心headerview
            weakSelf.changeHeaderBlock([responseObject[@"data"] valueForKeyPath:@"nickname"], [responseObject[@"data"] valueForKeyPath:@"id"], [responseObject[@"data"] valueForKeyPath:@"phone"], [responseObject[@"data"] valueForKeyPath:@"head"], pwdText);
            [weakSelf back];
            
        } else if (index == 1) {
            NSLog(@"手机号未注册");
        } else if (index == 2){
            NSLog(@"密码（验证码）错误");
        } else {
            NSLog(@"验证码过期");
        }
        self.index = index;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@---",error);
    }];
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

#pragma mark - 密码是否可见
- (void)eyeClick
{
    _rightEyeBtn.selected = !_rightEyeBtn.isSelected;
    _textFieldPwd.secureTextEntry = !_rightEyeBtn.isSelected;
    //[_textField2 endEditing:YES];
    [self.view endEditing:YES];
}

#pragma mark - 注册监听
- (void)registerClick
{
    RegisterViewController *rVc = [[RegisterViewController alloc] init];
    rVc.NavTitle = @"用户注册";
    [self.navigationController pushViewController:rVc animated:YES];
}


#pragma mark - 点击忘记密码
- (void)forgetPwdBtnClick
{
    ForgetPwdViewController *forgetVc = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetVc animated:YES];
}

#pragma mark - back
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - qqLogin
- (void)qqbtnClick
{
    NSLog(@"qq---");
//    NSArray *ayy = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
//    [self.tencentOAuth authorize:ayy inSafari:NO];
    
}

#pragma mark - weixinLogin
- (void)weixinBtnClick
{
    NSLog(@"weixin---");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 状态栏样式
/*UINavigationController不会将 preferredStatusBarStyle方法调用转给它的子视图,而是由它自己管理状态,而且它也应该那样做.因为UINavigationController 包含了它自己的状态栏
 因此就算 UINavigationController中的viewController 实现了 preferredStatusBarStyle方法 也不会调用.则需要子类化UINavigationController，重写- (UIViewController *)childViewControllerForStatusBarStyle｛ ｝这个方法。
 如果viewController在导航中,还想通过 preferredStatusBarStyle 方法设置状态栏文本颜色,那就只能隐藏导航栏了: */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


#pragma mark - TencentLoginDelegate
//- (void)tencentDidLogin
//{
//    if (self.tencentOAuth.accessToken.length > 0) {
//        // 获取用户信息
//        [self.tencentOAuth getUserInfo];
//        
//        [[NSUserDefaults standardUserDefaults] setValue:self.tencentOAuth.accessToken forKeyPath:@"accessToken"];
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    } else {
//        NSLog(@"登录不成功 没有获取accesstoken");
//    }
//        
//    [self back];
//}

//- (void)tencentDidNotLogin:(BOOL)cancelled
//{
//    if (cancelled) {
//        NSLog(@"用户取消登陆");
//    }
//}
//
//- (void)tencentDidNotNetWork
//{
//    NSLog(@"判断用户网络情况");
//}

//#pragma mark - TencentSessionDelegate
//- (void)getUserInfoResponse:(APIResponse *)response
//{
//    NSString *nickname = [[response valueForKeyPath:@"jsonResponse"] valueForKeyPath:@"nickname"];
//    NSString *icon = [[response valueForKeyPath:@"jsonResponse"] valueForKeyPath:@"figureurl_qq_2"];
//
//    self.qqBlock(nickname, icon);
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"token"] = self.tencentOAuth.accessToken;
//    param[@"nickname"] = nickname;
//    //接收类型不一致请替换一致text/html或别的
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         @"text/html",
//                                                         @"image/jpeg",
//                                                         @"image/png",
//                                                         @"application/octet-stream",
//                                                         @"text/json", nil];
//
//    [manager POST:@"http://192.168.2.168:8080/user/loginByToken" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSString *fileName = [NSString stringWithFormat:@"123.png"];
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon]]];
//        NSData *imagedata = UIImagePNGRepresentation(image);
//        [formData appendPartWithFileData:imagedata name:@"file" fileName:fileName mimeType:@"image/png"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@------",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@++++++",error);
//    }];
//
//    
//}


#pragma mark - 判断手机号码格式
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textFieldPwd) {
        BOOL isMobile = [self isMobile:self.textFieldUser.text];
        if (!isMobile) {
            NSLog(@"手机格式不正确");
            [self.textFieldUser becomeFirstResponder];
        }
    }
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
