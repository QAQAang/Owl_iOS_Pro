//
//  PicViewController.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PicViewController.h"
#import "ListView.h"
@interface PicViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain)UIScrollView *backGroundView;

@property (nonatomic, retain)NSMutableArray *imgSizeArr;

@property (nonatomic, retain)UILabel *label;

@property (nonatomic, retain)UIView *fliter;

@property (nonatomic, retain)ListView *listView;

@property (nonatomic, retain)UIButton *returnBtn;

@end

@implementation PicViewController

- (NSMutableArray *)imgSizeArr{
    if (_imgSizeArr == nil) {
        _imgSizeArr = [NSMutableArray array];
        for (UIImage *image in self.imgArr) {
            CGFloat imgHeight = WIDTHS / image.size.width * image.size.height;
            NSString *hgt = [NSString stringWithFormat:@"%lf", imgHeight];
            [_imgSizeArr addObject:hgt];
        }
    }
    return _imgSizeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self creatScroll];
    [self creatTitle];
    [self creatFliter];
}

- (void)creatTitle{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHS / 2 - 60 * WIDTHMAKE, 20 * HEIGHTMAKE, 120 * WIDTHMAKE, 21 * HEIGHTMAKE)];
    self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20 * WIDTHMAKE];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.text = [NSString stringWithFormat:@"%ld/%ld", (long)self.count, (unsigned long)self.imgArr.count];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTHS - 70 * WIDTHMAKE, 20 * HEIGHTMAKE, 60 * WIDTHMAKE, 21 * HEIGHTMAKE);
    [button setTitle:@"..." forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.returnBtn.frame = CGRectMake(5 * WIDTHMAKE, 0, 50, 30);
    [self.returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.returnBtn addTarget:self action:@selector(clickToBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnBtn];
}

- (void)creatScroll{
    self.backGroundView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backGroundView.contentSize = CGSizeMake(WIDTHS * 5, HEIGHTS);
    self.backGroundView.pagingEnabled = YES;
    self.backGroundView.backgroundColor = [UIColor blackColor];
    self.backGroundView.delegate = self;
    NSInteger i = 0;
    for (UIImage *image in self.imgArr) {
        NSString *hgt = self.imgSizeArr[i];
        UIScrollView *imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(WIDTHS * i, 0, WIDTHS, HEIGHTS)];
        imgScroll.delegate = self;
        imgScroll.contentSize = CGSizeMake(WIDTHS, HEIGHTS);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        imageV.frame = CGRectMake(0, (HEIGHTS - [hgt floatValue]) / 2, WIDTHS, [hgt floatValue]);
        [view addSubview:imageV];
        [imgScroll addSubview:view];
        [self.backGroundView addSubview:imgScroll];
        imgScroll.maximumZoomScale = 2;
        imgScroll.minimumZoomScale = 1;
        i++;
    }
    self.backGroundView.contentOffset = CGPointMake(WIDTHS * self.count, 0);
    [self.view addSubview:self.backGroundView];
}

- (void)creatFliter{
    self.fliter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
    self.fliter.backgroundColor = [UIColor blackColor];
    self.fliter.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFliter)];
    [self.fliter addGestureRecognizer:tap];
    [self.view addSubview:self.fliter];
    self.listView = [[ListView alloc] initWithFrame:CGRectMake(0, self.fliter.frame.size.height, self.fliter.frame.size.width, 65 * HEIGHTMAKE)];
    [self.fliter addSubview:self.listView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView != self.backGroundView) {
        return scrollView.subviews.firstObject;
    }else{
        return nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.backGroundView) {
        if (scrollView.contentOffset.x >= WIDTHS) {
            UIScrollView * scroll = scrollView.subviews[(NSInteger)(scrollView.contentOffset.x / WIDTHS) - 1];
            scroll.zoomScale = 1;
        }
        self.label.text = [NSString stringWithFormat:@"%ld/%ld", (unsigned long)(scrollView.contentOffset.x / WIDTHS) + 1, (unsigned long)self.imgArr.count];
    }
}

- (void)clickFliter{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.fliter.alpha = 0;
        self.listView.frame = CGRectMake(0, self.fliter.frame.size.height, self.fliter.frame.size.width, 70 * HEIGHTMAKE);

    } completion:^(BOOL finished) {

    }];
    [UIView animateWithDuration:1 animations:^{
        self.fliter.alpha = 0;
        self.listView.frame = CGRectMake(0, self.fliter.frame.size.height, self.fliter.frame.size.width, 65 * HEIGHTMAKE);
    }];
}

- (void)clickList{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.fliter.alpha = 0.75;
        self.listView.frame = CGRectMake(0, self.fliter.frame.size.height - 65 * HEIGHTMAKE, self.fliter.frame.size.width, 70 * HEIGHTMAKE);
    } completion:^(BOOL finished) {

    }];
    [UIView animateWithDuration:1 animations:^{
        self.fliter.alpha = 0.75;
        self.listView.frame = CGRectMake(0, self.fliter.frame.size.height - 65 * HEIGHTMAKE, self.fliter.frame.size.width, 65 * HEIGHTMAKE);
    }];
}

- (void)clickToBack{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
