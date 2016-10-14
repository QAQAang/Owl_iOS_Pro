//
//  PublishCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectedBtn;
typedef void(^ChooseBlock)(NSString *);
@class PublishCellModel;
@interface PublishCell : UITableViewCell

@property (nonatomic, strong)PublishCellModel *model;

@property (nonatomic, copy)ChooseBlock chooseBlock;

@property (nonatomic, strong)SelectedBtn *firstBtn;
@end
