//
//  Tools.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "Tools.h"
#import <AFNetworking.h>
#import "LoadingView.h"

@implementation Tools

+ (CGFloat)getHeightString:(NSString *)text FontSize:(CGFloat)fontSize Width:(CGFloat)width{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}
+ (NSString *)returnKey{
    if ([UIScreen mainScreen].bounds.size.width > 375) {
        return @"@2x";
    }else{
        return @"@3x";
    }
}

+ (void)alertMethod:(UIViewController *)vc{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接" message:@"请检查你的网络连接" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [vc presentViewController:alert animated:YES completion:nil];
}
// get请求
+ (void)getRequestViewController:(nonnull UIViewController *)vc FliterFrame:(CGRect)frame NeedLoading:(BOOL)needLoading URL:(nonnull NSString *)url Parameters:(nullable id)parameters Progress:(_Nonnull Progress)downloadProgress Success:(_Nonnull Success)success Failure:(_Nonnull Failure)failure{
    LoadingView *loading;
    if (needLoading) {


        NSLog(@"%@", NSStringFromCGRect(frame));

        loading = [[LoadingView alloc] initWithFrame:frame];
        [vc.view addSubview:loading];
    }
    AFHTTPSessionManager *managerCompany = [AFHTTPSessionManager manager];
    [managerCompany GET:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        [loading removeFromSuperview];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        [loading removeFromSuperview];
    }];

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [managerCompany.operationQueue cancelAllOperations];
                [self alertMethod:vc];
                break;
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


// post请求
+ (void)postRequestViewController:(UIViewController *)vc FliterFrame:(CGRect)frame NeedLoading:(BOOL)needLoading URL:(nonnull NSString *)url Parameters:(nullable id)parameters Progress:(Progress)downloadProgress Success:(Success)success Failure:(Failure)failure{
    LoadingView *loading;
    if (needLoading) {
        loading = [[LoadingView alloc] initWithFrame:frame];
        [vc.view addSubview:loading];
    }
    AFHTTPSessionManager *managerCompany = [AFHTTPSessionManager manager];

    [managerCompany GET:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        [loading removeFromSuperview];
    } failure:failure];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [managerCompany.operationQueue cancelAllOperations];
                [self alertMethod:vc];
                break;
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
