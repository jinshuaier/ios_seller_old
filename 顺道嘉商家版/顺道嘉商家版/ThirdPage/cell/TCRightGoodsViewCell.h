//
//  TCRightGoodsViewCell.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCShopGoodsModel.h"

//声明Block
typedef void(^HggCartBlock)(BOOL select);


@interface TCRightGoodsViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *monthSellLabel; //月售
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *noSelecBtn; //未选择
@property (nonatomic, strong) UIImageView *sortImage; //排序的View
@property (nonatomic, strong) UILabel *sortLabel; //排序的label

@property (nonatomic,assign)  BOOL isSelected; //是否被选中
//声明block
@property (nonatomic, copy) HggCartBlock cartBlock;

@property (nonatomic, strong) TCShopGoodsModel *model;


@end
