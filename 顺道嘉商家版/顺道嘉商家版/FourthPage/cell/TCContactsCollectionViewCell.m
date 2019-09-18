//
//  TCContactsCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by GeYang on 2016/12/19.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCContactsCollectionViewCell.h"

@implementation TCContactsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 60 * HEIGHTSCALE)];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _title];
}

@end
