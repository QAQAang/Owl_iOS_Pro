//
//  PhotoCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

//@property (nonatomic, strong)UIImageView *photoImage;
//
//@property (nonatomic, strong)UIImageView *cancelImage;

@end

@implementation PhotoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    self.photoImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoImage];
    
    self.cancelImage = [[UIImageView alloc] init];
    [self.photoImage addSubview:self.cancelImage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoImage.frame = self.contentView.frame;///////////////
    self.cancelImage.frame = CGRectMake(0, 0, 20 * WIDTHMAKE, 20 * WIDTHMAKE);
    self.cancelImage.center = CGPointMake(60 * WIDTHMAKE, 5 * HEIGHTMAKE);
    
}
@end
