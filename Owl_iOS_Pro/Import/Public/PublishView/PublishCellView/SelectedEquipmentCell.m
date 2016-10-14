//
//  SelectedEquipmentCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/4.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SelectedEquipmentCell.h"
#import "UIView+YPFrameExtension.h"
#import "TitleLabel.h"
#import "SelectEquipment.h"
#import "PublishCellModel.h"

@interface SelectedEquipmentCell () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)TitleLabel *title;
@property (nonatomic, strong)SelectEquipment *equipment;
@property (nonatomic, strong)UIPickerView *picker;


@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@end


@implementation SelectedEquipmentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setModel:(PublishCellModel *)model
{
    _model = model;
    self.title.text = model.title;
}

- (void)createUI
{
    //标题
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90 * WIDTHMAKE, self.height)];
    [self.contentView addSubview:leftView];
    
    TitleLabel *title = [[TitleLabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, 90 * WIDTHMAKE, self.height)];
    
    title.centerY = self.contentView.centerY;
    [leftView addSubview:title];
    self.leftView = leftView;
    self.title = title;
    
    //尾部
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS - 110 * WIDTHMAKE, 0, 110 * WIDTHMAKE, self.height)];
    
    [self.contentView addSubview:rightView];
    self.rightView = rightView;
    
    SelectEquipment *equipment = [[SelectEquipment alloc] initWithFrame:CGRectMake(5 * WIDTHMAKE, 0, 100 * WIDTHMAKE, 36 * HEIGHTMAKE)];
    equipment.centerY = self.contentView.centerY;
    self.equipment = equipment;
    equipment.noteVcBlock = ^(BOOL isSelected){
        self.toDoBlock(isSelected);
    };
    
    equipment.equipmentPicker = ^(){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCover)];
        self.tap = tap;
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
        [coverView addGestureRecognizer:tap];
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 180 * HEIGHTMAKE, WIDTHS, 180 * HEIGHTMAKE)];
        picker.dataSource = self;
        picker.delegate = self;
        picker.backgroundColor = COLOR(215, 215, 215, 0.8);
        [coverView addSubview:picker];
        coverView.alpha = 0;
        picker.alpha = 0;
        [self.window addSubview:coverView];
        [UIView animateWithDuration:0.25 animations:^{
            coverView.alpha = 1.0;
            picker.alpha = 1.0;
        }];
        self.picker = picker;
        self.coverView = coverView;
    };
    [rightView addSubview:equipment];
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5 * HEIGHTMAKE, WIDTHS, 0.5 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(200, 199, 204, 1.0);
    [self.contentView addSubview:lineOne];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.equipArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36 * HEIGHTMAKE;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.equipArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *text = self.equipArray[row];
    
    self.equipment.equipLabel.text = text;
    
    self.selectEquipBlock(text);
    
}

- (void)removeCover
{
    [UIView animateWithDuration:0.25 animations:^{
        self.picker.alpha = 0;
        self.coverView.alpha = 0;
        self.equipment.pullBtn.selected = NO;
    } completion:^(BOOL finished) {
        [self.picker removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self.coverView removeGestureRecognizer:self.tap];
    }];
}
@end
