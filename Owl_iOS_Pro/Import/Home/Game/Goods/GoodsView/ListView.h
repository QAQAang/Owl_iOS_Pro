//
//  ListView.h
//  TestPro
//
//  Created by Aang on 16/8/24.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SavePicBlock)(void);
typedef void(^CancelBlock)(void);
@interface ListView : UIView

@property (nonatomic, copy)SavePicBlock savePicBlock;

@property (nonatomic, copy)CancelBlock  cancelBlock;

@end
