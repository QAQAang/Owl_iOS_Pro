//
//  GoodsDetailCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GoodsDetailCell.h"

@interface GoodsDetailCell ()

@property (nonatomic, retain)UILabel *goodsName;

@property (nonatomic, retain)UILabel *binging;

@property (nonatomic, retain)UILabel *partProfession;

@property (nonatomic, retain)UILabel *partSex;

@property (nonatomic, retain)UILabel *partLevel;

@end

@implementation GoodsDetailCell

-  (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.goodsName = [[UILabel alloc] init];
    self.goodsName.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.goodsName.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.goodsName];
    self.binging = [[UILabel alloc] init];
    self.binging.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.binging.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.binging];
    self.partProfession = [[UILabel alloc] init];
    self.partProfession.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.partProfession.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.partProfession];
    self.partSex = [[UILabel alloc] init];
    self.partSex.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.partSex.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.partSex];
    self.partLevel = [[UILabel alloc] init];
    self.partLevel.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.partLevel.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.partLevel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.goodsName.frame = CGRectMake(10 * WIDTHMAKE, 10 * HEIGHTMAKE, 150 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.binging.frame = CGRectMake(10 * WIDTHMAKE, 32 * HEIGHTMAKE, 150 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.partProfession.frame = CGRectMake(200 * WIDTHMAKE, 32 * HEIGHTMAKE, 125 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.partLevel.frame = CGRectMake(10 * WIDTHMAKE, 54 * HEIGHTMAKE, 150 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.partSex.frame = CGRectMake(200 * WIDTHMAKE, 54 * HEIGHTMAKE, 125 * WIDTHMAKE, 14 * HEIGHTMAKE);
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
