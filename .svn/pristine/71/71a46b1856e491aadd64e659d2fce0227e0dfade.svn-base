//
//  TCOrderInfo.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/11/2.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderInfo.h"
#import "TCAddressInfo.h"
@interface TCOrderInfo ()

@property (nonatomic, copy) NSString *orderCompleteTime;
@property (nonatomic, copy) NSString *orderCreateTime;
@property (nonatomic, copy) NSString *orderDeliverType;
@property (nonatomic, copy) NSString *orderDiscount;
@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *orderMID;
@property (nonatomic, copy) NSString *orderOrderSN;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderQCode;
@property (nonatomic, copy) NSString *orderRemark;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *orderTill;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, strong) TCAddressInfo *orderAddress;
@property (nonatomic, assign) CGFloat cellHight;

@end

@implementation TCOrderInfo
+ (instancetype)orderInfoWithDictionary:(NSDictionary *)dictInfo {
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.orderCompleteTime = dictInfo[@"completeTime"];
        self.orderCreateTime = dictInfo[@"createTime"];
        
        id deliverType = dictInfo[@"deliverType"];
        self.orderDeliverType = deliverType? [NSString stringWithFormat:@"%@", deliverType] : @"";
        
        id discount = dictInfo[@"discount"];
        self.orderDiscount = discount? [NSString stringWithFormat:@"%@", discount] : @"";
        
        self.orderID = dictInfo[@"id"];
        self.orderMID = dictInfo[@"mid"];
        self.orderOrderSN = dictInfo[@"ordersn"];
        
        id price = dictInfo[@"price"];
        self.orderPrice = price? [NSString stringWithFormat:@"%@", price] : @"";
        
        self.orderQCode = dictInfo[@"qrcode"];
        self.orderRemark = dictInfo[@"remark"];
        
        id status = dictInfo[@"status"];
        self.orderStatus = status? [NSString stringWithFormat:@"%@", status] : @"";
        
        self.orderTill = dictInfo[@"till"];
        
        id type = dictInfo[@"type"];
        self.orderType = type? [NSString stringWithFormat:@"%@", type] : @"";
        
        TCAddressInfo *info = [TCAddressInfo addressInfoWithDictionary:dictInfo[@"address"]];
        self.orderAddress = info;
    }
    return self;
}



@end
