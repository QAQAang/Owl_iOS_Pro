//
//  MinePraceView.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/15.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "MinePraceView.h"

@interface MinePraceView ()<UITextFieldDelegate>

@property (nonatomic, retain)UIButton *leftButton;

@property (nonatomic, retain)UIButton *rightButton;

@property (nonatomic, retain)UITextField *textF;

@end

@implementation MinePraceView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(23.5 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 30 * WIDTHMAKE, 30 * HEIGHTMAKE);
    self.leftButton.backgroundColor = [UIColor whiteColor];
    [self.leftButton setImage:[UIImage imageNamed:@"减号N"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"减号Y"] forState:UIControlStateHighlighted];
    [self.leftButton addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *leftPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeft)];
    leftPress.minimumPressDuration = 0.05;
    [self.leftButton addGestureRecognizer:leftPress];
    [self addSubview:self.leftButton];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.backgroundColor = [UIColor  whiteColor];
    self.rightButton.frame = CGRectMake(113.5 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 30 * WIDTHMAKE, 30 * HEIGHTMAKE);
    [self.rightButton setImage:[UIImage imageNamed:@"加号N"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"加号Y"] forState:UIControlStateHighlighted];
    [self.rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *rightPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickRight)];
    rightPress.minimumPressDuration = 0.05;
    [self.leftButton addGestureRecognizer:rightPress];
    [self addSubview:self.rightButton];
    self.textF = [[UITextField alloc] initWithFrame:CGRectMake(58.5 * WIDTHMAKE, 9.5 * HEIGHTMAKE, 50 * WIDTHMAKE, 12 * HEIGHTMAKE)];
    self.textF.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    self.textF.textAlignment  = NSTextAlignmentCenter;
    self.textF.delegate = self;
    [self.textF sizeToFit];
    self.textF.text = @"0";
    self.textF.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.textF];
}

- (void)clickLeft{
    NSInteger count = [self.textF.text integerValue];
    count--;
    self.textF.text = [NSString stringWithFormat:@"%ld", (long)count];
}

- (void)clickRight{
    NSInteger count = [self.textF.text integerValue];
    count++;
    self.textF.text = [NSString stringWithFormat:@"%ld", (long)count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
