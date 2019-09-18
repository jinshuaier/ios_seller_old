//
//  TCFailTableViewCell.h
//  顺道嘉商家版
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCFailTableViewCell : UITableViewCell
@property  (nonatomic, strong)UILabel *titleLabel;
@property  (nonatomic, strong)UILabel *pricelabel;
@property  (nonatomic, strong)UILabel *timeLabel;
@property  (nonatomic, strong)UILabel *stateLabel;
@property  (nonatomic, strong)UILabel *failLabel;
@property  (nonatomic, strong)UIView *lineLabel;
@property  (nonatomic, strong)UIView *resonView;
@property  (nonatomic, strong)UILabel *resonLabel;
@property (nonatomic,  assign) CGFloat height;

@end
