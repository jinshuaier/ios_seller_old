//
//  TCLookDepositCell.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCLookDeposit.h"
@interface TCLookDepositCell : UITableViewCell
@property (nonatomic, weak) TCLookDeposit *model;
- (void)loadData:(id)data;//加载数据
@end
