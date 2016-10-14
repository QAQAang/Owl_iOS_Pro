//
//  DetailAssessViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/21.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "DetailAssessViewController.h"
#import "UIView+YPFrameExtension.h"

@interface DetailAssessViewController ()

@end

@implementation DetailAssessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createNav];
    
    [self createUI];
}

- (void)createUI
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 186 * HEIGHTMAKE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(13 * WIDTHMAKE, 13 * HEIGHTMAKE, 59 * WIDTHMAKE, 59 * WIDTHMAKE)];
    [view addSubview:icon];
    
    UITextView *assessView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 9 * WIDTHMAKE, 20 * HEIGHTMAKE, WIDTHS - 95 * WIDTHMAKE, 100 * HEIGHTMAKE)];
    [view addSubview:assessView];
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 140 * HEIGHTMAKE, WIDTHS, 1 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(217, 217, 217, 1.0);
    [view addSubview:lineOne];
    
    UILabel *gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.x, CGRectGetMaxY(lineOne.frame), 44 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    gradeLabel.font = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    gradeLabel.textColor = COLOR(60, 60, 60, 1.0);
    gradeLabel.text = @"评分";
    [view addSubview:gradeLabel];
    
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS - 160 * WIDTHMAKE, CGRectGetMaxY(lineOne.frame), 150 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    [view addSubview:starView];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(starView.frame), WIDTHS, 1 * HEIGHTMAKE)];
    lineTwo.backgroundColor = COLOR(217, 217, 217, 1.0);
    [view addSubview:lineTwo];
    
}

- (void)createNav
{
    self.navigationItem.title = @"发表评价";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitClick)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
}

- (void)commitClick
{
    NSLog(@">>><<><>");
}
- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
