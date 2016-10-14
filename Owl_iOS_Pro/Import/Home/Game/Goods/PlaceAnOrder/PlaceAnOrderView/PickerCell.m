
//
//  PickerCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSwich];
    }
    return self;
}

- (void)creatSwich{
    UISwitch *swc = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTHS - 60 * WIDTHMAKE, 3 * HEIGHTMAKE, 53 * WIDTHMAKE, 29 * HEIGHTMAKE)];
    [swc addTarget:self action:@selector(swichMethod:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:swc];
}

- (void)swichMethod:(UISwitch *)swc{
    self.swichBlock(swc.on);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
