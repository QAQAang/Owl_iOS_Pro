//
//  StarView.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/13.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (void)setStarCount:(NSInteger)starCount{
    [self creatStarCount:starCount];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 5; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(21 * WIDTHMAKE * i, 0, 16 * WIDTHMAKE, 16 * WIDTHMAKE)];
            imageV.backgroundColor = [UIColor whiteColor];
            imageV.image = [UIImage imageNamed:@"灰星星"];
            imageV.tag = 1250 + i;
            [self addSubview:imageV];
        }
    }
    return self;
}

- (void)creatStarCount:(NSInteger)count{
    for (int i = 0; i < count / 2; i++) {
        UIImageView *imageV = [self viewWithTag:1250 + i];
#warning 星星
        imageV.image = [UIImage imageNamed:@"星星"];
    }
    if (count % 2 == 1) {
        UIImageView *imageV = [self viewWithTag:1250 + count / 2 + 1];
        imageV.image = [UIImage imageNamed:@"halfStar"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
