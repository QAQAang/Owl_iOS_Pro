//
//  HomeCompanyModel.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCompanyModel : NSObject

@property (nonatomic, copy)NSString *companyID;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *letter;

@property (nonatomic, copy)NSString *homepae;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
