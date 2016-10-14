//
//  PublishSaleTypeCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishSaleTypeCell.h"
#import "UIView+YPFrameExtension.h"
#import "TitleLabel.h"
#import "PublishCellModel.h"
#import "InputField.h"
#import "SelectedBtn.h"
#import "SelectTime.h"

@interface PublishSaleTypeCell () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)UIView *middleView;
@property (nonatomic, strong)SelectedBtn *secondBtn;
@property (nonatomic, strong)TitleLabel *title;

@property (nonatomic, strong)SelectTime *time;
@property (nonatomic, copy)NSMutableArray *timeArray;

@property (nonatomic, strong)UIPickerView *timePicker;
@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@end

@implementation PublishSaleTypeCell

#pragma mark - lazy
- (NSMutableArray *)timeArray
{
    if (!_timeArray) {
        _timeArray = [NSMutableArray arrayWithObjects:@"8", @"12" ,@"24", @"36", @"48", @"72", nil];
    }
    return _timeArray;
}

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
    
    self.title.text = _model.title;
    [self.firstBtn setTitle:_model.norTitle forState:UIControlStateNormal];
    [self.secondBtn setTitle:_model.selTitle forState:UIControlStateNormal];
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
    
    //中部
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + 20 * WIDTHMAKE, 0, WIDTHS - 230 * WIDTHMAKE, self.height)];
    SelectedBtn *firstBtn = [SelectedBtn buttonWithAction:@selector(yesOrNoClick:) addTarget:self];
    firstBtn.selected = YES;
    firstBtn.frame = CGRectMake(20 * WIDTHMAKE, 0, 47 * WIDTHMAKE, self.height);
    firstBtn.centerY = self.contentView.centerY;
    [middleView addSubview:firstBtn];
    self.firstBtn = firstBtn;
    
    SelectedBtn *secondBtn = [SelectedBtn buttonWithAction:@selector(yesOrNoClick:) addTarget:self];
    secondBtn.frame = CGRectMake(CGRectGetMaxX(firstBtn.frame) + 3 * WIDTHMAKE, 0, 47 * WIDTHMAKE, self.height);
    
    secondBtn.centerY = self.contentView.centerY;
    [middleView addSubview:secondBtn];
    self.secondBtn = secondBtn;
    self.middleView = middleView;
    [self.contentView addSubview:middleView];
    
    //尾部
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(middleView.frame) + 10 * WIDTHMAKE, 0, 110 * WIDTHMAKE, self.height)];
    
    [self.contentView addSubview:rightView];
    self.rightView = rightView;
    
    SelectTime *time = [[SelectTime alloc] initWithFrame:CGRectMake(5 * WIDTHMAKE, 0, 100 * WIDTHMAKE, 36 * HEIGHTMAKE)];
    time.centerY = self.contentView.centerY;
    self.time = time;
    time.noteVcBlock = ^(BOOL isSelceted){
        self.noteBidBlock(isSelceted);
    };
    
    time.datePicker = ^(){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCover)];
        self.tap = tap;
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
        [coverView addGestureRecognizer:tap];
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UIPickerView *timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHTS - 180 * HEIGHTMAKE, WIDTHS, 180 * HEIGHTMAKE)];
        timePicker.dataSource = self;
        timePicker.delegate = self;
        timePicker.backgroundColor = COLOR(215, 215, 215, 0.8);
        [coverView addSubview:timePicker];
        coverView.alpha = 0;
        timePicker.alpha = 0;
        [self.window addSubview:coverView];
        [UIView animateWithDuration:0.25 animations:^{
            coverView.alpha = 1.0;
            timePicker.alpha = 1.0;
        }];
        self.timePicker = timePicker;
        self.coverView =coverView;
    };
    [rightView addSubview:time];
    self.rightView.hidden = YES;
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5 * HEIGHTMAKE, WIDTHS, 0.5 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(200, 199, 204, 1.0);
    [self.contentView addSubview:lineOne];
}

- (void)yesOrNoClick:(SelectedBtn *)btn
{
    if (btn == self.firstBtn) {
        if (self.firstBtn.isSelected) {
            self.firstBtn.selected = NO;
            self.secondBtn.selected = YES;
            self.rightView.hidden = NO;
            self.chooseSalerBlock(self.secondBtn.currentTitle, self.time.hourLabel.text);
        } else {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = NO;
            self.rightView.hidden = YES;
            //传值出去
            self.chooseSalerBlock(self.firstBtn.currentTitle, nil);
        }
    } else {
        if (self.secondBtn.isSelected) {
            self.secondBtn.selected = NO;
            self.firstBtn.selected = YES;
            self.rightView.hidden = YES;
            self.chooseSalerBlock(self.firstBtn.currentTitle, nil);
        } else {
            self.secondBtn.selected = YES;
            self.firstBtn.selected = NO;
            self.rightView.hidden = NO;
            //传值出去
            self.chooseSalerBlock(self.secondBtn.currentTitle, self.time.hourLabel.text);
        }
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.timeArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36 * HEIGHTMAKE;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.timeArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *text = self.timeArray[row];
    
    self.chooseTimeBlock(text);
    
    self.time.hourLabel.text = text;
}

- (void)removeCover
{
    [UIView animateWithDuration:0.25 animations:^{
        self.timePicker.alpha = 0;
        self.coverView.alpha = 0;
        self.time.pullBtn.selected = NO;
    } completion:^(BOOL finished) {
        [self.timePicker removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self.coverView removeGestureRecognizer:self.tap];
    }];
}

@end
