//
//  TitleLabel.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        self.textColor = COLOR(60, 60, 60, 1.0);
    }
    return self;
}

@end
