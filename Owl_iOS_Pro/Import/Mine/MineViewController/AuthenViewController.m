//
//  AuthenViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuthenViewController.h"
#import "UITextField+YPTextField.h"
#import "UIButton+YPTextFieldButton.h"
#import "UIView+YPFrameExtension.h"

#define labelWidth 85

@interface AuthenViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong)UITextField *nameField;
@property (nonatomic, strong)UITextField *idField;
@property (nonatomic, strong)UIView *otherSideView;
@property (nonatomic, strong)UIImageView *sideImageView;
@property (nonatomic, strong)UIImageView *otherSideImageView;
@property (nonatomic, strong)UITapGestureRecognizer *sideTap;
@property (nonatomic, strong)UITapGestureRecognizer *otherSideTap;
@end


@implementation AuthenViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self setNav];
    
    [self createField];
    
    [self confirmBtn];
}

- (void)setNav
{
    self.navigationItem.title = @"实名认证";
}

- (void)createField
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"  姓 名：";
    nameLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    nameLabel.textColor = COLOR(60, 60, 60, 1.0);
    nameLabel.frame = CGRectMake(0, 0, (labelWidth - 20) * WIDTHMAKE, 44 * HEIGHTMAKE);
    _nameField = [UITextField textFieldLeftView:nameLabel rightView:nil text:nil];
    _nameField.frame = CGRectMake(0, STANDNAV(44), WIDTHS, 44 * HEIGHTMAKE);
    [self.view addSubview:_nameField];
    
    UILabel *idLabel = [[UILabel alloc] init];
    idLabel.text = @"  身份证号：";
    idLabel.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    idLabel.textColor = COLOR(60, 60, 60, 1.0);
    idLabel.frame = CGRectMake(0, 0, labelWidth * WIDTHMAKE, 44 * HEIGHTMAKE);
    _idField = [UITextField textFieldLeftView:idLabel rightView:nil text:nil];
    _idField.frame = CGRectMake(0, CGRectGetMaxY(_nameField.frame) + 1 * HEIGHTMAKE, WIDTHS, 44 * HEIGHTMAKE);
    [self.view addSubview:_idField];
    
    UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_idField.frame), WIDTHS, 200 * HEIGHTMAKE)];
    sideView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sideView];
    UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 40 * HEIGHTMAKE)];
    sideLabel.text = @"身份证正面照";
    sideLabel.textColor = COLOR(60, 60, 60, 1.0);
    sideLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    sideLabel.textAlignment = NSTextAlignmentCenter;
    [sideView addSubview:sideLabel];
    
    UIImage *sideImage = [UIImage imageNamed:@"上传身份证"];
    UIImageView *sideImageView = [[UIImageView alloc] initWithImage:sideImage];
    sideImageView.frame = CGRectMake(0, CGRectGetMaxY(sideLabel.frame), sideImage.size.width, sideImage.size.height);
    sideImageView.userInteractionEnabled = YES;
    sideImageView.centerX = sideView.centerX;
    [sideView addSubview:sideImageView];
    self.sideImageView = sideImageView;
    UITapGestureRecognizer *sideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseIDCard)];
    self.sideTap = sideTap;
    [sideImageView addGestureRecognizer:sideTap];
    
    UIView *otherSideView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sideView.frame), WIDTHS, 200 * HEIGHTMAKE)];
    otherSideView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:otherSideView];
    self.otherSideView = otherSideView;
    UILabel *otherSideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 40 * HEIGHTMAKE)];
    otherSideLabel.text = @"身份证背面照";
    otherSideLabel.textColor = COLOR(60, 60, 60, 1.0);
    otherSideLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    otherSideLabel.textAlignment = NSTextAlignmentCenter;
    [otherSideView addSubview:otherSideLabel];
    
    UIImage *otherSideImage = [UIImage imageNamed:@"上传身份证背面"];
    UIImageView *otherSideImageView = [[UIImageView alloc] initWithImage:otherSideImage];
    otherSideImageView.userInteractionEnabled = YES;
    otherSideImageView.frame = CGRectMake(0, CGRectGetMaxY(otherSideLabel.frame), otherSideImage.size.width, otherSideImage.size.height);
    otherSideImageView.centerX = otherSideView.centerX;
    [otherSideView addSubview:otherSideImageView];
    self.otherSideImageView = otherSideImageView;
    UITapGestureRecognizer *otherSideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseIDCard)];
    self.otherSideTap = otherSideTap;
    [otherSideImageView addGestureRecognizer:otherSideTap];
}

- (void)confirmBtn
{
    UIButton *confirmBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"确认" highlightTitle:@"确  认" addTarget:self action:@selector(confirmBtnClick)];
    confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(_otherSideView.frame) + 20 * HEIGHTMAKE, 355 * WIDTHMAKE, 44 * HEIGHTMAKE);
    confirmBtn.centerX = self.view.centerX;
    [self.view addSubview:confirmBtn];
}

#pragma mark - confirmBtnClick
- (void)confirmBtnClick
{
    NSLog(@"确认");
}

#pragma 上传身份证
- (void)chooseIDCard
{
    NSLog(@"sss");
}

- (void)dealloc
{
    [self.sideImageView removeGestureRecognizer:_sideTap];
    [self.otherSideImageView removeGestureRecognizer:_otherSideTap];
}
@end
