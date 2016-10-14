//
//  UITextField+YPTextField.h
//  Game
//
//  Created by 王艳平 on 16/7/26.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YPTextField)
+ (instancetype)textFiledLeftView:(UIView *)leftView rightView:(UIView *)rightView secureText:(BOOL)secureText Placeholder:(NSString *)placeholder;

+ (instancetype)textFieldLeftView:(UIView *)leftView rightView:(UIView *)rightView text:(NSString *)text;
@end
