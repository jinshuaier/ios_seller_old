//
//  TCAddressInfo.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/11/2.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressObject.h"

@interface TCAddressInfo : NSObject

+ (instancetype)addressInfoWithDictionary:(NSDictionary *)dictInfo;
@end
