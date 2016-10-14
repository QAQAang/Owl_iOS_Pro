//
//  SellWayView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SellWayView.h"

@interface SellWayView ()

@property (nonatomic, retain)UIImageView *first;

@property (nonatomic, retain)UIImageView *second;

@property (nonatomic, assign)BOOL pick;

@property (nonatomic, assign)CGSize imageSize;

@property (nonatomic, retain) UILabel *label;

@property (nonatomic, retain) UILabel *label2;

@end

@implementation SellWayView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageSize = CGSizeMake(self.frame.size.width * 2 / 3, self.frame.size.height * 2 / 3);
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.first = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageSize.width / 10 + self.imageSize.width / 4, 0, self.imageSize.width / 5 * 2, self.imageSize.height * 0.8)];
    self.first.image = [UIImage imageNamed:@"竞拍-blue"];
    [self addSubview:self.first];
    self.second = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageSize.width / 2 + self.imageSize.width / 4, self.imageSize.height / 2, self.imageSize.width / 4, self.imageSize.height / 2)];
    self.second.image = [UIImage imageNamed:@"定价"];
    [self addSubview:self.second];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.imageSize.width / 4, self.imageSize.width / 2)];
    self.label.text = @"竞\n拍";
    self.label.numberOfLines = 2;
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:self.imageSize.width / 6];
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.imageSize.width + self.imageSize.width / 4, 0, self.imageSize.width / 4, self.imageSize.width / 2)];
    self.label2.text = @"定\n价";
    self.label2.numberOfLines = 2;
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.backgroundColor = [UIColor whiteColor];
    self.label2.font = [UIFont systemFontOfSize:self.imageSize.width / 6];
    self.label2.layer.transform = CATransform3DMakeRotation(- M_PI / 2, 0, 1, 0);
    [self addSubview:self.label2];
    [self addSubview:self.label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_pick) {
        self.first.image = [UIImage imageNamed:@"竞拍"];
        self.second.image = [UIImage imageNamed:@"定价-blue"];
        [UIView animateWithDuration:0.5 animations:^{
            self.first.frame = CGRectMake(self.imageSize.width / 2 , self.imageSize.height / 2, self.imageSize.width / 4, self.imageSize.height / 2);
            
            self.second.frame = CGRectMake(self.imageSize.width / 2 + self.imageSize.width / 4, 0, self.imageSize.width / 5 * 2, self.imageSize.height * 0.8);
            self.label.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 1, 0);
            self.label2.layer.transform = CATransform3DMakeRotation(- M_PI / 2, 0, 0, 0);
        }];
        self.pick = 1;
    }else{
        self.first.image = [UIImage imageNamed:@"竞拍-blue"];
        self.second.image = [UIImage imageNamed:@"定价"];
        [UIView animateWithDuration:0.5 animations:^{
            self.first.frame = CGRectMake(self.imageSize.width / 10 + self.imageSize.width / 4, 0, self.imageSize.width / 5 * 2, self.imageSize.height * 0.8);
            self.second.frame = CGRectMake(self.imageSize.width / 2 + self.imageSize.width / 4, self.imageSize.height / 2, self.imageSize.width / 4, self.imageSize.height / 2);
            self.label.layer.transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 0);
            self.label2.layer.transform = CATransform3DMakeRotation(- M_PI / 2, 0, 1, 0);
        }];
        self.pick = 0;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
