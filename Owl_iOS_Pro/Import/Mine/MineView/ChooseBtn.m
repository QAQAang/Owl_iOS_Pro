//
//  ChooseBtn.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/5.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ChooseBtn.h"
#import "UIView+YPFrameExtension.h"

@implementation ChooseBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:COLOR(60, 60, 60, 1.0) forState:UIControlStateNormal];
        [self setTitleColor:COLOR(60, 60, 60, 1.0) forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    self.titleLabel.width = WIDTHS - 70 * WIDTHMAKE - 44 * HEIGHTMAKE;
    self.titleLabel.height = 44 * HEIGHTMAKE;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 20 * HEIGHTMAKE;
    self.imageView.centerY = self.centerY;


}
@end
