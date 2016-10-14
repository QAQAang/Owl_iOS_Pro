//
//  NoOrderView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/16.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NoOrderView.h"
#import "UIView+YPFrameExtension.h"

@implementation NoOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"无订单"]];
    view.centerX = self.centerX;
    view.y = 76 * HEIGHTMAKE;
    [view sizeToFit];
    [self addSubview:view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame) + 16 * HEIGHTMAKE, 0, 0)];
    label1.text = @"您还没有相关的订 单";
    label1.textColor = COLOR(60, 60, 60, 1.0);
    label1.font = [UIFont systemFontOfSize:17 * WIDTHMAKE];
    [label1 sizeToFit];
    label1.centerX = self.centerX;
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame) + 5 * HEIGHTMAKE , 0, 0)];
    label2.text = @"去看看您喜欢的商品吧Y(^_^)Y";
    label2.textColor = COLOR(60, 60, 60, 1.0);
    label2.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    [label2 sizeToFit];
    label2.centerX = self.centerX;
    [self addSubview:label2];
}

@end
