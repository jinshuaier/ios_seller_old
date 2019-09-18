//
//  TCShopsTableViewCell.h
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/23.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCShopsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopimageviews;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *guige;
@property (weak, nonatomic) IBOutlet UIButton *bianji;
@property (weak, nonatomic) IBOutlet UIButton *select;
@property (weak, nonatomic) IBOutlet UILabel *kucun;

@end
