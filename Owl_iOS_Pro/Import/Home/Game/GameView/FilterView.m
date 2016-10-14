//
//  FilterView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/8.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "FilterView.h"
#import "ClickView.h"
#import "SellWayView.h"
@interface FilterView ()

#pragma mark - 自定义TabBar第一栏
@property (nonatomic, retain)UIView *firstPage;

@property (nonatomic, retain)ClickView *numButton;

@property (nonatomic, retain)ClickView *equipmentButton;

@property (nonatomic, retain)ClickView *gameGoldButton;

#pragma mark - 第二栏
@property (nonatomic, retain)UIView *secondPage;

@property (nonatomic, retain)ClickView *volumeButton;

@property (nonatomic, retain)ClickView *priceButton;

@property (nonatomic, retain)ClickView *reputationButton;

@property (nonatomic, retain)SellWayView *testView;

@property (nonatomic, retain)UIView *equipmentDetail;

#pragma mark - 中介
@property (nonatomic, retain)ClickView *mediumView;

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
        [self clickViewMethod];
    }
    return self;
}

- (void)creatView{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 1 * HEIGHTMAKE)];
    line.backgroundColor = COLOR(227, 227, 227, 1);
    [self addSubview:line];
    self.firstPage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 49 * HEIGHTMAKE)];
    self.numButton = [[ClickView alloc] initWithFrame:CGRectMake(70 * WIDTHMAKE, 10 * HEIGHTMAKE, 30 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    self.numButton.nomalImage = [UIImage imageNamed:@"账号"];
    self.numButton.highlightImage = [UIImage imageNamed:@"账号-blue"];
    self.numButton.text = @"账号";
    [self.firstPage addSubview:self.numButton];
    self.equipmentButton = [[ClickView alloc] initWithFrame:CGRectMake(172.5 * WIDTHMAKE, 10 * HEIGHTMAKE, 30 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    self.equipmentButton.nomalImage = [UIImage imageNamed:@"装备"];
    self.equipmentButton.highlightImage = [UIImage imageNamed:@"装备-blue"];
    self.equipmentButton.text = @"装备";
    [self.firstPage addSubview:self.equipmentButton];
    self.gameGoldButton = [[ClickView alloc] initWithFrame:CGRectMake(275 * WIDTHMAKE, 10 * HEIGHTMAKE, 30 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    self.gameGoldButton.nomalImage = [UIImage imageNamed:@"游戏币交易"];
    self.gameGoldButton.highlightImage = [UIImage imageNamed:@"游戏币交易-blue"];
    self.gameGoldButton.text = @"游戏币";
    [self.firstPage addSubview:self.gameGoldButton];
    [self addSubview:self.firstPage];
    self.secondPage = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS, 0, WIDTHS, 49 * HEIGHTMAKE)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16.5 * HEIGHTMAKE, 9.5 * WIDTHMAKE, 16 * HEIGHTMAKE)];
    imageV.image = [UIImage imageNamed:@"滑动"];
    [self.secondPage addSubview:imageV];
    self.volumeButton = [[ClickView alloc] initWithFrame:CGRectMake(62  * WIDTHMAKE, 10 * HEIGHTMAKE, 30 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    self.volumeButton.classPick = YES;
    self.volumeButton.nomalImage = [UIImage imageNamed:@"成交量"];
    self.volumeButton.highlightImage = [UIImage imageNamed:@"成交量-blue"];
    self.volumeButton.text = @"成交量";
    [self.secondPage addSubview:self.volumeButton];
    self.priceButton = [[ClickView alloc] initWithFrame:CGRectMake(134 * WIDTHMAKE, 10 * HEIGHTMAKE, 30 * WIDTHMAKE, 35 * HEIGHTMAKE)];
    self.priceButton.classPick = YES;
    self.priceButton.nomalImage = [UIImage imageNamed:@"价格"];
    self.priceButton.highlightImage = [UIImage imageNamed:@"价格-blue"];
    self.priceButton.text = @"价格";
    [self.secondPage addSubview:self.priceButton];
    self.reputationButton = [[ClickView alloc] initWithFrame:CGRectMake(196 * WIDTHMAKE, 10, 30 * WIDTHMAKE, 35)];
    self.reputationButton.classPick = YES;
    self.reputationButton.nomalImage = [UIImage imageNamed:@"信誉"];
    self.reputationButton.highlightImage = [UIImage imageNamed:@"信誉-blue"];
    self.reputationButton.text = @"信誉";
    [self.secondPage addSubview:self.reputationButton];
    self.testView = [[SellWayView alloc] initWithFrame:CGRectMake(268 * WIDTHMAKE, 10 * HEIGHTMAKE, 100 * WIDTHMAKE, 49 * HEIGHTMAKE)];
    [self.secondPage addSubview:self.testView];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureMethod)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.secondPage addGestureRecognizer:swipeGesture];
    [self addSubview:self.secondPage];
}

- (void)swipeGestureMethod{
    [UIView animateWithDuration:0.5 animations:^{
        self.firstPage.frame = CGRectMake(0, 0, WIDTHS,49 * HEIGHTMAKE);
        self.secondPage.frame = CGRectMake(WIDTHS, 0, WIDTHS, 49 * HEIGHTMAKE);
    }];
}

- (void)firstRemove:(FilterView *)view{
    [UIView animateWithDuration:0.5 animations:^{
        view.firstPage.frame = CGRectMake(- WIDTHS, 0, WIDTHS,49 * HEIGHTMAKE);
        view.secondPage.frame = CGRectMake(0, 0, WIDTHS, 49 * HEIGHTMAKE);
    }];
}

- (void)clickViewMethod{
#pragma mark - 第一栏点击时间实现位置
    __weak FilterView *weakSelf = self;
    self.numButton.click = ^{
        [weakSelf firstRemove:weakSelf];
    };
#warning !!! 弹出菜单还没实现
    self.equipmentButton.click = ^{
        [weakSelf.delegate equipmentMethod];
    };
    
    self.gameGoldButton.click = ^{
        [weakSelf firstRemove:weakSelf];
        
    };
    
#pragma mark - 第二栏点击事件实现位置
    self.volumeButton.click = ^{
        if (self.volumeButton != self.mediumView) {
            if (self.mediumView != nil) {
                [weakSelf.mediumView changeImage:weakSelf.mediumView.nomalImage];
            }
            [weakSelf.volumeButton changeImage:weakSelf.volumeButton.highlightImage];
            weakSelf.mediumView = weakSelf.volumeButton;
        }
    };
    
    self.priceButton.click = ^{
        if (self.priceButton != self.mediumView) {
            if (self.mediumView != nil) {
                [weakSelf.mediumView changeImage:weakSelf.mediumView.nomalImage];
            }
            [weakSelf.priceButton changeImage:weakSelf.priceButton.highlightImage];
            weakSelf.mediumView = weakSelf.priceButton;
        }
    };
    
    self.reputationButton.click = ^{
        if (self.reputationButton != self.mediumView) {
            if (self.mediumView != nil) {
                [weakSelf.mediumView changeImage:weakSelf.mediumView.nomalImage];
            }
            [weakSelf.reputationButton changeImage:weakSelf.reputationButton.highlightImage];
            weakSelf.mediumView = weakSelf.reputationButton;
        }
    };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
