//
//  SearchTextField.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleNone;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.enablesReturnKeyAutomatically = YES;
        self.textColor = [UIColor whiteColor];
        self.tintColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3 * WIDTHMAKE;
        self.backgroundColor = COLOR(0, 151, 178, 1.0);
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_search_icon"]];
        leftView.frame = CGRectMake(0, 0, self.frame.size.height - 6 * WIDTHMAKE, self.frame.size.height);
        leftView.contentMode = UIViewContentModeRight;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:12 * WIDTHMAKE];
        attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:attr];
    }
    return self;
}

//设置默认文字的显示区域
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(32 * WIDTHMAKE,3.5 * HEIGHTMAKE,bounds.size.width ,bounds.size.height);
}
//设置文本显示的区域
-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(32 * WIDTHMAKE,0,bounds.size.width ,bounds.size.height);
}
//编辑区域，即光标的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(30 * WIDTHMAKE,5 * HEIGHTMAKE,bounds.size.width ,bounds.size.height);
}
//调整光标的大小
- (CGRect)caretRectForPosition:(UITextPosition *)position{
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = self.font.lineHeight - 5 * HEIGHTMAKE;
    originalRect.size.width = 2 * WIDTHMAKE;
    return originalRect;
}

@end
