//
//  CreditLevelCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "CreditLevelCell.h"
#import "StarView.h"
@interface CreditLevelCell ()

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)StarView *starView;

@end

@implementation CreditLevelCell

- (void)setStarCount:(NSInteger)starCount{
    _starCount = starCount;
    self.starView.starCount = starCount;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"信用等级";
    self.titleLabel.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    [self.contentView addSubview:self.titleLabel];
    self.starView = [[StarView alloc] init];
    [self.contentView addSubview:self.starView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10 * WIDTHMAKE, 12 * HEIGHTMAKE, 56 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.starView.frame = CGRectMake(WIDTHS - 120 * WIDTHMAKE, 13.5 * HEIGHTMAKE, 21 * WIDTHMAKE, 21 * HEIGHTMAKE);
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
