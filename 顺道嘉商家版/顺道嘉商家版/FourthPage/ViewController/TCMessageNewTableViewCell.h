//
//  TCMessageNewTableViewCell.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCMessNewModel.h"

@interface TCMessageNewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *LabelIcon;
@property (nonatomic, strong) UIView *redhotView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *goImage;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) TCMessNewModel *model;

@end
