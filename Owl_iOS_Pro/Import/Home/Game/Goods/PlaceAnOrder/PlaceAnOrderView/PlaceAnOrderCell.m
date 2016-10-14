//
//  PlaceAnOrderCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PlaceAnOrderCell.h"

@implementation PlaceAnOrderCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 12 * HEIGHTMAKE, 90 * WIDTHMAKE, 15)];
    self.label.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    self.label.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.label];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100 * WIDTHMAKE, 12 * HEIGHTMAKE, 200 * WIDTHMAKE, 15)];
    self.textField.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    [self.contentView addSubview:self.textField];
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
