//
//  SQTextView.h
//  百思不得其姐new
//
//  Created by 王艳平 on 15/10/6.
//  Copyright (c) 2015年 王艳平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTextView : UITextView
/** 占为文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占为文字颜色 */
@property (nonatomic, weak) UIColor *placeholderColor;
@end
