//
//  TCSearchgoodsTableViewCell.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/5/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCSearchGoodsModel.h"
@interface TCSearchgoodsTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *goodsimage;
@property (nonatomic, strong) TCSearchGoodsModel *goodsModel;
@end
