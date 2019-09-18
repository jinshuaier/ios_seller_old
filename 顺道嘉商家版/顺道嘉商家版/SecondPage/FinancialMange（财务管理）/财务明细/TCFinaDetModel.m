//
//  TCFinaDetModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCFinaDetModel.h"

@implementation TCFinaDetModel
+ (instancetype)orderFinaInfoWithDictionary:(NSDictionary *)dictInfo{
    
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.balancebillsid = [NSString stringWithFormat:@"%@",dictInfo[@"balancebillsid"]];
        self.money = [NSString stringWithFormat:@"%@",dictInfo[@"money"]];
        self.type = [NSString stringWithFormat:@"%@",dictInfo[@"type"]];
        self.completeTime = dictInfo[@"completeTime"];
        self.nickname = dictInfo[@"nickname"];
        self.typenameStr = dictInfo[@"typename"];
    }
    return self;
}
@end
