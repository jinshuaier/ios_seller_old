//
//  TCShopsTableViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/23.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopsTableViewCell.h"

@implementation TCShopsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _shopname.font = [UIFont boldSystemFontOfSize:14];
    _money.textColor = TCUIColorFromRGB(0xDC1414);
    _money.font = [UIFont boldSystemFontOfSize:16];
    
    _shopimageviews.layer.cornerRadius = 5;
    _shopimageviews.layer.masksToBounds = YES;
    _bianji.layer.cornerRadius = 3;
    _bianji.layer.borderWidth = 0.5;
    _bianji.layer.masksToBounds = YES;
    _bianji.layer.borderColor = Color.CGColor;
    _bianji.userInteractionEnabled = NO;
    [_bianji setTitleColor:Color forState:UIControlStateNormal];
}



@end
