//
//  ClickView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ClickView.h"

@interface ClickView ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *label;

@end

@implementation ClickView

- (void)setText:(NSString *)text{
    _text = text;
    self.label.text = text;
}

- (void)setNomalImage:(UIImage *)nomalImage{
    _nomalImage = nomalImage;
    self.imageV.image = nomalImage;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 5, 0, self.frame.size.width / 5 * 3, self.frame.size.height * 18 / 35)];
    [self addSubview:self.imageV];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 25 / 35, self.frame.size.width, self.frame.size.height * 10 / 35)];
    self.label.font = [UIFont systemFontOfSize:10 * self.frame.size.width / 30];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
}

#pragma mark - 点击高亮
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.click();
    if (!_classPick) {
        self.imageV.image = _highlightImage;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_classPick) {
        self.imageV.image = _nomalImage;
    }
}

#pragma mark - 改变图片方法
- (void)changeImage:(UIImage *)image{
    self.imageV.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
