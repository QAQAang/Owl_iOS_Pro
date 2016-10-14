//
//  HotGameItem.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/7/27.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeGameModel.h"

typedef void(^ReloadBlock)(void);
@interface HotGameItem : UICollectionViewCell

@property (nonatomic, retain)HomeGameModel *model;

@property (nonatomic, copy)ReloadBlock reloadBlock;

@end
