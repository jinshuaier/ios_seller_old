//
//  TCMessNewModel.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMessNewModel : NSObject

@property (nonatomic, strong) NSString *messageid;
@property (nonatomic, strong) NSString *memberid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *orderid;

+ (instancetype)messInfoWithDictionary:(NSDictionary *)dict;


@end
