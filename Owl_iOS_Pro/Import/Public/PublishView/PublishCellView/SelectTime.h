//
//  SelectTime.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NoteBidTimeBlock)(BOOL);
typedef void(^DatePicker)();
@interface SelectTime : UIView
@property (nonatomic, strong)UIButton *pullBtn;
@property (nonatomic, strong)DatePicker datePicker;
@property (nonatomic, strong)UILabel *hourLabel;
@property (nonatomic, copy)NoteBidTimeBlock noteVcBlock;
@end
