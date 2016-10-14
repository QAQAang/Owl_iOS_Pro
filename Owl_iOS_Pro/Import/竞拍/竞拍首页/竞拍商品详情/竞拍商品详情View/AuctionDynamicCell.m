//
//  AuctionDynamicCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionDynamicCell.h"

@interface AuctionDynamicCell ()

@property (nonatomic, retain)UILabel *nameLabel;

@property (nonatomic, retain)UILabel *stataLabel;

@property (nonatomic, retain)UILabel *auctionTime;

@property (nonatomic, retain)UILabel *praceLabel;

@end

@implementation AuctionDynamicCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatLabel];
    }
    return self;
}

- (void)creatLabel{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    self.nameLabel.textColor = COLOR(102, 102, 102, 1);
    [self.contentView addSubview:self.nameLabel];
    self.stataLabel = [[UILabel alloc] init];
    self.stataLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    self.stataLabel.textColor = COLOR(102, 102, 102, 1);
    [self.contentView addSubview:self.stataLabel];
    self.auctionTime = [[UILabel alloc] init];
    self.auctionTime.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    self.auctionTime.textColor = COLOR(102, 102, 102, 1);
    [self.contentView addSubview:self.auctionTime];
    self.praceLabel = [[UILabel alloc] init];
    self.praceLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    self.praceLabel.textColor = COLOR(102, 102, 102, 1);
    [self.contentView addSubview:self.praceLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(10 * WIDTHMAKE, 12 * HEIGHTMAKE, 48 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.stataLabel.frame = CGRectMake(78 * WIDTHMAKE, 12 * HEIGHTMAKE, 24 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.auctionTime.frame = CGRectMake(122 * WIDTHMAKE, 12 * HEIGHTMAKE, 80 * WIDTHMAKE, 14 * HEIGHTMAKE);
    self.praceLabel.frame = CGRectMake(WIDTHS - 50 * WIDTHMAKE, 12 * HEIGHTMAKE, 50 * WIDTHMAKE, 14 * HEIGHTMAKE);
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
