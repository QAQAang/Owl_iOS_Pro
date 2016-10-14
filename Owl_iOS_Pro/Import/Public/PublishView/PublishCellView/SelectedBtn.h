//
//  SelectedBtn.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedBtn : UIButton
//发布中选择的按钮
+ (SelectedBtn *)buttonWithAction:(SEL)action addTarget:(id)target;
@end
