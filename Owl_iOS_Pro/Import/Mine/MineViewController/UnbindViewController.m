//
//  UnbindViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/3.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "UnbindViewController.h"
#import "NameUnbindViewController.h"
#import "SecurityViewController.h"

@interface UnbindViewController ()
@property (nonatomic, strong) NameUnbindViewController *nameVc;
@property (nonatomic, strong) SecurityViewController *sVc;
@property (nonatomic, strong) UIView *indicator;
@end

@implementation UnbindViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(242, 242, 242, 1.0);
    
    [self setNav];
    
    //添加子控制器
    [self setChildViewController];
    
    //创建解绑方式
    [self createUnbindType];
}

- (void)setChildViewController
{
    NameUnbindViewController *nameVc = [[NameUnbindViewController alloc] init];
    _nameVc = nameVc;
    [self addChildViewController:nameVc];
    
    SecurityViewController *sVc = [[SecurityViewController alloc] init];
    _sVc = sVc;
    [self addChildViewController:sVc];
}

- (void)setNav
{
    self.navigationItem.title = @"手机解绑";
}

- (void)createUnbindType
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"实名解绑", @"密保解绑", nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    normalAttr[NSForegroundColorAttributeName] = COLOR(60, 60, 60, 1.0);
    [seg setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    selectedAttr[NSForegroundColorAttributeName] = COLOR(8, 181, 212, 1.0);
    [seg setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    seg.tintColor = [UIColor clearColor];
    seg.selectedSegmentIndex = 0;
    seg.backgroundColor = [UIColor whiteColor];
    seg.frame = CGRectMake(0, STANDNAV(44), WIDTHS, 40 * HEIGHTMAKE);
    [seg addTarget:self action:@selector(unbindBtnClick:) forControlEvents:UIControlEventValueChanged];
    
    //创建指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = COLOR(8, 181, 212, 1.0);
    [seg addSubview:indicator];
    _indicator = indicator;
    [self.view addSubview:seg];
    
    //默认点击第一个
    [self unbindBtnClick:seg];
}

#warning scrollview滑动效果
#pragma mark - 点击解绑方式
- (void)unbindBtnClick:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        //实名解绑
        [UIView animateWithDuration:0.25 animations:^{
            _indicator.frame = CGRectMake(0, seg.frame.size.height, WIDTHS / 2, 2 * HEIGHTMAKE);
        }];
        [self.view addSubview:_nameVc.view];
        [_sVc.view removeFromSuperview];
    } else {
        //密保解绑
        [UIView animateWithDuration:0.25 animations:^{
            _indicator.frame = CGRectMake(WIDTHS / 2, seg.frame.size.height, WIDTHS / 2, 2 * HEIGHTMAKE);
        }];
        [_nameVc.view removeFromSuperview];
        [self.view addSubview:_sVc.view];
    }
}

@end
