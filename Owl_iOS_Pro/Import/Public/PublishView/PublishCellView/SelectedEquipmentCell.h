//
//  SelectedEquipmentCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NoteEquipVcBlock)(BOOL);
typedef void(^SelectEquipBlock)(NSString *);
@class PublishCellModel;
@interface SelectedEquipmentCell : UITableViewCell
@property (nonatomic, strong)PublishCellModel *model;
@property (nonatomic, copy)SelectEquipBlock selectEquipBlock;
@property (nonatomic, copy)NSMutableArray *equipArray;
@property (nonatomic, copy)NoteEquipVcBlock toDoBlock;
@end
