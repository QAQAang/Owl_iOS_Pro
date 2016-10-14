//
//  OrderViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/28.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "OrderViewController.h"
#import "UIView+YPFrameExtension.h"
#import "OrderStatusViewController.h"
#import "OrderAllViewController.h"
#import "OrderDealingViewController.h"
#import "OrderAssessViewController.h"

@interface OrderViewController () <UIScrollViewDelegate>
@property (nonatomic, copy)NSString *noticeText;
@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)NSMutableArray *btnArray;
@property (nonatomic, strong)UIButton *preSelectedBtn;
@property (nonatomic, strong)UIView *indicator;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation OrderViewController

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createNotifacation];
    
    [self createNav];
    
    [self createChildViewController];
    
    [self createScrollView];
    
    [self createTopView];
    
}

//默认点击第一个按钮
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self btnClick:self.btnArray[0]];
//}
#pragma mark - addChildViewController
- (void)createChildViewController
{
    OrderAllViewController *allVc = [[OrderAllViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    OrderDealingViewController *dealVc = [[OrderDealingViewController alloc] init];
    dealVc.title = @"待交易";
    [self addChildViewController:dealVc];
    
    OrderAssessViewController *assessVc = [[OrderAssessViewController alloc] init];
    assessVc.title = @"待评价";
    [self addChildViewController:assessVc];
}


#pragma mark - ScrollView
- (void)createScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * WIDTHS, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //默认显示第0个控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 订单选项
- (void)createTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 40 * HEIGHTMAKE)];
    topView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonW = WIDTHS / self.childViewControllers.count;
        CGFloat buttonH = topView.height;
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
        norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
        norAttr[NSForegroundColorAttributeName] = COLOR(65, 64, 64, 1.0);
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.childViewControllers[i] title] attributes:norAttr] forState:UIControlStateNormal];
        
        NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
        selAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
        selAttr[NSForegroundColorAttributeName] = COLOR(8, 181, 212, 1.0);
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.childViewControllers[i] title] attributes:selAttr] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
        [topView addSubview:button];
    }
    
    [self.view addSubview:topView];
    self.topView = topView;
    
    //创建指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.y = topView.height - 2 * HEIGHTMAKE;
    indicator.height = 2 * HEIGHTMAKE;
    indicator.backgroundColor = COLOR(8, 181, 212, 1.0);
    [self.topView addSubview:indicator];
    self.indicator = indicator;
    
    //默认点击第一个按钮
    UIButton *firstBtn = self.btnArray.firstObject;
    [firstBtn.titleLabel sizeToFit];
    indicator.width = firstBtn.titleLabel.width;
    indicator.centerX = firstBtn.centerX;
    [self btnClick:firstBtn];
}


#pragma mark - btnClick
- (void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
    }];
    
    if (!btn.isSelected) {
        self.preSelectedBtn.selected = NO;
        btn.selected = YES;
        self.preSelectedBtn = btn;
    } else {
        #warning 刷新
    }
    
    //调整相应的scrollView
    NSInteger index = [self.btnArray indexOfObject:btn];
    CGPoint offsetX = self.scrollView.contentOffset;
    offsetX.x = index * WIDTHS;
    [self.scrollView setContentOffset:offsetX animated:YES];
}

#pragma mark - 导航栏
- (void)createNav
{
    self.navigationItem.title = @"我的订单";
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //滚动结束后才显示相应控制器的view
    NSInteger index = scrollView.contentOffset.x / WIDTHS;
    UIViewController *willShowVc = self.childViewControllers[index];
    
    if (willShowVc.isViewLoaded) return;
    willShowVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动结束后，显示相应的按钮
    NSInteger index = scrollView.contentOffset.x / WIDTHS;
    UIButton *btn = [self.btnArray objectAtIndex:index];
    [self btnClick:btn];
    //设置下面这句才能显示willShow.view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 创建通知
- (void)createNotifacation
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"publish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusBar:) name:@"closePublish" object:nil];
}

#pragma mark - 更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ([self.noticeText isEqualToString:@"publish"]) {
        return UIStatusBarStyleDefault;
    } else if ([self.noticeText isEqualToString:@"closePublish"]) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

#pragma mark - 监听通知
- (void)changeStatusBar:(id)sender
{
    self.noticeText = [sender valueForKeyPath:@"name"];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"publish" object:nil];
}

@end
