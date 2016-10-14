//
//  GoldTBCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/10/6.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GoldTBCell.h"

@interface GoldTBCell ()

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *detail;

@property (nonatomic, retain) UILabel *price;

@property (nonatomic, retain) UIButton *follow;

@end

@implementation GoldTBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GameModel *)model{
    _model = model;
    self.title.text = model.name;
    self.detail.text = [NSString stringWithFormat:@"%@\n%@/%@", model.game, model.space, model.server];
    self.price.text = [NSString stringWithFormat:@"¥ %@", model.price];
}

- (void)creatView{
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:16 * HEIGHTMAKE];
    self.title.textColor = COLOR(40, 40, 40, 1);
    [self.contentView addSubview:self.title];
    self.detail = [[UILabel alloc] init];
    self.detail.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    self.detail.textColor = COLOR(101, 101, 101, 1);
    self.detail.numberOfLines = 2;
    [self.contentView addSubview:self.detail];
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    self.price.textColor = COLOR(255, 0, 0, 1);
    [self.contentView addSubview:self.price];
    self.follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.follow setTitle:@"关注" forState:UIControlStateNormal];
    [self.follow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.follow.backgroundColor = COLOR(255, 130, 115, 1);
    self.follow.titleLabel.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    self.follow.layer.cornerRadius = 5;
    [self.follow addTarget:self action:@selector(clickFollow) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.follow];
}

- (void)clickFollow{
    self.followBlock();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.title.frame = CGRectMake(10 * WIDTHMAKE, 6 * HEIGHTMAKE, 355 * WIDTHMAKE, 17 * HEIGHTMAKE);
    self.detail.frame = CGRectMake(10 * WIDTHMAKE, 33 * HEIGHTMAKE, 200 * WIDTHMAKE,29 * HEIGHTMAKE);
    self.price.frame = CGRectMake(10 * WIDTHMAKE, 70 * HEIGHTMAKE, 100 * WIDTHMAKE, 16 * HEIGHTMAKE);
    self.follow.frame = CGRectMake(WIDTHS - 60 * WIDTHMAKE, 50 * HEIGHTMAKE, 45 * WIDTHMAKE, 33 * HEIGHTMAKE);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
