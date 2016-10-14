//
//  PublishCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/1.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishCell.h"
#import "UIView+YPFrameExtension.h"
#import "TitleLabel.h"
#import "SelectedBtn.h"
#import "PublishCellModel.h"


@interface PublishCell ()

@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *middleView;
@property (nonatomic, strong)UIView *rightView;

@property (nonatomic, strong)SelectedBtn *secondBtn;

@property (nonatomic, strong)TitleLabel *title;
@end

@implementation PublishCell

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

- (void)createUI   //77--?--118
{
    //标题
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90 * WIDTHMAKE, self.height)];
    [self.contentView addSubview:leftView];
    
    TitleLabel *title = [[TitleLabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, 90 * WIDTHMAKE, self.height)];

    title.centerY = self.centerY;
    [leftView addSubview:title];
    self.leftView = leftView;
    self.title = title;
    
    
    //尾部
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS - 110 * WIDTHMAKE, 0, 110 * WIDTHMAKE, self.height)];
    SelectedBtn *firstBtn = [SelectedBtn buttonWithAction:@selector(yesOrNoClick:) addTarget:self];
    firstBtn.selected = YES;
    firstBtn.frame = CGRectMake(10 * WIDTHMAKE, 0, 47 * WIDTHMAKE, self.contentView.height);
    firstBtn.centerY = self.contentView.centerY;
    [rightView addSubview:firstBtn];
    self.firstBtn = firstBtn;
    
    SelectedBtn *secondBtn = [SelectedBtn buttonWithAction:@selector(yesOrNoClick:) addTarget:self];
    secondBtn.frame = CGRectMake(CGRectGetMaxX(firstBtn.frame) + 3 * WIDTHMAKE, 0, 47 * WIDTHMAKE, self.height);
    
    secondBtn.centerY = self.contentView.centerY;
    [rightView addSubview:secondBtn];
    self.secondBtn = secondBtn;
    
    [self.contentView addSubview:rightView];
    self.rightView = rightView;
    
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
            self.chooseBlock(self.secondBtn.currentTitle);
        } else {
            self.firstBtn.selected = YES;
            self.secondBtn.selected = NO;
            self.chooseBlock(self.firstBtn.currentTitle);
        }
    } else {
        if (self.secondBtn.isSelected) {
            self.secondBtn.selected = NO;
            self.firstBtn.selected = YES;
            self.chooseBlock(self.firstBtn.currentTitle);
        } else {
            self.secondBtn.selected = YES;
            self.firstBtn.selected = NO;
            self.chooseBlock(self.secondBtn.currentTitle);
        }
    }
}

@end
