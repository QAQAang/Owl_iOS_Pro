//
//  PublishSaleTypeCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectedBtn;
typedef void(^NoteBidVcBlock)(BOOL);
typedef void(^ChooseTimeBlock)(NSString *);
typedef void(^ChooseSalerBlock)(NSString *, NSString *);
@class PublishCellModel;
@interface PublishSaleTypeCell : UITableViewCell
@property (nonatomic, strong)PublishCellModel *model;
@property (nonatomic, copy)ChooseSalerBlock chooseSalerBlock;
@property (nonatomic, copy)NoteBidVcBlock noteBidBlock;
@property (nonatomic, copy)ChooseTimeBlock chooseTimeBlock;
@property (nonatomic, strong)SelectedBtn *firstBtn;
@end
