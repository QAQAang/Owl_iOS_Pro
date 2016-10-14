//
//  AddBankCardViewController.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/9.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BankCard)(NSMutableDictionary *);
@interface AddBankCardViewController : UIViewController
@property (nonatomic, copy)BankCard bankCardBlock;
@end
