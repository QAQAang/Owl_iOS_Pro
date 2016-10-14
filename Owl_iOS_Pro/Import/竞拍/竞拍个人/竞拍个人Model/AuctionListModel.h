//
//  AuctionListModel.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/23.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuctionListModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

@end
