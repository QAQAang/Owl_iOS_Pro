//
//  PickGameCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PickGameCell.h"
#import <UIImageView+WebCache.h>
#import "Tools.h"
@interface PickGameCell ()

@property (nonatomic, retain) UILabel *label;

@property (nonatomic, retain) UIImageView *imageV;

@end

@implementation PickGameCell

- (void)setModel:(CompanyModel *)model{
    _model = model;
    self.label.text = model.name;

//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];

    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=E:\\thh\\picture\\games\\%@%@.png", model.name, [Tools returnKey]];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.contentView.backgroundColor = COLOR(242, 242, 242, 1);
    self.imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageV];
    self.label = [[UILabel alloc] init];
    self.label.textColor = COLOR(65, 64, 64, 1);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"测试";
    self.label.font = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    [self.contentView addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 100 * HEIGHTMAKE);
    self.label.frame = CGRectMake(0, 95 * HEIGHTMAKE, self.contentView.frame.size.width, 24 * HEIGHTMAKE);
}

@end
