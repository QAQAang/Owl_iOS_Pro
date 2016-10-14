//
//  GameTBCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GameTBCell.h"
#import <UIImageView+WebCache.h>
@interface GameTBCell ()

@property (nonatomic, retain) UIImageView *imageV;

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *detail;

@property (nonatomic, retain) UILabel *price;

@property (nonatomic, retain) UIButton *follow;

@end

@implementation GameTBCell

- (void)setModel:(GameModel *)model{
    _model = model;
    NSArray *imgs = [model.picturePath componentsSeparatedByString:@","];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=%@", imgs[0]]]];
    self.title.text = model.title;
    self.detail.text = [NSString stringWithFormat:@"%@\n%@\n%@出售", model.server, model.sellerType, model.type];
    self.price.text = [NSString stringWithFormat:@"¥ %@", model.price];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageV];
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:16 * HEIGHTMAKE];
    self.title.textColor = COLOR(40, 40, 40, 1);
    [self.contentView addSubview:self.title];
    self.detail = [[UILabel alloc] init];
    self.detail.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.detail.textColor = COLOR(101, 101, 101, 1);
    self.detail.numberOfLines = 3;
    [self.contentView addSubview:self.detail];
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    self.price.textColor = COLOR(255, 0, 0, 1);
    [self.contentView addSubview:self.price];
    self.follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.follow setTitle:@"关注" forState:UIControlStateNormal];
    [self.follow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.follow.backgroundColor = COLOR(255, 130, 115, 1);
    self.follow.titleLabel.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    self.follow.layer.cornerRadius = 5;
    [self.follow addTarget:self action:@selector(clickFollow) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.follow];
}

- (void)clickFollow{
    self.followBlock();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10 * WIDTHMAKE, 0, 100 * WIDTHMAKE, 88 * HEIGHTMAKE);
    self.title.frame = CGRectMake(120 * WIDTHMAKE, 3 * HEIGHTMAKE, 150 * WIDTHMAKE, 17 * HEIGHTMAKE);
    self.detail.frame = CGRectMake(120 * WIDTHMAKE, 21 * HEIGHTMAKE, 100 * WIDTHMAKE, 45 * HEIGHTMAKE);
    self.price.frame = CGRectMake(120 * WIDTHMAKE, 71 * HEIGHTMAKE, 100 * WIDTHMAKE, 16 * HEIGHTMAKE);
    self.follow.frame = CGRectMake(WIDTHS - 60 * WIDTHMAKE, 50 * HEIGHTMAKE, 45 * WIDTHMAKE, 33 * HEIGHTMAKE);
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
