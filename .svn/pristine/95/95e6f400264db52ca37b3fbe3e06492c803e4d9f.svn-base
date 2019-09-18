//
//  TCNewOrderModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNewOrderModel.h"

@implementation TCNewOrderModel
+ (instancetype)orderInfoWithDictionary:(NSDictionary *)dictInfo {
    
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        NSString *addressStr = [NSString stringWithFormat:@"%@",dictInfo[@"address"]];
        if ([addressStr isEqualToString:@"0"]){
            self.address = addressStr;
        } else {
            self.address = [dictInfo[@"address"][@"locaddress"] stringByAppendingString:dictInfo[@"address"][@"address"]];
            self.addressID = [NSString stringWithFormat:@"%@",dictInfo[@"address"][@"id"]];
            self.name = dictInfo[@"address"][@"name"];
            self.mobile = dictInfo[@"address"][@"mobile"];
        }
       
        self.createTime = dictInfo[@"createTime"];
        self.typeStr = [NSString stringWithFormat:@"%@",dictInfo[@"type"]];
        self.deliverName = dictInfo[@"deliverName"];
        self.deliverType = [NSString stringWithFormat:@"%@",dictInfo[@"deliverType"]];
        self.orderid = [NSString stringWithFormat:@"%@",dictInfo[@"orderid"]];
        self.payTime = dictInfo[@"payTime"];
        self.price = dictInfo[@"price"];
        self.sendTime = dictInfo[@"sendTime"];
        self.shopid = [NSString stringWithFormat:@"%@",dictInfo[@"shopid"]];
        self.status = [NSString stringWithFormat:@"%@",dictInfo[@"status"]];
        self.statusName = dictInfo[@"statusName"];
    }
    return self;
}
@end
