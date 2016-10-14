//
//  OrderCell.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/16.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "OrderCell.h"
#import "UIView+YPFrameExtension.h"
#import "DetailAssessViewController.h"
#import "YPNavigationController.h"

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 214 * HEIGHTMAKE)];
    [self.contentView addSubview:view];
    
    //topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 44 * HEIGHTMAKE)];
    [view addSubview:topView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 0, WIDTHS - 90 * WIDTHMAKE, topView.height)];
    nameLabel.text = @"商品名称";
    nameLabel.textColor = COLOR(60, 60, 60, 1.0);
    nameLabel.font = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    [topView addSubview:nameLabel];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 0, 80 * WIDTHMAKE, topView.height)];
    statusLabel.textColor = COLOR(8, 181, 212, 1.0);
    statusLabel.font = [UIFont systemFontOfSize:13 * WIDTHMAKE];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.text = @"交易成功";
    [topView addSubview:statusLabel];
    
    //line
    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), WIDTHS, 1 * HEIGHTMAKE)];
    firstLine.backgroundColor = COLOR(200, 199, 204, 1.0);
    [view addSubview:firstLine];
    
    //middleView
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstLine.frame), WIDTHS, 128 * HEIGHTMAKE)];
    [view addSubview:middleView];
    
    UIImageView *goodsView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * WIDTHMAKE, 5 * HEIGHTMAKE, 77 * WIDTHMAKE, 77 * HEIGHTMAKE)];
    goodsView.backgroundColor = [UIColor redColor];
    [middleView addSubview:goodsView];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodsView.frame) + 6 * WIDTHMAKE, 11 * HEIGHTMAKE, WIDTHS - CGRectGetMaxX(goodsView.frame) - 12 * WIDTHMAKE, CGRectGetMaxY(goodsView.frame) - 17 * WIDTHMAKE)];
    descLabel.textColor = COLOR(60, 60, 60, 1.0);
    descLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    descLabel.numberOfLines = 0;
    descLabel.text = @"描述您的宝贝。。。。。。。。。。eeeeeeeeee.e.e..e.e. .e.e.e.e.e.e.e";
    [middleView addSubview:descLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.centerX, CGRectGetMaxY(goodsView.frame) + 6 * HEIGHTMAKE, 80 * WIDTHMAKE, 40 * HEIGHTMAKE)];
    priceLabel.textColor = COLOR(60, 60, 60, 1.0);
    priceLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    priceLabel.text = @"合计：¥10010";
    [middleView addSubview:priceLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame) + 10 * WIDTHMAKE, priceLabel.y, WIDTHS - CGRectGetMaxX(priceLabel.frame) - 20 * WIDTHMAKE, priceLabel.height)];
    timeLabel.textColor = COLOR(60, 60, 60, 1.0);
    timeLabel.font = [UIFont systemFontOfSize:11 * WIDTHMAKE];
    timeLabel.text = @"2016-01-06 23:59";
    [middleView addSubview:timeLabel];
    
    //line
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame), WIDTHS, 1 * HEIGHTMAKE)];
    secondLine.backgroundColor = COLOR(200, 199, 204, 1.0);
    [view addSubview:secondLine];
    
    //bottomView
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(secondLine.frame), WIDTHS, 40 * HEIGHTMAKE)];
    [view addSubview:bottomView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 2 * WIDTHMAKE;
    button.layer.borderWidth = 1 * WIDTHMAKE;
    button.layer.borderColor = COLOR(192, 192, 194, 1.0).CGColor;
    NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
    norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    norAttr[NSForegroundColorAttributeName] = COLOR(60, 60, 60, 1.0);
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:@"删除订单" attributes:norAttr] forState:UIControlStateNormal];
    button.frame = CGRectMake(WIDTHS - 85 * WIDTHMAKE, (bottomView.height - 27 * HEIGHTMAKE) / 2, 75 * WIDTHMAKE, 27 * HEIGHTMAKE);
    [button addTarget:self action:@selector(assessClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
}


- (void)assessClick
{
    DetailAssessViewController *vc = [[DetailAssessViewController alloc] init];
    [self.window.rootViewController presentViewController:[[YPNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}
@end
