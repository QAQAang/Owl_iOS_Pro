//
//  UITextField+YPTextField.m
//  Game
//
//  Created by 王艳平 on 16/7/26.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "UITextField+YPTextField.h"

@implementation UITextField (YPTextField)
+ (instancetype)textFiledLeftView:(UIView *)leftView rightView:(UIView *)rightView secureText:(BOOL)secureText Placeholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    attr[NSForegroundColorAttributeName] = COLOR(192, 192, 194, 1.0);
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attr];
    textField.secureTextEntry = secureText;
    
    leftView.frame = CGRectMake(0, 0, 40, 30);
    leftView.contentMode = UIViewContentModeCenter;
    
    rightView.contentMode = UIViewContentModeCenter;
    
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.enablesReturnKeyAutomatically = YES;
    
    return textField;
}

+ (instancetype)textFieldLeftView:(UIView *)leftView rightView:(UIView *)rightView text:(NSString *)text;

{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    leftView.contentMode = UIViewContentModeCenter;
    rightView.contentMode = UIViewContentModeCenter;
    
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;

    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.enablesReturnKeyAutomatically = YES;
    
    textField.text = text;
    
    return textField;

}
@end
