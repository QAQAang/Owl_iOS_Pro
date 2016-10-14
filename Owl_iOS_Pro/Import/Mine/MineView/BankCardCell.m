//
//  BankCardCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "BankCardCell.h"
#import "UIView+YPFrameExtension.h"
#import "BankModel.h"

@interface BankCardCell ()
@property (nonatomic, strong)UIImageView *bg;
@property (nonatomic, strong)UIImageView *bankIcon;
@property (nonatomic, strong)UILabel *bankName;
@property (nonatomic, strong)UILabel *bankNumberLabel;
@property (nonatomic, strong)UIView *iconView;
@end


@implementation BankCardCell

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
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 17 * HEIGHTMAKE, WIDTHS - 20 * WIDTHMAKE, 108 * HEIGHTMAKE)];
    [self.contentView addSubview:bg];
    self.bg = bg;
    
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(15 * WIDTHMAKE, 13 * HEIGHTMAKE, 40 * WIDTHMAKE, 40 * WIDTHMAKE)];
    iconView.layer.cornerRadius = iconView.width / 2;
    iconView.backgroundColor = [UIColor whiteColor];
    [bg addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *bankIcon = [[UIImageView alloc] initWithFrame:CGRectMake((iconView.width - iconView.width * cos(M_PI_4)) / 2, (iconView.width - iconView.width * cos(M_PI_4)) / 2, iconView.width * cos(M_PI_4), iconView.width * cos(M_PI_4))];
    bankIcon.backgroundColor = [UIColor clearColor];
    [iconView addSubview:bankIcon];
    self.bankIcon = bankIcon;
    
    UILabel *bankName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 12 * WIDTHMAKE, 20 * HEIGHTMAKE, 250 * WIDTHMAKE, 20 * HEIGHTMAKE)];
    bankName.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    bankName.textColor = [UIColor whiteColor];
    [bg addSubview:bankName];
    self.bankName = bankName;
    
    UILabel *bankNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(bankName.x, CGRectGetMaxY(bankName.frame) + 37 * HEIGHTMAKE, bankName.width, bankName.height)];
    bankNumberLabel.font = [UIFont systemFontOfSize:16 * WIDTHMAKE];
    bankNumberLabel.textColor = [UIColor whiteColor];
    [bg addSubview:bankNumberLabel];
    self.bankNumberLabel = bankNumberLabel;
}

- (void)setBankModel:(BankModel *)bankModel
{
    _bankModel = bankModel;
    
    self.bg.image = [UIImage imageNamed:bankModel.bg];
    self.bankIcon.image = [UIImage imageNamed:bankModel.icon];
    self.bankName.text = bankModel.name;
    self.bankNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@",bankModel.backFourNum];
}

@end
