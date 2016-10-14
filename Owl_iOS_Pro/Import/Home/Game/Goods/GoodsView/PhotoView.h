//
//  PhotoView.h
//  TestPro
//
//  Created by 王艳平 on 16/8/11.
//  Copyright © 2016年 Owl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewDelegate <NSObject>

- (void)clickMethodCount:(NSInteger)count;

@end

@interface PhotoView : UIImageView

@property (nonatomic, assign)id<PhotoViewDelegate> delegate;

@property (nonatomic, copy)NSString *imageURL;

@end
