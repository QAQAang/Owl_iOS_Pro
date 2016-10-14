//
//  PublishInputCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/14.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "PublishInputCell.h"
#import "UIView+YPFrameExtension.h"
#import "TitleLabel.h"
#import "PublishCellModel.h"


@interface PublishInputCell ()
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)TitleLabel *title;

@end

@implementation PublishInputCell

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
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTHS - 200 * WIDTHMAKE, 0, 200 * WIDTHMAKE, self.height)];
    
    [self.contentView addSubview:rightView];
    self.rightView = rightView;
    
    InputField *field = [InputField fieldTarget:self addAction:@selector(textChange:) withFrame:CGRectMake(0, 0, 190 * WIDTHMAKE, rightView.height)];
    [self.rightView addSubview:field];
    self.field = field;
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5 * HEIGHTMAKE, WIDTHS, 0.5 * HEIGHTMAKE)];
    lineOne.backgroundColor = COLOR(200, 199, 204, 1.0);
    [self.contentView addSubview:lineOne];
}

- (void)textChange:(InputField *)field
{
    self.fieldTextBlock(field.text);
    
}

@end
