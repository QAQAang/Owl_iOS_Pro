//
//  UIImage+SQExtension.m
//  百思不得其姐new
//
//  Created by 王艳平 on 15/10/5.
//  Copyright (c) 2015年 王艳平. All rights reserved.
//

#import "UIImage+YPExtension.h"

@implementation UIImage (YPExtension)
- (instancetype)circleImage
{
    //制作圆形图片
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //画圆路径
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪图片
    CGContextClip(ctx);
    //往圆上画一张图片
    [self drawInRect:rect];
    //从上下文中获取一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)imageWithCircle:(NSString *)imageName
{
    return [[self imageNamed:imageName] circleImage];
}
@end
