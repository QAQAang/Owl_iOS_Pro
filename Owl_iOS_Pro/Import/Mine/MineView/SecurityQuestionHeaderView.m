//
//  SecurityQuestionView.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/8/17.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SecurityQuestionHeaderView.h"
#import "UIView+YPFrameExtension.h"

@interface SecurityQuestionHeaderView (){
    BOOL _created;//是否创建过
    BOOL _canFold;//是否可展开
    UILabel *_titleLabel;//每一组的标题
//    UILabel *_questionLabel;//选择显示的问题
    UIButton *_selectBtn;//展开折叠按niu
}

@end

@implementation SecurityQuestionHeaderView
- (void)setFold:(BOOL)fold
{
    _fold = fold;
    if (fold) {
        _selectBtn.selected = YES;
    } else {
        _selectBtn.selected = NO;
    }
}

- (void)setFoldHeaderSectionTitle:(NSString *)title questionLabel:(NSString *)question section:(NSInteger)section canFold:(BOOL)canFold
{
    if (!_created) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    _titleLabel.text = title;
    _questionLabel.text = question;
    _section = section;
    _canFold = canFold;
}

- (void)createUI
{
    _created = YES;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    _titleLabel.textColor = COLOR(60, 60, 60, 1.0);
    _titleLabel.font =[UIFont systemFontOfSize:15 * WIDTHMAKE];
    [self.contentView addSubview:_titleLabel];
    
    _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, WIDTHS - 110 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    [self.contentView addSubview:_questionLabel];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.frame = CGRectMake(CGRectGetMaxX(_questionLabel.frame), 0, 44 *WIDTHMAKE, 44 * HEIGHTMAKE);
    [_selectBtn setImage:[UIImage imageNamed:@"pull"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"push"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5 * HEIGHTMAKE, WIDTHS, 0.5 * HEIGHTMAKE)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self.contentView addSubview:line];
}

- (void)btnClick:(UIButton *)btn
{
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:questionLabel:)]) {
            [self.delegate foldHeaderInSection:_section questionLabel:_questionLabel.text];
        }
    }
    
}

@end
