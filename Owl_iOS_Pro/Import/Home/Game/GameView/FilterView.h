//
//  FilterView.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/8.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate <NSObject>

- (void)equipmentMethod;

@end

@interface FilterView : UIView

@property (nonatomic, assign)id<FilterViewDelegate> delegate;

- (void)firstRemove:(FilterView *)view;

@end
