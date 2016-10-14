//
//  SellerModel.h
//  Owl_iOS_Pro
//
//  Created by Aang on 16/9/30.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerModel : NSObject

@property (nonatomic, copy)NSString *sellerID;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *creatTime;
@property (nonatomic, copy)NSString *realName;
@property (nonatomic, copy)NSString *merchant;
@property (nonatomic, copy)NSString *head;

+ (NSMutableArray *)getModel:(NSArray *)dataArr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
