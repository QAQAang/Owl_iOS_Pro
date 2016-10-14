//
//  SellerModel.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/30.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SellerModel.h"

@implementation SellerModel

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
        SellerModel *model = [[SellerModel alloc] initWithDic:dic];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.sellerID = value;
    }
}

@end
