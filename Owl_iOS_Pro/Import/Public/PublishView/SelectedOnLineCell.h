//
//  SelectedOnLineCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/5.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NoteVcTimeBlock)(BOOL);
typedef void(^SelectOnLineBlock)(NSString *);
@class PublishCellModel;
@interface SelectedOnLineCell : UITableViewCell
@property (nonatomic, strong)PublishCellModel *model;
@property (nonatomic, copy)SelectOnLineBlock selectOnLineBlock;
@property (nonatomic, copy)NoteVcTimeBlock noteVcBlock;
@end
