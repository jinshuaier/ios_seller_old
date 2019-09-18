//
//  TCLookDeposit.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/6/15.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLookDeposit.h"

@implementation TCLookDeposit

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

+ (instancetype)ModelWithDictionary:(NSDictionary *)dictionary{
    TCLookDeposit *models = [[TCLookDeposit alloc]init];
    [models setValuesForKeysWithDictionary:dictionary];
    return models;
}

@end
