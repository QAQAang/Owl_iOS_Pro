//
//  MinePublishCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MinePublishCell.h"
#import "UIView+YPFrameExtension.h"
#import "GameModel.h"
#import <UIImageView+WebCache.h>

@interface MinePublishCell ()
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *gameLabel;
@property (nonatomic, strong)UILabel *spaceLabel;
@property (nonatomic, strong)UILabel *severLabel;
@property (nonatomic, strong)UILabel *createTimeLabel;
@end

@implementation MinePublishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setModel:(GameModel *)model
{
    _model = model;
    
    NSArray *imgs = [model.picturePath componentsSeparatedByString:@","];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=%@", imgs[0]]]];
    self.titleLabel.text = [NSString stringWithFormat:@"标 题：%@",model.title];
    self.gameLabel.text = [NSString stringWithFormat:@"游戏名：%@",model.game];
    self.spaceLabel.text = [NSString stringWithFormat:@"游戏区：%@",model.space];
    self.severLabel.text = [NSString stringWithFormat:@"游戏服：%@",model.server];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
//    NSDate 
    
    self.createTimeLabel.text = [NSString stringWithFormat:@"%@",model.createTime];
}

- (void)createUI
{
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 8 * HEIGHTMAKE, 77 * WIDTHMAKE, 77 * HEIGHTMAKE)];
    [self.contentView addSubview:icon];
    self.icon = icon;
    icon.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 11 * WIDTHMAKE, icon.y - 1 * HEIGHTMAKE, WIDTHS - 240 * WIDTHMAKE, 13 * HEIGHTMAKE)];
    titleLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    titleLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.backgroundColor = [UIColor orangeColor];
    
    UILabel *gameLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.x, CGRectGetMaxY(titleLabel.frame) + 9.5 * HEIGHTMAKE, titleLabel.width, titleLabel.height)];
    gameLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    gameLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:gameLabel];
    self.gameLabel = gameLabel;
    gameLabel.backgroundColor = [UIColor purpleColor];
    
    UILabel *spaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(gameLabel.x, CGRectGetMaxY(gameLabel.frame) + 9.5 * HEIGHTMAKE, gameLabel.width, gameLabel.height)];
    spaceLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    spaceLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:spaceLabel];
    self.spaceLabel = spaceLabel;
    spaceLabel.backgroundColor = [UIColor greenColor];
    
    UILabel *severLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaceLabel.x, CGRectGetMaxY(spaceLabel.frame) + 9.5 * HEIGHTMAKE, spaceLabel.width, spaceLabel.height)];
    severLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    severLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:severLabel];
    self.severLabel = severLabel;
    severLabel.backgroundColor = [UIColor blueColor];
    
    UILabel *createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHS - 135 * WIDTHMAKE, CGRectGetMaxY(gameLabel.frame), 125 * WIDTHMAKE, 13 * HEIGHTMAKE)];
    createTimeLabel.textAlignment = NSTextAlignmentRight;
    createTimeLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    createTimeLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:createTimeLabel];
    self.createTimeLabel = createTimeLabel;
    createTimeLabel.backgroundColor = [UIColor yellowColor];
}

@end
