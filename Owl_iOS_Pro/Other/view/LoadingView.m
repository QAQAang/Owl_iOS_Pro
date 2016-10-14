//
//  LoadingView.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *label;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.image = [UIImage imageNamed:@"加载中"];
    [self addSubview:self.imageV];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.repeatCount = HUGE_VALF;
    pathAnimation.duration = 1.5;
    [self.imageV.layer addAnimation:pathAnimation forKey:nil];
    self.label = [[UILabel alloc] init];
    self.label.text = @"努力加载中";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = COLOR(211, 211, 211, 1);
    self.label.font = [UIFont systemFontOfSize:13 * HEIGHTMAKE];
    [self addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(self.center.x - 8.25 * WIDTHMAKE - self.frame.origin.x, self.center.y - 110 * HEIGHTMAKE - 8.25, 16.5 * WIDTHMAKE, 16.5 * WIDTHMAKE);
    NSLog(@"%@", NSStringFromCGRect(self.imageV.frame));
    self.label.frame = CGRectMake(self.center.x - 50 * WIDTHMAKE - self.frame.origin.x, self.center.y - 90 * HEIGHTMAKE - 7 * HEIGHTMAKE, 100 * WIDTHMAKE, 14 *  HEIGHTMAKE);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
