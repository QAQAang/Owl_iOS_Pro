//
//  SettingViewController.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderBlock)();
@interface SettingViewController : UITableViewController
@property (nonatomic, copy)HeaderBlock headerBlock;
@property (nonatomic, assign)BOOL isLogOut;
@end
