//
//  TCShopCateGoryModel.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCShopCateGoryModel : NSObject

+ (instancetype)shopCateInfogoryWithDictionary:(NSDictionary *)dict;

@property (nonatomic, copy) NSString *shopCategoryID;
@property (nonatomic, copy) NSString *shopCategoryName;
@property (nonatomic, copy) NSString *shopCategoryNum;
@property (nonatomic, copy) NSString *shopcatepagenum;
@property (nonatomic, copy) NSArray *shopCategoryGoodsArr;

@end
