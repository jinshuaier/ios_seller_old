//
//  TCChooseBankInfo.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCChooseBankInfo : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *last_card_4;
@property (nonatomic, strong) NSString *cardid;
+ (id)orderInfoWithDictionary:(NSDictionary *)dictInfo;
@end
