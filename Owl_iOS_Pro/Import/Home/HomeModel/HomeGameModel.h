//
//  HomeGameModel.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeGameModel : NSObject

@property (nonatomic, copy)NSString *gameID;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *icon;

@property (nonatomic, copy)NSString *company;

@property (nonatomic, copy)NSString *hot;

@property (nonatomic, copy)NSString *letter;

@property (nonatomic, copy)NSString *homepage;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
