//
//  PublishBtn.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/25.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishBtn.h"
#import "UIView+YPFrameExtension.h"

@implementation PublishBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
        [self setTitleColor:COLOR(80, 80, 80, 1.0) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
}

@end
