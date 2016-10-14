//
//  HotGameItem.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "HotGameItem.h"
#import <UIImageView+WebCache.h>
#import "Tools.h"

@interface HotGameItem ()

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UILabel *label;

@end

@implementation HotGameItem

- (void)setModel:(HomeGameModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=E:\\thh\\picture\\games\\%@%@.png", model.name, [Tools returnKey]];

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.label.text = model.name;
}

//- (void)setDataArr:(NSMutableArray *)dataArr{
//    _dataArr = dataArr;
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
    self.label.font = [UIFont systemFontOfSize:18 * WIDTHMAKE];
    self.label.backgroundColor = COLOR(71, 71, 71, 0.4);
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, WIDTHS / 2 - 0.5 * WIDTHMAKE, 110 * HEIGHTMAKE);
    self.label.frame = CGRectMake(0, 0, WIDTHS / 2 - 0.5 * WIDTHMAKE, 110 * HEIGHTMAKE);
}

@end
