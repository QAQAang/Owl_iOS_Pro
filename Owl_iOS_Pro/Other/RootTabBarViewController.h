//
//  RootTabBarViewController.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController, MineViewController, OrderViewController, MessageViewController;
@interface RootTabBarViewController : UITabBarController
@property (nonatomic, strong)HomeViewController *homeVc;
@property (nonatomic, strong)MineViewController *mineVc;
@property (nonatomic, strong)OrderViewController *orderVc;
@property (nonatomic, strong)MessageViewController *messageVc;
@end
