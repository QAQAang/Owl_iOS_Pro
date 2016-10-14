//
//  TitleTableViewCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/10/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "TitleTableViewCell.h"
#import "Tools.h"
@implementation TitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatTitle];
    }
    return self;
}

- (void)creatTitle{
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.title.textColor = COLOR(60, 60, 60, 1);
    [self.contentView addSubview:self.title];
    self.detailTitle = [[UILabel alloc] init];
    self.detailTitle.font = [UIFont systemFontOfSize:14 * HEIGHTMAKE];
    self.detailTitle.textColor = COLOR(60, 60, 60, 1);
    self.detailTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.detailTitle];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.title.frame = CGRectMake(10 * WIDTHMAKE, 10 * HEIGHTMAKE, WIDTHS - 20 * WIDTHMAKE, self.contentView.frame.size.height - 20 * HEIGHTMAKE);
    self.detailTitle.frame = CGRectMake(WIDTHS - 110 * WIDTHMAKE, 10 * HEIGHTMAKE, 100 * WIDTHMAKE, 15 * HEIGHTMAKE);
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
