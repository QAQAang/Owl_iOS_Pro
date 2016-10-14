//
//  SecurityAnswerFooterView.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/17.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SecurityAnswerFooterView.h"

@interface SecurityAnswerFooterView ()
{
    UILabel *_titleLabel;
    UITextField *_textField;
    BOOL _created;
}
@end

@implementation SecurityAnswerFooterView

- (void)setTitle:(NSString *)title answer:(NSString *)answerText placeHolder:(NSString *)placeHolder section:(NSInteger)section
{
    if (!_created) {
        _created = YES;
        _section = section;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66 * WIDTHMAKE, 44 * HEIGHTMAKE)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = title;
        _titleLabel.textColor = COLOR(60, 60, 60, 1.0);
        _titleLabel.font =[UIFont systemFontOfSize:15 * WIDTHMAKE];
        [self.contentView addSubview:_titleLabel];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, WIDTHS - 66 * WIDTHMAKE, 44 * HEIGHTMAKE)];
        _textField.backgroundColor = [UIColor whiteColor];
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = COLOR(193, 193, 193, 1.0);
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * HEIGHTMAKE];
        [_textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeHolder attributes:attr]];
//        _textField.text = answerText;
//        _textField.delegate = self;
        [self.contentView addSubview:_textField];

    }
}

@end
