//
//  SelectedBtn.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SelectedBtn.h"
#import "UIView+YPFrameExtension.h"

@implementation SelectedBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 2 * WIDTHMAKE;
}

//发布中选择的按钮
+ (SelectedBtn *)buttonWithAction:(SEL)action addTarget:(id)target
{
    SelectedBtn *button = [SelectedBtn buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:COLOR(60, 60, 60, 1.0) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    [button setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"实心圆"] forState:UIControlStateSelected];
    return button;
}

@end
