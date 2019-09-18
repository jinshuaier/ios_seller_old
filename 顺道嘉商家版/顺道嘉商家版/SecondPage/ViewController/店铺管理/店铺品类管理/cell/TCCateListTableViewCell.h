//
//  TCCateListTableViewCell.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/9/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TMSwipeCell.h"
#import "TCCateList.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCCateListTableViewCell : TMSwipeCell
@property (nonatomic, strong) UILabel *nameLabel; //品类的名称
@property (nonatomic, strong) UIView *lineView; //下划线
@property (nonatomic, strong) UILabel *sortLabel; //品类的序号

@property (nonatomic, strong) TCCateList *model;
@end

NS_ASSUME_NONNULL_END
