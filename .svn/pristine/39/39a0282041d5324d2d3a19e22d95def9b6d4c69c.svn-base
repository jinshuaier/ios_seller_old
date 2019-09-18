//
//  TCOrderBalanModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderBalanModel.h"

@implementation TCOrderBalanModel
+ (instancetype)orderBalanInfoWithDictionary:(NSDictionary *)dictInfo{
    
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.orderid = [NSString stringWithFormat:@"%@",dictInfo[@"orderid"]];
        self.ordersn = dictInfo[@"ordersn"];
        self.completeTime = dictInfo[@"completeTime"];
        self.sellerMoney = dictInfo[@"sellerMoney"];
    }
    return self;
}
@end
