//
//  AuctionCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionCell.h"

@interface AuctionCell ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *timeLabel;

@property (nonatomic, retain)UILabel *goodsDetail;

@property (nonatomic, retain)UILabel *priceLabel;

@property (nonatomic, retain)UILabel *depositLabel;

@property (nonatomic, retain)UIButton *button;

@property (nonatomic, retain)UIView *line;

@end

@implementation AuctionCell

- (void)setColor:(UIColor *)color{
    _color = color;
    [self.button setTitleColor:color forState:UIControlStateNormal];
}

- (void)setModel:(AuctionListModel *)model{
    _model = model;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor= COLOR(157, 154, 154, 1);
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self.contentView addSubview:self.timeLabel];
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = COLOR(200, 199, 204, 1);
    [self.contentView addSubview:self.line];
    self.imageV = [[UIImageView alloc] init];
    self.imageV.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.imageV];
    self.goodsDetail = [[UILabel alloc] init];
    self.goodsDetail.textColor = COLOR(60, 60, 60, 1);
    self.goodsDetail.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    [self.contentView addSubview:self.goodsDetail];
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = COLOR(255, 0, 0, 1);
    self.priceLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self.contentView addSubview:self.priceLabel];
    self.depositLabel = [[UILabel alloc] init];
    self.depositLabel.textColor = COLOR(162, 162, 162, 1);
    self.depositLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self.contentView addSubview:self.depositLabel];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.layer.borderColor = COLOR(192, 192, 194, 1).CGColor;
    self.button.layer.borderWidth = 1 * WIDTHMAKE;
    self.button.layer.cornerRadius = 2 * WIDTHMAKE;
    [self.button addTarget:self action:@selector(buttonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(0, 0, WIDTHS, 28 * HEIGHTMAKE);
    self.line.frame = CGRectMake(0, 28 * HEIGHTMAKE, WIDTHS, 1 * HEIGHTMAKE);
    self.imageV.frame = CGRectMake(10 * WIDTHMAKE, 10 * HEIGHTMAKE, 77 * WIDTHMAKE, 77 * HEIGHTMAKE);
    self.goodsDetail.frame = CGRectMake(93 * WIDTHMAKE, 15 * HEIGHTMAKE, 150 * WIDTHMAKE, 16 * HEIGHTMAKE);
    self.priceLabel.frame = CGRectMake(93 * WIDTHMAKE, 46 * HEIGHTMAKE, 150 * WIDTHMAKE, 13 * HEIGHTMAKE);
    self.depositLabel.frame = CGRectMake(93 * WIDTHMAKE, 69 * HEIGHTMAKE, 150 * WIDTHMAKE, 13 * HEIGHTMAKE);
    self.button.frame = CGRectMake(WIDTHS - 85 * WIDTHMAKE, 96 * HEIGHTMAKE, 75 * WIDTHMAKE, 27 * HEIGHTMAKE);
}

- (void)buttonMethod{
    self.clickButton();
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
