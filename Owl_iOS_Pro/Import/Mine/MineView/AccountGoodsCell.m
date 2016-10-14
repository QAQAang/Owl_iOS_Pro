//
//  AccountGoodsCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/21.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountGoodsCell.h"
#import "UIView+YPFrameExtension.h"


@interface AccountGoodsCell ()
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *gameLabel;
@property (nonatomic, strong)UILabel *goodsLabel;
@property (nonatomic, strong)UILabel *saleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *dealLabel;
@end

@implementation AccountGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 8 * HEIGHTMAKE, 77 * WIDTHMAKE, 77 * HEIGHTMAKE)];
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    UILabel *gameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 11 * WIDTHMAKE, icon.y, WIDTHS - 170 * WIDTHMAKE, 12 * HEIGHTMAKE)];
    gameLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    gameLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:gameLabel];
    self.gameLabel = gameLabel;
    
    UILabel *goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(gameLabel.x, CGRectGetMaxY(gameLabel.frame) + 9.5 * HEIGHTMAKE, gameLabel.width, gameLabel.height)];
    goodsLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    goodsLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:goodsLabel];
    self.goodsLabel = goodsLabel;
    
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodsLabel.x, CGRectGetMaxY(goodsLabel.frame) + 9.5 * HEIGHTMAKE, goodsLabel.width, goodsLabel.height)];
    saleLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    saleLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:saleLabel];
    self.saleLabel = saleLabel;
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(saleLabel.x, CGRectGetMaxY(saleLabel.frame) + 9.5 * HEIGHTMAKE, saleLabel.width, saleLabel.height)];
    timeLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    timeLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *dealLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHS - 55 * WIDTHMAKE, self.contentView.height - 36 * HEIGHTMAKE, 45 * WIDTHMAKE, 28 * HEIGHTMAKE)];
    dealLabel.font = [UIFont systemFontOfSize:9 * WIDTHMAKE];
    dealLabel.textColor = [UIColor whiteColor];
    dealLabel.layer.cornerRadius = 3 * WIDTHMAKE;
    dealLabel.backgroundColor = COLOR(231, 110, 36, 1.0);
    [self.contentView addSubview:dealLabel];
    self.dealLabel = dealLabel;
}

@end
