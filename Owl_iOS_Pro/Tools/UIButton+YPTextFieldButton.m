//
//  UIButton+YPTextFieldButton.m
//  Game
//
//  Created by 王艳平 on 16/7/26.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "UIButton+YPTextFieldButton.h"

@implementation UIButton (YPTextFieldButton)
+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle disableTitle:(NSString *)disableTitle addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    
    NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
    norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    norAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *nor = [[NSAttributedString alloc] initWithString:normalTitle attributes:norAttr];
    [button setAttributedTitle:nor forState:UIControlStateNormal];
    
    NSMutableDictionary *disAttr = [NSMutableDictionary dictionary];
    disAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14 * WIDTHMAKE];
    disAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *dis = [[NSAttributedString alloc] initWithString:disableTitle attributes:disAttr];
    [button setAttributedTitle:dis forState:UIControlStateDisabled
     ];
    
    button.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:173 / 255.0 blue:63 / 255.0 alpha:1.0];
    button.contentMode = UIViewContentModeCenter;
    return button;

}

+ (instancetype)buttonWithImage:(NSString *)image selectedImage:(NSString *)selImage addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return button;
}

+ (instancetype)buttonWithImage:(NSString *)image addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return button;
}

+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:highlightTitle forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:157 / 255.0 green:157 / 255.0 blue:157 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:157 / 255.0 green:157 / 255.0 blue:157 / 255.0 alpha:1.0] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
    
    return button;
}

+ (instancetype)buttonWithLoginRegisterNormalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor colorWithRed:1.0 green:110 / 255.0 blue:135 / 255.0 alpha:1.0];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:highlightTitle forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:COLOR(8, 181, 242, 1.0) forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17 * HEIGHTMAKE];
    
    return button;
}
@end
