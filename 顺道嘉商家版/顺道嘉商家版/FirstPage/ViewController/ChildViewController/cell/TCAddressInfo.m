//
//  TCAddressInfo.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/11/2.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddressInfo.h"

@interface TCAddressInfo()

@property (nonatomic, copy) NSString *addressAdd;
@property (nonatomic, copy) NSString *addressMobile;
@property (nonatomic, copy) NSString *addressName;

@end

@implementation TCAddressInfo

+ (instancetype)addressInfoWithDictionary:(NSDictionary *)dictInfo {
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.addressAdd = dictInfo[@"address"];
        self.addressMobile = dictInfo[@"mobile"];
        self.addressName = dictInfo[@"name"];
    }
    return self;
}

@end
