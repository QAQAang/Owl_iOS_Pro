//
//  InputField.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "InputField.h"

@implementation InputField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:13 * WIDTHMAKE];
        attr[NSForegroundColorAttributeName] = COLOR(192, 192, 192, 1.0);
        [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请填写" attributes:attr]];
        
        self.textColor = COLOR(60, 60, 60, 1.0);
        self.font = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        self.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

+ (InputField *)fieldTarget:(id)target addAction:(SEL)action withFrame:(CGRect)frame
{
    InputField *field = [[InputField alloc] initWithFrame:frame];
    [field addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
    return field;
}

@end
