//
//  AccountHomeViewController.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/19.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeNickName)(NSString *);
@interface AccountHomeViewController : UITableViewController
@property (nonatomic, copy)ChangeNickName changeNickNameBlock;
@end
