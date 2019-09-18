//
//  TCBankCardInfo.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCBankCardInfo.h"

@implementation TCBankCardInfo
+ (id)orderInfoWithDictionary:(NSDictionary *)dictInfo {
    
    return [[self alloc] initWithOrderInfoDictionary:dictInfo];
}

- (id)initWithOrderInfoDictionary:(NSDictionary *)dictInfo{
    if (self = [super init]) {
        self.ID = dictInfo[@"id"];
        self.type = dictInfo[@"type"];
        self.cardno = dictInfo[@"cardno"];
        self.bank = dictInfo[@"bank"];
        self.bankCode = dictInfo[@"bankCode"];
        self.last_four = dictInfo[@"last_four"];
    }
    return self;
}
@end

