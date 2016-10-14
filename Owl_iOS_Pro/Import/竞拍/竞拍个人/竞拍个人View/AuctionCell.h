//
//  AuctionCell.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/22.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionListModel.h"
typedef void(^ClickButton)(void);

@interface AuctionCell : UITableViewCell

@property (nonatomic, retain)AuctionListModel *model;

@property (nonatomic, copy)ClickButton clickButton;

@property (nonatomic, retain)UIColor *color;

@end
