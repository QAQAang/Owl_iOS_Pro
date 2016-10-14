//
//  PickerCell.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/12.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwichBlock)(BOOL);
@interface PickerCell : UITableViewCell

@property (nonatomic, copy)SwichBlock swichBlock;

@end
