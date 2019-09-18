//
//  TCChooseBankInfo.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChooseBankInfo.h"

@implementation TCChooseBankInfo
+ (id)orderInfoWithDictionary:(NSDictionary *)dictInfo {
    
    return [[self alloc] initWithOrderInfoDictionary:dictInfo];
}

- (id)initWithOrderInfoDictionary:(NSDictionary *)dictInfo{
    self = [super init];
    if (self) {
        self.type = dictInfo[@"type"];
        self.bank = dictInfo[@"bank"];
        self.cardid = dictInfo[@"id"];
        self.last_card_4 = [NSString stringWithFormat:@"%@",dictInfo[@"last_four"]];
    }
    return self;
}
@end
