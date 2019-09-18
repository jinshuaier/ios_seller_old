//
//  TCAddAssistantController.h
//  顺道嘉商家版
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAddAssistantController : UIViewController
@property (nonatomic, strong)NSString *idStr; //用户id
@property (nonatomic, strong) NSString *shopID; //店铺id
@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) NSString *name; //姓名
@property (nonatomic, strong) NSString *phoneNum; // 店员手机号
@property (nonatomic, strong) NSString *passWord; //登录密码
@property (nonatomic, strong) NSString *role; //角色
@property (nonatomic, strong) NSString *shopName; //所在店铺
@property (nonatomic, strong) NSString *endle; //是否被启用
@end
