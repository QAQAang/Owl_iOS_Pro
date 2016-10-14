//
//  OutLineView.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "OutLineView.h"

@interface OutLineView ()

@property (nonatomic, retain)UIImageView *imageV;

@end

@implementation OutLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}
//61 66 69 170 170 170  14
- (void)creatView{
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x - 34.25 * WIDTHMAKE, self.center.y - 150 * HEIGHTMAKE - 27.5, 68.5 * WIDTHMAKE, 55 * WIDTHMAKE)];
    self.imageV.image = [UIImage imageNamed:@"加载中"];
    [self addSubview:self.imageV];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 50 * WIDTHMAKE, self.center.y - 110 * HEIGHTMAKE - 10 * HEIGHTMAKE, 100 * WIDTHMAKE, 20 * HEIGHTMAKE)];
    label.text = @"网络异常";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR(61, 66, 69, 1);
    label.font = [UIFont systemFontOfSize:18 * HEIGHTMAKE];
    [self addSubview:label];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 75 * WIDTHMAKE, self.center.y - 90 * HEIGHTMAKE - 7.5 * HEIGHTMAKE, 150 * WIDTHMAKE, 15 * HEIGHTMAKE)];
    label2.text = @"请确认您的网络状态";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = COLOR(170, 170, 170, 1);
    label2.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    [self addSubview:label];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.center.x - 32.5 * WIDTHMAKE, self.center.y - 75 * HEIGHTMAKE, 65 * WIDTHMAKE, 16 * HEIGHTMAKE);
    button.layer.borderColor = COLOR(71, 71, 71, 1).CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitle:@"重新加载" forState:UIControlStateHighlighted];
    [button setTitleColor:COLOR(71, 71, 71, 1) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(outfiger:) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:button];
}

- (void)click:(UIButton *)sender{
    self.reloadData();
    sender.layer.borderWidth = 0;
    sender.backgroundColor = [UIColor lightGrayColor];
}

- (void)outfiger:(UIButton *)sender{
    sender.layer.borderWidth = 1;
    sender.backgroundColor = [UIColor clearColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
