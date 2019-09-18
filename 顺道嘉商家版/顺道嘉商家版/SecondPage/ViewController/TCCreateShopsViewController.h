//
//  TCCreateShopsViewController.h
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/9.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCCreateShopsViewController : UIViewController
@property (nonatomic, assign) BOOL isChange;//判断是否进来修改的
@property (nonatomic, strong) NSDictionary *mesDic;//请求获取店铺详情
@property (nonatomic, strong) NSString *shopid;//接收店铺id   修改时用
@property (nonatomic, assign) BOOL loginCome; //从登陆中进来的  创建成功后返回主页

@property (nonatomic, assign) BOOL zhuce; //注册
@property (nonatomic, assign) BOOL chulogin; //初次登录
@property (nonatomic, strong) NSString *enterStr;//入口
@end
