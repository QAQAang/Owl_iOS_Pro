
//
//  MineViewCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/30.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MineViewCell.h"
#import "UIView+YPFrameExtension.h"

@implementation MineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = COLOR(60, 60, 60, 1.0);
        self.textLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26 * WIDTHMAKE, self.contentView.height)];
        icon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:icon];
        self.icon = icon;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    if ([self.textLabel.text  isEqual: @"我的发布"]) {
        self.imageView.backgroundColor = COLOR(231, 76, 45, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"我的关注"]) {
        self.imageView.backgroundColor = COLOR(82, 144, 205, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"帐户安全"]) {
        self.imageView.backgroundColor = COLOR(164, 92, 202, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"我的银行卡"]) {
        self.imageView.backgroundColor = COLOR(96, 100, 112, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"商家认证"]) {
        self.imageView.backgroundColor = COLOR(248, 156, 40, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"设置"]) {
        self.imageView.backgroundColor = COLOR(154, 175, 254, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"关于我们"]) {
        self.imageView.backgroundColor = COLOR(99, 199, 249, 1.0);
    }
    if ([self.textLabel.text  isEqual: @"检查更新"]) {
        self.imageView.backgroundColor = COLOR(8, 181, 212, 1.0);
    }
    
    //调整图片的位置和大小
    self.imageView.bounds = CGRectMake(0, 0, 30 * WIDTHMAKE, 28 * HEIGHTMAKE);
    self.imageView.x = 12 * WIDTHMAKE;
    self.imageView.layer.cornerRadius = 2;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    //调整label
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 12 * WIDTHMAKE;
}

@end
