//
//  InputField.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputField : UITextField

+ (InputField *)fieldTarget:(id)target addAction:(SEL)action withFrame:(CGRect)frame;
@end
