//
//  PhotoCollectionViewCell.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/10/7.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface PhotoCollectionViewCell ()

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.layer.borderWidth = 2;
    self.imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageV.layer.shadowOpacity = 2;
    [self.contentView addSubview:self.imageV];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

@end
