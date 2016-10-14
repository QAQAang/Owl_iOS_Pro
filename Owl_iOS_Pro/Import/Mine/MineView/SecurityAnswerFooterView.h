//
//  SecurityAnswerFooterView.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/17.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityAnswerFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign)NSInteger section;

- (void)setTitle:(NSString *)title answer:(NSString *)answerText placeHolder:(NSString *)placeHolder section:(NSInteger)section;
@end
