//
//  NickNameViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NickNameViewController.h"
#import "NickNameField.h"
#import "UIView+YPFrameExtension.h"
#import "UIButton+YPTextFieldButton.h"
#import <AFNetworking.h>

@interface NickNameViewController () <UITextFieldDelegate>
{
    UIView *_rightView;
}
@property (nonatomic, strong)UILabel *label;

@property (nonatomic, strong) NickNameField *textField;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation NickNameViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(242, 242, 242, 1.0);
    
    [self setNav];
    
    [self createTextField];
    
    [self createSaveBtn];
    
}

- (void)setNav
{
    self.navigationItem.title = @"设置昵称";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [_textField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
}

#pragma mark - 保存
- (void)createSaveBtn
{
    _saveBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确定" highlightTitle:@"确定" addTarget:self action:@selector(saveBtnClick)];
    _saveBtn.frame = CGRectMake(0, CGRectGetMaxY(_textField.frame) + 15 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    _saveBtn.centerX = self.view.centerX;
    [self.view addSubview:_saveBtn];
}

#pragma mark - 创建昵称框
- (void)createTextField
{
    _textField = [[NickNameField alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 44 * HEIGHTMAKE)];
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    _label = [[UILabel alloc] init];
    _label.font = _textField.font;
    _label.textAlignment = NSTextAlignmentRight;
    _label.textColor = COLOR(193, 193, 193, 1.0);
    _label.text = [NSString stringWithFormat:@"0/16"];
    _label.frame = CGRectMake(0, 0, _rightView.width - 10 * WIDTHMAKE, _rightView.height);
    [_rightView addSubview:_label];
    _textField.rightView = _rightView;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
}

- (void)change:(NickNameField *)textField
{
    _label.text = [NSString stringWithFormat:@"%lu/16",(unsigned long)textField.text.length];
    if (textField.text.length > 16) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_label.text];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
        _label.attributedText = attr;
    }
}

#pragma mark - back
- (void)back
{
    //跳转到登录界面
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

#pragma mark - 点击保存
- (void)saveBtnClick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.userID;
    param[@"nickname"] = [NSString stringWithFormat:@"%@",self.textField.text];
    [manager POST:@"http://192.168.2.168:8080/user/perfect" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"注册完成");
        NSLog(@"%@",responseObject);
        //跳转到登录界面
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
