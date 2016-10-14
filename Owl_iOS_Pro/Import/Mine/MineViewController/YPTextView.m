//
//  SQTextView.m
//  百思不得其姐new
//
//  Created by 王艳平 on 15/10/6.
//  Copyright (c) 2015年 王艳平. All rights reserved.
//

#import "YPTextView.h"
#import "UIView+YPFrameExtension.h"

@implementation YPTextView

#pragma mark - 初始化占位文字
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark - 监听
- (void)textDidChange:(NSNotification *)note
{
    [self setNeedsDisplay];
}

#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 画占位文字
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = self.placeholderColor;
    attr[NSFontAttributeName] = self.font;
    
    rect.origin.x = 6;
    rect.origin.y = 8;
    rect.size.width = self.width - 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attr];
}

#pragma mark - text改变
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
