//
//  TCRightTableViewCell.h
//  shundaojia商家版
//
//  Created by 吕松松 on 2017/12/21.
//  Copyright © 2017年 吕松松. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FoodModel;
#define kCellIdentifier_Right @"RightTableViewCell"
@interface TCRightTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^reloadData)(void);
@property (nonatomic, copy) void(^addOrCutReloadData)(void);
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *monthSellLabel; //月售
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addBtn; //添加按钮
@property (nonatomic, strong) UILabel *numLabel; //数量
@property (nonatomic, strong) UIButton *cutBtn; //减号按钮
@property (nonatomic, strong) UIButton *selectSort; //选规格

@end
