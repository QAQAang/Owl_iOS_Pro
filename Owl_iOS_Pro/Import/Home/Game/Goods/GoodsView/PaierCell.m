//
//  PaierCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PaierCell.h"

@implementation PaierCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatText];
    }
    return self;
}

- (void)creatText{
    self.goodsDetail = [[UILabel alloc] init];
    self.goodsDetail.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.goodsDetail.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.goodsDetail];
    self.gameServer = [[UILabel alloc] init];
    self.gameServer.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.gameServer.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.gameServer];
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.leftLabel.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.leftLabel];
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.rightLabel.textColor = COLOR(40, 40, 40, 1);
    [self.contentView addSubview:self.rightLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.goodsDetail.frame = CGRectMake(10 * WIDTHMAKE, 14 * HEIGHTMAKE, 200 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.gameServer.frame = CGRectMake(10 * WIDTHMAKE, 58 * HEIGHTMAKE, 200 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.leftLabel.frame = CGRectMake(10 * WIDTHMAKE, 90 * HEIGHTMAKE, 150 * WIDTHMAKE, 31 * HEIGHTMAKE);
    self.rightLabel.frame = CGRectMake(242 * WIDTHMAKE, 90 * HEIGHTMAKE, 150 * WIDTHMAKE, 31 * HEIGHTMAKE);
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
