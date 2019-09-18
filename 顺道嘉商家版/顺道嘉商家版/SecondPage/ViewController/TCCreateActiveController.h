//
//  TCCreateActiveController.h
//  顺道嘉商家版
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"
@interface TCCreateActiveController : UIViewController
@property (strong,nonatomic) DatePickerView *datePickerView;
@property (strong,nonatomic) NSString *contentStr; //修改过来的内容
@property (strong,nonatomic) NSString *beginTimeStr;//开始的时间
@property (strong,nonatomic) NSString *finshTimeStr; //结束的时间
@property (strong,nonatomic) NSString *activeId; //修改传过来的店铺活动的id
@property (strong,nonatomic) NSString *manMoneyStr; //满的金额
@property (strong,nonatomic) NSString *cutMoneyStr; //减的金额
@property (assign,nonatomic) BOOL ischange; //判断是否改变


@end
