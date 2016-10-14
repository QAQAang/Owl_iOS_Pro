//
//  ListView.m
//  TestPro
//
//  Created by Aang on 16/8/24.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "ListView.h"

@interface ListView ()

@property (nonatomic, retain)UILabel *savePic;

@property (nonatomic, retain)UILabel *cancel;

@end

@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame{
    self  =  [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.backgroundColor = [UIColor colorWithRed:225.f / 255 green:225.f  /  255 blue:225.f / 255 alpha:1];
    self.savePic = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    self.savePic.font = [UIFont systemFontOfSize:17];
    self.savePic.textAlignment = NSTextAlignmentCenter;
    self.savePic.textColor = [UIColor colorWithRed:40.f / 255 green:40.f / 255 blue:40.f / 255 alpha:1];
    UITapGestureRecognizer *tapSavePic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSavePic)];
    [self.savePic  addGestureRecognizer:tapSavePic];
    self.savePic.backgroundColor = [UIColor  colorWithRed:239.f / 255 green:239.f / 255 blue:239.f / 255 alpha:1];
    self.savePic.text = @"保存图片";
    [self addSubview:self.savePic];
    self.cancel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.frame.size.width, 30)];
    self.cancel.font = [UIFont systemFontOfSize:17];
    self.cancel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tapCancel = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(clickCancel)];
    [self.cancel addGestureRecognizer:tapCancel];
    self.cancel.textColor = [UIColor colorWithRed:40.f / 255 green:40.f / 255 blue:40.f / 255 alpha:1];
    self.cancel.text = @"取消";
    self.cancel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [self addSubview:self.cancel];
}

- (void)clickSavePic{
    self.savePicBlock();
}

- (void)clickCancel{
    self.cancelBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
