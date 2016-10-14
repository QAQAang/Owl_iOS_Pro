//
//  SelectTime.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SelectTime.h"
#import "UIView+YPFrameExtension.h"


@implementation SelectTime

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3 * WIDTHMAKE;
        self.layer.borderColor = COLOR(170, 170, 170, 1.0).CGColor;
        self.layer.borderWidth = 1;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.width - 37 * WIDTHMAKE, 0, 1, 36 * HEIGHTMAKE)];
    line.backgroundColor = COLOR(170, 170, 170, 1.0);
    [self addSubview:line];
    
    UIButton *pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pullBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    [pullBtn setImage:[UIImage imageNamed:@"上拉"] forState:UIControlStateSelected];
    pullBtn.frame = CGRectMake(CGRectGetMaxX(line.frame), 0, 36 * WIDTHMAKE, 36 * HEIGHTMAKE);
    [pullBtn addTarget:self action:@selector(pullBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pullBtn];
    self.pullBtn = pullBtn;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 72 * WIDTHMAKE, 0, 35 * WIDTHMAKE, 36 * HEIGHTMAKE)];
    label.text = @"/小时";
    label.textColor = COLOR(60, 60, 60, 1.0);
    label.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * WIDTHMAKE, 0, self.width - 72 * WIDTHMAKE, 36 * HEIGHTMAKE)];
    hourLabel.textColor = COLOR(60, 60, 60, 1.0);
    hourLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    hourLabel.textAlignment = NSTextAlignmentCenter;
    hourLabel.text = @"8";
    [self addSubview:hourLabel];
    self.hourLabel = hourLabel;
}


#pragma mark - 下拉
- (void)pullBtnClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    if (btn.isSelected) {
        self.noteVcBlock(btn.isSelected);
        self.datePicker();
    }
}

@end
