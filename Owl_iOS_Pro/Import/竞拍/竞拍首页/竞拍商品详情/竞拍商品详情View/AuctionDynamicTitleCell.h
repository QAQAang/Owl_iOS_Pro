//
//  AuctionDynamicTitleCell.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuctionDynamicTitleCell : UITableViewCell

@property (nonatomic, retain)UIImageView *arrow;

- (void)animationForCell:(BOOL)isOn;

@end
