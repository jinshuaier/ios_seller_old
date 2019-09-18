//
//  TCChooseBankCell.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCChooseBankInfo.h"
@interface TCChooseBankCell : UITableViewCell
@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) TCChooseBankInfo*model;
@end
