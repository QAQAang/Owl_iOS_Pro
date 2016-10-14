//
//  LocalViewController.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/6.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ServerStuff)(NSString *, NSString *, NSString *);

@interface LocalViewController : UIViewController

@property (nonatomic, assign)BOOL pick;

@property (nonatomic, copy)NSString *gameName;

@property (nonatomic, copy)ServerStuff serverStuff;

@property (nonatomic, retain)UIColor *tintColor;

@property(nonatomic, strong)UIView *publishView;

@property(nonatomic, assign)NSInteger index;

@end
