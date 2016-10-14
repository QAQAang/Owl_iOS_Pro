//
//  PublishInputCell.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputField.h"

typedef void(^InputFieldTextBlock)(NSString *fieldText);

@class PublishCellModel;
@interface PublishInputCell : UITableViewCell
@property (nonatomic, strong)PublishCellModel *model;
@property (nonatomic, copy)InputFieldTextBlock fieldTextBlock;
@property (nonatomic, strong)InputField *field;
@end
