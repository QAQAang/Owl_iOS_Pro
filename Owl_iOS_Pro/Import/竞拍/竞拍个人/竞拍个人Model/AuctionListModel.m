//
//  AuctionListModel.m
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/23.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AuctionListModel.h"

@implementation AuctionListModel

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
        AuctionListModel *model = [[AuctionListModel alloc] initWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
