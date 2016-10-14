//
//  publishView.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchBlock)(NSInteger index, UIView *publishView);
@interface PublishView : UIView
@property (nonatomic, copy)SwitchBlock switchBlock;
@end
