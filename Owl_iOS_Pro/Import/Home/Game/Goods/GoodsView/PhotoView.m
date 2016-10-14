//
//  PhotoView.m
//  TestPro
//
//  Created by 王艳平 on 16/8/11.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import "PhotoView.h"
#import <UIImageView+WebCache.h>
@implementation PhotoView

- (void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.168:8080/file/download?path=%@", imageURL]]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate clickMethodCount:self.tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
