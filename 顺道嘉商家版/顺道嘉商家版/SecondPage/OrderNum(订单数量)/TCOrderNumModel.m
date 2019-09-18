//
//  TCOrderNumModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderNumModel.h"

@implementation TCOrderNumModel

+ (instancetype)orderNumInfoWithDictionary:(NSDictionary *)dictInfo{
    
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.orderid = [NSString stringWithFormat:@"%@",dictInfo[@"orderid"]];
        self.ordersn = [NSString stringWithFormat:@"%@",dictInfo[@"ordersn"]];
        self.completeTime = dictInfo[@"completeTime"];
        self.sellerMoney = [NSString stringWithFormat:@"%@",dictInfo[@"sellerMoney"]];
    }
    return self;
}

@end
