//
//  PublishAccountViewController.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/31.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const ID = @"cell";
static NSString * const InputID = @"PublishInputCell";
static NSString * const SaleTypeID = @"PublishSaleTypeCell";
static NSString * const SelectOnLineID = @"onLineCell";
static NSString * const equipID = @"SelectedEquipmentCell";
@interface PublishAccountViewController : UITableViewController
@property (nonatomic, copy)NSMutableArray *accountFirstArr;

@property (nonatomic, copy)NSString *gameNameT;

@property (nonatomic, copy)NSString *areasNameT;

@property (nonatomic, copy)NSString *serverNameT;

@property (nonatomic, copy)NSMutableDictionary *param;

@end
