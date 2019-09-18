//
//  TCShopGoodsModel.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCShopGoodsModel : NSObject

@property (nonatomic, copy) NSString *shopGoodsID;

@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopPrice;
@property (nonatomic, copy) NSString *shopStockTotal;//库存
@property (nonatomic, copy) NSString *shopSrcThumbs;
@property (nonatomic, copy) NSString *sort;


+ (instancetype)shopInfoWithDictionary:(NSDictionary *)dict;

@end
