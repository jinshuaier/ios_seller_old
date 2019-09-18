//
//  TCSearchGoodsModel.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/5/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSearchGoodsModel.h"

@implementation TCSearchGoodsModel

+(id)searchInfoWithDictionary:(NSDictionary *)dictInfo{
    return [[self alloc] initWithSearchInfoDictionary:dictInfo];
}
- (id)initWithSearchInfoDictionary:(NSDictionary *)dictInfo{
    if (self = [super init]) {
        self.goodsid = [NSString stringWithFormat:@"%@",dictInfo[@"goodsid"]];
        self.goodsname = [NSString stringWithFormat:@"%@",dictInfo[@"name"]];
        self.goodsimage = [NSString stringWithFormat:@"%@",dictInfo[@"src"]];
    }
    return self;
}
@end
