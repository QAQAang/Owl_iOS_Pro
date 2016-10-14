//
//  CompanyModel.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *hot;
@property (nonatomic, copy) NSString *letter;
@property (nonatomic, copy) NSString *homepage;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

@end
