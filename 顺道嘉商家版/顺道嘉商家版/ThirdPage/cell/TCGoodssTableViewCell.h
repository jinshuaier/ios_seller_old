//
//  TCGoodssTableViewCell.h
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/22.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCGoodssTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageviews;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *dianzhang;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@end
