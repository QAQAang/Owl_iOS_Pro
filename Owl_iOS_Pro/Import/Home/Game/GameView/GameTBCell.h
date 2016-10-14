//
//  GameTBCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

typedef void(^FollowBlock)(void);

#import <UIKit/UIKit.h>
#import "GameModel.h"
@interface GameTBCell : UITableViewCell

@property (nonatomic, retain) GameModel *model;

@property (nonatomic, copy) FollowBlock followBlock;

@end
