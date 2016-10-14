//
//  CompanyItem.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "CompanyItem.h"
#import <UIImageView+WebCache.h>
#import "Tools.h"

@interface CompanyItem ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *label;

@end

@implementation CompanyItem

- (void)setModel:(HomeCompanyModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=E:\\thh\\picture\\gamecompanys\\%@%@.png", model.name, [Tools returnKey]];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    self.label.text = [NSString stringWithFormat:@"%@", model.name];
}

//- (void)setDataArr:(NSMutableArray *)dataArr{
//    _dataArr = dataArr;
//    self.label.text = dataArr[0];
//    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/owl_studio_account_transaction/file/downloadimg.do?filePath=E:\thh\\picture\\gamecompanys\\%@%@.png", dataArr[1], [Tools returnKey]];
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
//}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageV];
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    self.label.textColor = [UIColor colorWithRed:80.f / 255.f green:80.f / 255.f blue:80.f / 255.f alpha:1];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, 46 * WIDTHMAKE, 46 * WIDTHMAKE);
    self.imageV.center = CGPointMake(self.contentView.center.x, self.contentView.center.y - 18 * WIDTHMAKE);
    self.label.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 15 * WIDTHMAKE);
    self.label.center = CGPointMake(self.contentView.center.x, self.contentView.center.y + 18 * WIDTHMAKE);
}

















@end
