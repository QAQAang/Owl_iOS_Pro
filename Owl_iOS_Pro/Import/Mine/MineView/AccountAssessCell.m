//
//  AccountAssessCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/21.
//  Copyright © 2016年 Aang. All rights reserved.
//  展示评价界面

#import "AccountAssessCell.h"
#import "UIView+YPFrameExtension.h"

@implementation AccountAssessCell

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
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 16 * HEIGHTMAKE, 38 * WIDTHMAKE, 38 * WIDTHMAKE)];
    [self.contentView addSubview:icon];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 12 * WIDTHMAKE, 20 * HEIGHTMAKE, 190 * WIDTHMAKE, 12 * HEIGHTMAKE)];
    nameLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    nameLabel.textColor = COLOR(101, 101, 101, 1.0);
    [self.contentView addSubview:nameLabel];
    
    UIView *starView =[[UIView alloc] initWithFrame:CGRectMake(nameLabel.x, CGRectGetMaxY(nameLabel.frame) + 8 * HEIGHTMAKE, nameLabel.width, nameLabel.height)];
    [self.contentView addSubview:starView];
    
    UIView *assessView = [[UIView alloc] initWithFrame:CGRectMake(starView.x, CGRectGetMaxY(starView.frame) + 8 * HEIGHTMAKE, WIDTHS - starView.x - 10 * WIDTHMAKE, starView.height)];
    [self.contentView addSubview:assessView];
    
    UIView *orderIDView = [[UIView alloc] initWithFrame:CGRectMake(assessView.x, CGRectGetMaxY(assessView.frame) + 8 * HEIGHTMAKE, assessView.width, assessView.height)];
    [self.contentView addSubview:orderIDView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHS - 90 * WIDTHMAKE, nameLabel.y, 80 * WIDTHMAKE, nameLabel.height)];
    timeLabel.font = [UIFont systemFontOfSize:9 * WIDTHMAKE];
    timeLabel.textColor = COLOR(209, 208, 208, 1.0);
    [self.contentView addSubview:timeLabel];
}
@end
