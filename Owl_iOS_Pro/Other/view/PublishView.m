//
//  publishView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishView.h"
#import "PublishBtn.h"
#import "UIView+YPFrameExtension.h"

@interface PublishView ()
@property (nonatomic, weak) UITapGestureRecognizer *tap;
@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)NSMutableArray *buttons;
@property (nonatomic, strong)PublishBtn *button;
@end

@implementation PublishView
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        
        [self createButton];
    }
    return self;
}

- (void)createButton
{
    NSArray *imagesOrTitles = @[@"游戏帐号", @"游戏币", @"游戏装备"];
    
    for (int i = 0; i < imagesOrTitles.count; i++) {
        PublishBtn *button = [PublishBtn buttonWithType:UIButtonTypeCustom];
        [button setTitle:imagesOrTitles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesOrTitles[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.width = button.currentImage.size.width;
        button.height = button.width + 40 * HEIGHTMAKE;
        NSInteger margin = (WIDTHS - 3 * button.width) / 4;
        button.centerX = self.centerX;
        button.y = HEIGHTS;
        
        [UIView animateWithDuration:0.5 delay:0.3 / imagesOrTitles.count * i usingSpringWithDamping:0.75 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseOut animations:^{
            button.y = HEIGHTS - button.height - 202 * HEIGHTMAKE;
            button.x = i * (margin + button.width) + margin;
        } completion:^(BOOL finished) {
            
        }];
        self.button = button;
        [self.buttons addObject:button];
        [self addSubview:button];
    }
}

- (void)createView
{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    bg.alpha = 0.98;
    bg.image = [UIImage imageNamed:@"bg"];
    [self addSubview:bg];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 49 * HEIGHTMAKE, WIDTHS, 49 * HEIGHTMAKE)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bg addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    closeBtn.center = CGPointMake(WIDTHS / 2, bottomView.frame.size.height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        closeBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
    closeBtn.userInteractionEnabled = NO;
    [bottomView addSubview:closeBtn];
    self.closeBtn = closeBtn;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self addGestureRecognizer:tap];
    self.tap = tap;
}


- (void)close
{
    //退出动画
    for (int i = 0; i < self.buttons.count; i++) {
        _button = self.buttons[i];
        [UIView animateWithDuration:0.5 delay:0.3 / self.buttons.count * i usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _button.centerX = self.centerX;
            _button.y = HEIGHTS;
            self.closeBtn.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 animations:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"closePublish" object:nil userInfo:nil];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self removeGestureRecognizer:self.tap];
            }];
        }];
    }
}


#pragma mark - 点击发布种类
- (void)btnClick:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        NSLog(@"发布商品请先登录");
        [self close];
        return;
    }
    
    [self close];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSUInteger index = [weakSelf.buttons indexOfObject:btn];
        switch (index) {
            case 0:
                // 发布游戏帐号
                weakSelf.switchBlock(index, weakSelf);
                break;
            case 1:
                //发布游戏币
                weakSelf.switchBlock(index, weakSelf);
                break;
            case 2:
                //发布游戏装备
                weakSelf.switchBlock(index, weakSelf);
            default:
                break;
        }
    });
}

@end
