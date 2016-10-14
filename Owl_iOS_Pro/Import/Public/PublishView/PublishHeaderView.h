//
//  PublishHeaderView.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoodsTitleBlock)(NSString *);
typedef void(^SelectedImageBlock)(NSMutableArray *);
@interface PublishHeaderView : UIView
@property (nonatomic, strong)UIViewController *viewController;
@property (nonatomic, copy)SelectedImageBlock selectedImageArrayBlcock;
@property (nonatomic, copy)GoodsTitleBlock goodsTitleBlock;
@end
