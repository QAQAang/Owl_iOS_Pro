//
//  AccountMangerViewController.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/6.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeName)(NSString *);
typedef void(^ChangeIcon)(UIImage *);
@interface AccountMangerViewController : UIViewController
@property (nonatomic, copy)ChangeName changeNameBlock;
@property (nonatomic, copy)ChangeIcon changeIconBlock;
@property (nonatomic, strong)UIImage *iconImage;
@end
