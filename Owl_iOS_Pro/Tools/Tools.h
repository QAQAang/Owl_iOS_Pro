//
//  Tools.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject
typedef void(^Progress)(NSProgress * _Nonnull downloadProgress);
typedef void(^Success)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject);
typedef void(^Failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

+ (CGFloat)getHeightString:(nonnull NSString *)text FontSize:(CGFloat)fontSize Width:(CGFloat)width;

+ (nonnull NSString *)returnKey;

+ (void)getRequestViewController:(nonnull UIViewController *)vc FliterFrame:(CGRect)frame NeedLoading:(BOOL)needLoading URL:(nonnull NSString *)url Parameters:(nullable id)parameters Progress:(_Nonnull Progress)downloadProgress Success:(_Nonnull Success)success Failure:(_Nonnull Failure)failure;



@end
