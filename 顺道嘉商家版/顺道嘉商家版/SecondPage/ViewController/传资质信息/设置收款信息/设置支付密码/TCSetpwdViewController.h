//
//  TCSetpwdViewController.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSetpwdViewController : UIViewController
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) BOOL isSetPass;
@property (nonatomic, strong) NSString *titleStr;
//不同页面不同的入口
@property (nonatomic, strong) NSString *entranceTypeStr;//0 从创建店铺流程里面设置密码 1 从财务管理里面修改支付密码 2.从提现输入密码忘记密码3.从添加银行卡 忘记密码 设置进来的 4.从银行卡列表 忘记密码
@end
