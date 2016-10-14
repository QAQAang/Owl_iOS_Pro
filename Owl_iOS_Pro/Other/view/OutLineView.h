//
//  OutLineView.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadData)(void);
@interface OutLineView : UIView

@property (nonatomic, copy)ReloadData reloadData;

@end
