//
//  TCChongZhiBZJViewController.h
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/16.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^commitAgain)(void);

@interface TCChongZhiBZJViewController : UIViewController
@property (nonatomic, assign) BOOL isChongzhi;//判断是否充值页面进入
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, copy) commitAgain again;
@property (nonatomic, strong) NSString *maxmoney;//最大充值数
@end
