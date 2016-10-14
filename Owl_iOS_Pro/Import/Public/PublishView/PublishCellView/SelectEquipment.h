//
//  SelectEquipment.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EquipmentPicker)();
typedef void(^NoteEquipBlock)(BOOL);
@interface SelectEquipment : UIView
@property (nonatomic, strong)UIButton *pullBtn;
@property (nonatomic, copy)EquipmentPicker equipmentPicker;
@property (nonatomic, strong)UILabel *equipLabel;
@property (nonatomic, copy)NoteEquipBlock noteVcBlock;
@end
