//
//  FeedBackViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIButton+YPTextFieldButton.h"
#import "UIView+YPFrameExtension.h"
#import "YPTextView.h"

@interface FeedBackViewController ()
@property (nonatomic, strong)UITextView *textView;
@end

@implementation FeedBackViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self setNav];
    
    [self createView];
    
    [self submitBtn];
}

- (void)setNav
{
    self.navigationItem.title = @"意见反馈";
}

- (void)createView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 36 * HEIGHTMAKE)];
    label.text = @"  您的宝贵意见是我们成长的动力";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    label.textColor = COLOR(125, 125, 125, 1.0);
    [self.view addSubview:label];
    
    YPTextView *textView = [[YPTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), WIDTHS, 165 * HEIGHTMAKE)];
    _textView = textView;
    textView.placeholder = @"请输入您的宝贵意见";
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
}

- (void)submitBtn
{
    UIButton *submitBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"提交" highlightTitle:@"提 交" addTarget:self action:@selector(submitBtnClick)];
    submitBtn.frame = CGRectMake(0, CGRectGetMaxY(_textView.frame) + 65 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    submitBtn.centerX = self.view.centerX;
    [self.view addSubview:submitBtn];
}

#pragma mark - 点击提交
- (void)submitBtnClick
{
    NSLog(@"点击提交");
}
@end
