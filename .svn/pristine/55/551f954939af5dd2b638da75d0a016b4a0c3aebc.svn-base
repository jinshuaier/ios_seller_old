//
//  TCOffLine.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/25.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOffLine.h"

@implementation TCOffLine
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

+ (instancetype)ModelWithDictionary:(NSDictionary *)dictionary{
    TCOffLine *models = [[TCOffLine alloc]init];
    [models setValuesForKeysWithDictionary:dictionary];
    return models;
}
@end
