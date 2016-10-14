//
//  HomeCompanyModel.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "HomeCompanyModel.h"

@implementation HomeCompanyModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (NSMutableArray *)getModel:(NSArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in dataArr) {
        HomeCompanyModel *model = [[HomeCompanyModel alloc] initWithDic:dic];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.companyID = value;
    }
}

@end
