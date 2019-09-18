//
//  TCShopGoodsModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopGoodsModel.h"

@implementation TCShopGoodsModel

+ (instancetype)shopInfoWithDictionary:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.shopGoodsID = [NSString stringWithFormat:@"%@", dict[@"goodsid"]];
        self.shopName = [NSString stringWithFormat:@"%@", dict[@"name"]];
        self.shopPrice = [NSString stringWithFormat:@"%@", dict[@"price"]];
        self.shopStockTotal = [NSString stringWithFormat:@"%@", dict[@"stockTotal"]];
        self.shopSrcThumbs = [NSString stringWithFormat:@"%@", dict[@"src"]];
        self.sort = [NSString stringWithFormat:@"%@", dict[@"sort"]];

    }
    return self;
}

@end
