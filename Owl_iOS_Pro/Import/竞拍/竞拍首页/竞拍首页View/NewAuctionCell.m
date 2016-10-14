//
//  NewAuctionCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NewAuctionCell.h"
#import "StarView.h"
@interface NewAuctionCell ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *goodsName;

@property (nonatomic, retain)UILabel *goodsPrace;

@property (nonatomic, retain)UILabel *sellerClass;

@property (nonatomic, retain)StarView *starView;

@end

@implementation NewAuctionCell

#warning set方法赋值

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.imageV];
    self.goodsName = [[UILabel alloc] init];
    self.goodsName.textColor = COLOR(60, 60, 60, 1);
    self.goodsName.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self.contentView addSubview:self.goodsName];
    self.goodsPrace = [[UILabel alloc] init];
    [self.contentView addSubview:self.goodsPrace];
    self.sellerClass = [[UILabel alloc] init];
    self.sellerClass.textColor = COLOR(60, 60, 60, 1);
    self.sellerClass.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self.contentView addSubview:self.sellerClass];
    self.starView = [[StarView alloc] init];
    [self.contentView addSubview:self.starView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10 * WIDTHMAKE, 2.5 * HEIGHTMAKE, 110 * WIDTHMAKE, 105.5 * HEIGHTMAKE);
    self.goodsName.frame = CGRectMake(131 * WIDTHMAKE, 2.5 * HEIGHTMAKE, 200 * WIDTHMAKE, 12 * HEIGHTMAKE);
    self.goodsPrace.frame = CGRectMake(131 * WIDTHMAKE, 26.5 * HEIGHTMAKE, 200 * WIDTHMAKE, 12 * HEIGHTMAKE);
    self.sellerClass.frame = CGRectMake(131 * WIDTHMAKE, 54.5 * HEIGHTMAKE, 200 * WIDTHMAKE, 12 * HEIGHTMAKE);
    self.starView.frame = CGRectMake(131 * WIDTHMAKE, 82.5 * HEIGHTMAKE, 120 * WIDTHMAKE, 20 * HEIGHTMAKE);
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
