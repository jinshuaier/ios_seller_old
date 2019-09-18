//
//  TCOrderEvlModel.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderEvlModel.h"

@implementation TCOrderEvlModel
+ (instancetype)orderEvlInfoWithDictionary:(NSDictionary *)dictInfo{
    
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.idStr = [NSString stringWithFormat:@"%@",dictInfo[@"id"]];
        self.nickname = dictInfo[@"nickname"];
        self.createTime = dictInfo[@"createTime"];
        self.score = [NSString stringWithFormat:@"%@",dictInfo[@"score"]];
    }
    return self;
}
@end
