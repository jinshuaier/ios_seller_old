//
//  TCShopCateGoryModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopCateGoryModel.h"
#import "TCShopGoodsModel.h"

@implementation TCShopCateGoryModel

+(instancetype)shopCateInfogoryWithDictionary:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.shopCategoryID = [NSString stringWithFormat:@"%@", dict[@"goodscateid"]];
        self.shopCategoryName = [NSString stringWithFormat:@"%@", dict[@"name"]];
        self.shopCategoryNum = [NSString stringWithFormat:@"%@", dict[@"goodscount"]];
        self.shopcatepagenum = [NSString stringWithFormat:@"%@",dict[@"pagenum"]];
        
//        NSMutableArray *shopMuArr = [NSMutableArray array];
//        NSArray *arr = dict[@"goods"];
//        for (NSDictionary *dic in arr) {
//            TCShopGoodsModel *shopModel = [TCShopGoodsModel shopInfoWithDictionary:dic];
//            [shopMuArr addObject:shopModel];
//        }
//        self.shopCategoryGoodsArr = shopMuArr;
    }
    return self;
}

@end
