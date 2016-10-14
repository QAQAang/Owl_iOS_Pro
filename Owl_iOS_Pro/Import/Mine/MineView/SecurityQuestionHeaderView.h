//
//  SecurityQuestionView.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/8/17.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecurityQuestionHeaderViewDelegete <NSObject>

@optional
- (void)foldHeaderInSection:(NSInteger)section questionLabel:(NSString *)question;

@end

@interface SecurityQuestionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, assign)BOOL fold;/*是否折叠*/
@property (nonatomic, assign)NSInteger section;/*选中的组数*/
@property (nonatomic, strong) UILabel *questionLabel;//选择显示的问题

@property (nonatomic, assign)id <SecurityQuestionHeaderViewDelegete> delegate;

- (void)setFoldHeaderSectionTitle:(NSString *)title questionLabel:(NSString *)question section:(NSInteger)section canFold:(BOOL)canFold;
@end
