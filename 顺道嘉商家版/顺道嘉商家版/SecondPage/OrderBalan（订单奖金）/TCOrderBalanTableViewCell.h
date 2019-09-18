//
//  TCOrderBalanTableViewCell.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCOrderBalanModel.h"
@interface TCOrderBalanTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *orderNumberLabel; //订单编号
@property (nonatomic, strong) UILabel *orderTimeLabel; //订单时间
@property (nonatomic, strong) UILabel *orderMoneyLabel; //订单金额
@property (nonatomic, strong) UIImageView *triangleImage; //进入的三角
@property (nonatomic, strong) UIView *lineView; //下划线
@property (nonatomic, strong) TCOrderBalanModel *model;
@end
