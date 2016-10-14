//
//  ClickView.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/10.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Click)(void);
@interface ClickView : UIView

@property (nonatomic, retain)UIImage *nomalImage;

@property (nonatomic, retain)UIImage *highlightImage;

@property (nonatomic, copy)NSString *text;

@property (nonatomic, copy)Click click;

@property (nonatomic, assign)BOOL classPick;

- (void)changeImage:(UIImage *)image;

@end
