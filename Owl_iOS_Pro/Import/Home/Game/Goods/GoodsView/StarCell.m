//
//  StarCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/20.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "StarCell.h"
#import "StarView.h"
@interface StarCell ()

@property (nonatomic, retain)UILabel *label;

@property (nonatomic, retain)StarView *starView;

@end

@implementation StarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.label = [[UILabel alloc] init];
    self.label.textColor = COLOR(60, 60, 60, 1);
    self.label.text = @"信用等级";
    self.label.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    [self.contentView addSubview:self.label];
    self.starView = [[StarView alloc] init];
    [self.contentView addSubview:self.starView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = CGRectMake(10 * WIDTHMAKE, 15 * HEIGHTMAKE, 100 * WIDTHMAKE, 15 * HEIGHTMAKE);
    self.starView.frame = CGRectMake(WIDTHS - 120 * WIDTHMAKE, 7 * HEIGHTMAKE, 120 * WIDTHMAKE, 20 * HEIGHTMAKE);
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
