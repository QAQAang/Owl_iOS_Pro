//
//  GameModel.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

- (instancetype)initWithDic:(NSMutableDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (NSMutableArray *)getModel:(NSArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        GameModel *model = [[GameModel alloc] initWithDic:dic];

        [array addObject:model];
    }
    return array;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.goodsID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.des_crip_tion = value;
    }
}

@end
