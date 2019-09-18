//
//  TCSeniorTableViewCell.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol seniorcellDelegate <NSObject>

@optional
-(void)didClickDelete:(UIButton *)button;

@end
@interface TCSeniorTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, weak) id<seniorcellDelegate>delegate;
@end
