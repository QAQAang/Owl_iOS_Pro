//
//  GameModel.h
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/8/2.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
#import "SellerModel.h"
@interface GameModel : NSObject


@property (nonatomic, retain)GoodsModel *goods;

@property (nonatomic, retain)SellerModel *sellers;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

@property (nonatomic, copy)NSString *goodsID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *game;
@property (nonatomic, copy)NSString *space;
@property (nonatomic, copy)NSString *server;
@property (nonatomic, copy)NSString *profession;
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, copy)NSString *grades;
@property (nonatomic, copy)NSString *equippedType;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *des_crip_tion;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *way;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *deadTime;
@property (nonatomic, copy)NSString *stock;
@property (nonatomic, copy)NSString *picturePath;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *encrypted;
@property (nonatomic, copy)NSString *online;
@property (nonatomic, copy)NSString *sellerType;
@property (nonatomic, copy)NSString *bphone;
@property (nonatomic, copy)NSString *qqfriend;
@property (nonatomic, copy)NSString *bemail;



- (instancetype)initWithDic:(NSMutableDictionary *)dic;


@end
