//
//  AccountManagerBtn.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/6.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountManagerBtn.h"
#import "UIView+YPFrameExtension.h"

@implementation AccountManagerBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 3 * WIDTHMAKE;
}
@end
