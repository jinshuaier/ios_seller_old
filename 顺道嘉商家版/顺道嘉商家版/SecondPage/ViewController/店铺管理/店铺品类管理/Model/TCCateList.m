//
//  TCCateList.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCateList.h"

@implementation TCCateList

+ (instancetype)cateListInfoWithDictionary:(NSDictionary *)dictInfo{
    
    if (!dictInfo) {
        return nil;
    }
    return [[self alloc] initWithDictionary:dictInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    if (self = [super init]) {
        self.name = [NSString stringWithFormat:@"%@",dictInfo[@"name"]];
        self.goodscateid = [NSString stringWithFormat:@"%@",dictInfo[@"goodscateid"]];
        self.sort = [NSString stringWithFormat:@"%@",dictInfo[@"sort"]];
    }
    return self;
}
@end
