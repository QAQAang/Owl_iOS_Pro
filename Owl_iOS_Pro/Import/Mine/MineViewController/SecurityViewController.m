//
//  SecurityViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/3.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SecurityViewController.h"
#import "UITextField+YPTextField.h"
#import "UIButton+YPTextFieldButton.h"
#import "UIView+YPFrameExtension.h"

@interface SecurityViewController () <UITextFieldDelegate>
@property (nonatomic, assign)UIView *contentView;
@property (nonatomic, assign)UIView *firstView;
@property (nonatomic, assign)UIView *secondView;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UITextField *answerField;
@property (nonatomic, strong)UITextField *numField;
@property (nonatomic, strong)UITextField *codeField;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, copy)NSArray *array;
@end

@implementation SecurityViewController

#define labelWidth 85

- (NSArray *)array
{
    if (!_array) {
        _array = @[[NSString stringWithFormat:@"  密保二：%@",@"您的父亲是谁？"], @"  密保一：您的出生地在哪？", @"  密保三：您的母亲是谁？"];
    }
    return _array;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 60;
    self.view.frame = CGRectMake(0, STANDNAV(44) + 42 * HEIGHTMAKE, WIDTHS, HEIGHTS - STANDNAV(44) - 42 * HEIGHTMAKE);
    self.view.backgroundColor = ViewBacgroundColor;
    
    //创建输入框
    [self createTextField];
    
    //创建确认按钮
    [self createNextBtn];
    
//    创建confirm的view
//    [self createConfirmView];
}

- (void)createConfirmView
{
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS - STANDNAV(44) - 42 * HEIGHTMAKE)];
    self.secondView = secondView;
    [self.view addSubview:secondView];
    
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
    _numField.frame = CGRectMake(0, 0, WIDTHS, 44 * HEIGHTMAKE);
    [secondView addSubview:_numField];

    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_numField.frame), WIDTHS, 0.5 * HEIGHTMAKE)];
    lineTwo.backgroundColor = COLOR(200, 199, 204, 1.0);
    [secondView addSubview:lineTwo];

    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"  验证码：";
    codeLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    codeLabel.textColor = COLOR(60, 60, 60, 1.0);
    codeLabel.frame = CGRectMake(0, 0, (labelWidth - 15) * WIDTHMAKE, 44 * HEIGHTMAKE);
    _codeField = [UITextField textFieldLeftView:codeLabel rightView:nil text:nil];
    _codeField.frame = CGRectMake(0, CGRectGetMaxY(lineTwo.frame), WIDTHS, 44 * HEIGHTMAKE);
    [secondView addSubview:_codeField];
    
    _confirmBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确认" highlightTitle:@"确  认" addTarget:self action:@selector(confirmBtnClick)];
    _confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(_codeField.frame) + 15 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    _confirmBtn.centerX = self.view.centerX;
    [secondView addSubview:_confirmBtn];
}

- (void)createNextBtn
{
    _nextBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"下一步" highlightTitle:@"下一步" addTarget:self action:@selector(nextBtnClick)];
    _nextBtn.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame) + 15 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    _nextBtn.centerX = self.view.centerX;
    [self.firstView addSubview:_nextBtn];
}

- (void)createTextField
{
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS - STANDNAV(44) - 42 * HEIGHTMAKE)];
    self.firstView = firstView;
    [self.view addSubview:firstView];
    
    for (int i = 0; i < self.array.count; i++) {
        UIView *QAView = [[UIView alloc] initWithFrame:CGRectMake(0,i * 88 * HEIGHTMAKE, WIDTHS, 88 * HEIGHTMAKE)];
        QAView.backgroundColor = [UIColor clearColor];
        _contentView = QAView;
        [self.firstView addSubview:QAView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 44 * HEIGHTMAKE)];
        label.text = _array[i];
        label.backgroundColor = ViewBacgroundColor;
        label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        label.textColor = COLOR(60, 60, 60, 1.0);
        [QAView addSubview:label];
        
        UILabel *answerLabel = [[UILabel alloc] init];
        answerLabel.text = @"  答 案：";
        answerLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        answerLabel.textColor = COLOR(60, 60, 60, 1.0);
        answerLabel.frame = CGRectMake(0, 0, (labelWidth - 20) * WIDTHMAKE, 44 * HEIGHTMAKE);
        _answerField = [UITextField textFieldLeftView:answerLabel rightView:nil text:nil];
        _answerField.frame = CGRectMake(0, 44 * HEIGHTMAKE, WIDTHS, 44 * HEIGHTMAKE);
        [QAView addSubview:_answerField];
    }
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
    [_btn setTitle:[NSString stringWithFormat:@"%lds", (long)--_count] forState:UIControlStateDisabled];
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
- (void)nextBtnClick
{
    [self.firstView removeFromSuperview];
    [self createConfirmView];
}

#pragma mark - confirmBtnClick
- (void)confirmBtnClick
{
    NSLog(@"确认");
}

@end
