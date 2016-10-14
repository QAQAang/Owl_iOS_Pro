//
//  UIButton+YPTextFieldButton.h
//  Game
//
//  Created by 王艳平 on 16/7/26.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YPTextFieldButton)
+ (instancetype)buttonWithLoginRegisterNormalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle addTarget:(id)target action:(SEL)action;

+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle addTarget:(id)target action:(SEL)action;

+ (instancetype)buttonWithImage:(NSString *)image selectedImage:(NSString *)selImage addTarget:(id)target action:(SEL)action;

+ (instancetype)buttonWithImage:(NSString *)image addTarget:(id)target action:(SEL)action;

+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle disableTitle:(NSString *)disableTitle addTarget:(id)target action:(SEL)action;


@end

