//
//  PublishFooterView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishFooterView.h"

@interface PublishFooterView ()

@end

@implementation PublishFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHS - 20 * WIDTHMAKE, 15 * HEIGHTMAKE)];
    warnLabel.text = @"请描述商品重要信息";
    warnLabel.textColor = [UIColor redColor];
    
    warnLabel.font = [UIFont systemFontOfSize:12 * HEIGHTMAKE];
    [self addSubview:warnLabel];
    
    UITextView *descText = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(warnLabel.frame), self.frame.size.width, self.frame.size.height - warnLabel.frame.size.height)];
    descText.layer.cornerRadius = 3 * WIDTHMAKE;
    
    [self addSubview:descText];
    self.textView = descText;
}


@end
