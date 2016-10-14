//
//  BankCardCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/9/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BankModel;
@interface BankCardCell : UITableViewCell
@property (nonatomic, strong)NSString *bankNumber;
@property (nonatomic, strong)BankModel *bankModel;
@end
