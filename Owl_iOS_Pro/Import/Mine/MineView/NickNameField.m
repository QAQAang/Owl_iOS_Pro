//
//  NickNameField.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NickNameField.h"


@interface NickNameField ()


@end

@implementation NickNameField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.enablesReturnKeyAutomatically = YES;
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = COLOR(193, 193, 193, 1.0);
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
        [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入新的昵称" attributes:attr]];
    }
    return self;
}

#warning layout

//设置默认文字的显示区域
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(12,3,bounds.size.width ,bounds.size.height);
}
//设置文本显示的区域
-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(12,3,bounds.size.width ,bounds.size.height);
}
//编辑区域，即光标的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(10,3,bounds.size.width ,bounds.size.height);
}

@end
