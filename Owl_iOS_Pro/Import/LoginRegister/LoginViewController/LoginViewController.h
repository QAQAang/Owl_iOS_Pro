//
//  ViewController.h
//  Game
//
//  Created by 王艳平 on 16/7/18.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QQBlock)(NSString *, NSString *);
typedef void(^ChangeHeaderViwBlock)(NSString *, NSString *, NSString *, NSString *, NSString *);
@interface LoginViewController : UIViewController
@property (nonatomic, copy)ChangeHeaderViwBlock changeHeaderBlock;
@property (nonatomic, copy)QQBlock qqBlock;
- (void)loginRequest:(NSString *)phoneText pwd:(NSString *)pwdText;
@end

