//
//  SelectEquipment.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SelectEquipment.h"
#import "UIView+YPFrameExtension.h"

@implementation SelectEquipment

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
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * WIDTHMAKE, 0, self.width - 41 * WIDTHMAKE, 36 * HEIGHTMAKE)];
    hourLabel.textColor = COLOR(60, 60, 60, 1.0);
    hourLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    hourLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:hourLabel];
    self.equipLabel = hourLabel;
}

#pragma mark - 下拉
- (void)pullBtnClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    if (btn.isSelected) {
        self.noteVcBlock(btn.isSelected);
        self.equipmentPicker();
    }
}

@end
