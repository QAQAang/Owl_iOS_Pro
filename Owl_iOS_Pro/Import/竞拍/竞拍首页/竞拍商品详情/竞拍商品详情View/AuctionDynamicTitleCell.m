//
//  AuctionDynamicTitleCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionDynamicTitleCell.h"

@interface AuctionDynamicTitleCell ()

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UIView *line;

@property (nonatomic, retain)UILabel *dynamicCount;

@end

@implementation AuctionDynamicTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = COLOR(60, 60, 60, 1);
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.titleLabel.text = @"竞拍动态";
    [self.contentView addSubview:self.titleLabel];
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = COLOR(164, 164, 164, 1);
    [self.contentView addSubview:self.line];
    self.dynamicCount = [[UILabel alloc] init];
    self.dynamicCount.textColor = COLOR(164, 164, 164, 1);
    [self.contentView addSubview:self.dynamicCount];
    self.arrow = [[UIImageView alloc] init];
    self.arrow.image = [UIImage imageNamed:@"pull"];
    self.arrow.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.arrow];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10 * WIDTHMAKE, 16 * HEIGHTMAKE, 60 * WIDTHMAKE, 16 * HEIGHTMAKE);
    self.line.frame = CGRectMake(90.5 * WIDTHMAKE, 12 * HEIGHTMAKE, 1 * WIDTHMAKE, 24 * HEIGHTMAKE);
    self.dynamicCount.frame = CGRectMake(115 * WIDTHMAKE, 16 * HEIGHTMAKE, 50 * WIDTHMAKE, 16 * HEIGHTMAKE);
    self.arrow.frame = CGRectMake(WIDTHS - 30 * WIDTHMAKE, 19.75 * HEIGHTMAKE, 16 * WIDTHMAKE, 8.5 * HEIGHTMAKE);
}

- (void)animationForCell:(BOOL)isOn{
    if (!isOn) {
        CABasicAnimation *ani = [CABasicAnimation animation];
        ani.keyPath = @"transform.rotation";
        ani.toValue = @(M_PI);
        ani.duration = 0.3;
        ani.fillMode = kCAFillModeForwards;
        ani.removedOnCompletion = NO;
        [self.arrow.layer addAnimation:ani forKey:nil];
    }else{
        CABasicAnimation *ani = [CABasicAnimation animation];
        ani.keyPath = @"transform.rotation";
        ani.toValue = @(0);
        ani.duration = 0.3;
        ani.fillMode = kCAFillModeForwards;
        ani.removedOnCompletion = NO;
        [self.arrow.layer addAnimation:ani forKey:nil];
    }
    
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
