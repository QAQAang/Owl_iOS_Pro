//
//  SalerAuthenViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/23.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SalerAuthenViewController.h"
#import "UIView+YPFrameExtension.h"
#import "UIButton+YPTextFieldButton.h"

@interface SalerAuthenViewController ()

@end

@implementation SalerAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createNav];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)createNav
{
    self.navigationItem.title = @"商家认证";
}

- (void)createUI
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(12 * WIDTHMAKE, STANDNAV(44) + 26 * HEIGHTMAKE, WIDTHS - 10 *WIDTHMAKE, 20 * HEIGHTMAKE)];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"椭圆"]];
    icon.frame = CGRectMake(0, 0, 0, 0);
    [icon sizeToFit];
    [topView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 10 *WIDTHMAKE, 0, topView.width - icon.width - 10 * WIDTHMAKE, icon.height)];
    label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    label.textColor = COLOR(65, 64, 64, 1.0);
    label.text = @"商家认须知:";
    [topView addSubview:label];
    [self.view addSubview:topView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, CGRectGetMaxY(topView.frame), WIDTHS - 20 * HEIGHTMAKE, 200 * HEIGHTMAKE)];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = COLOR(104, 104, 104, 1.0);
    textView.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    textView.text = @"1、支付一年（240元）成为认证商家后，在一年之内可以无限次发布商品。\n\n2、账户使用时间需大于半年，若时间期限不到半年，我们将按使用月数扣除相应的保障金（20元/月）,不足一月将按一月计算。\n\n3、账户使用时间满一年则平台将会返还商家保障金。\n\n4、若商家在与用户交易商品过程中存在任何过失，则平台会从商家保障金中扣除5元作为赔偿金。";
    [self.view addSubview:textView];
    
    UIButton *commitBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"同意认证并支付保障金" highlightTitle:@"同意认证并支付保障金" addTarget:self action:@selector(commitBtnClick)];
    commitBtn.frame = CGRectMake(12 * WIDTHMAKE, CGRectGetMaxY(textView.frame) + 40 * HEIGHTMAKE, WIDTHS - 24 * WIDTHMAKE, 44 * HEIGHTMAKE);
    [self.view addSubview:commitBtn];
}

- (void)commitBtnClick
{
    NSLog(@"提交");
}
@end
