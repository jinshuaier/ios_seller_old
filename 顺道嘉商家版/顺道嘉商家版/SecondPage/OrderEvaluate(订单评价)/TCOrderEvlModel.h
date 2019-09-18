//
//  TCOrderEvlModel.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCOrderEvlModel : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *score;

+ (instancetype)orderEvlInfoWithDictionary:(NSDictionary *)dictInfo;
@end
