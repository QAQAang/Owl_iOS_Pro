//
//  SubscribeCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/5.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SubscribeCell.h"
#import "UIView+YPFrameExtension.h"

@interface SubscribeCell ()
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *detalLabel;
@property (nonatomic, strong)UILabel *gameZoneLabel;
@property (nonatomic, strong)UILabel *salerLabel;
@property (nonatomic, strong)UILabel *saleMode;
@property (nonatomic, strong)UIButton *selectBtn;
@end

@implementation SubscribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    //游戏图片
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 10 * HEIGHTMAKE, 68 * HEIGHTMAKE, 68 * HEIGHTMAKE)];
    [self.contentView addSubview:icon];
    _icon = icon;
    //商品介绍
    UILabel *detalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 9 * WIDTHMAKE, 5 * HEIGHTMAKE, 200 * WIDTHMAKE, 16 * HEIGHTMAKE)];
    detalLabel.font = [UIFont systemFontOfSize:16 * HEIGHTMAKE];
    detalLabel.textColor = COLOR(40, 40, 40, 1.0);
    [self.contentView addSubview:detalLabel];
    _detalLabel = detalLabel;
    //游戏区
    UILabel *gameZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(detalLabel.x, CGRectGetMaxY(detalLabel.frame) + 9 * HEIGHTMAKE, detalLabel.width, 12 * HEIGHTMAKE)];
    gameZoneLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    gameZoneLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:gameZoneLabel];
    _gameZoneLabel = gameZoneLabel;
    //商家性质
    UILabel *salerLabel = [[UILabel alloc] initWithFrame:CGRectMake(gameZoneLabel.x, CGRectGetMaxY(gameZoneLabel.frame) + 9 * HEIGHTMAKE, gameZoneLabel.width, 12 * HEIGHTMAKE)];
    salerLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    salerLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:salerLabel];
    _salerLabel = salerLabel;
    //出售方式
    UILabel *saleMode = [[UILabel alloc] initWithFrame:CGRectMake(salerLabel.x, CGRectGetMaxY(salerLabel.frame) + 9 * HEIGHTMAKE, salerLabel.width, 12 * HEIGHTMAKE)];
    saleMode.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    saleMode.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:saleMode];
    _saleMode = saleMode;
    //选中按钮
    
}

@end
