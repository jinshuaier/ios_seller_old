//
//  TCMessNewModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMessNewModel.h"

@implementation TCMessNewModel
+ (instancetype)messInfoWithDictionary:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
       
        self.messageid = [NSString stringWithFormat:@"%@",dict[@"messageid"]];
        self.memberid = [NSString stringWithFormat:@"%@",dict[@"memberid"]];
        self.title = dict[@"title"];
        self.content = dict[@"content"];
        self.type = [NSString stringWithFormat:@"%@",dict[@"type"]];
        self.createTime = dict[@"createTime"];
        self.url = dict[@"url"];
        self.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
        self.orderid = [NSString stringWithFormat:@"%@",dict[@"orderid"]];
    }
    return self;
}

@end
