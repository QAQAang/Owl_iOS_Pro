//
//  GoldTBCell.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/10/6.
//  Copyright © 2016年 Aang. All rights reserved.
//
typedef void(^FollowBlock)(void);
#import <UIKit/UIKit.h>
#import "GameModel.h"
@interface GoldTBCell : UITableViewCell

@property (nonatomic, retain) GameModel *model;

@property (nonatomic, copy) FollowBlock followBlock;

@end
