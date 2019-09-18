//
//  TCSectionTwoCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSectionTwoCollectionViewCell.h"

@implementation TCSectionTwoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat x = (WIDHT - 2) / 3 / 2;
    _im = [[UIImageView alloc]initWithFrame:CGRectMake(x - (35 * HEIGHTSCALE / 2), 8, 35 * HEIGHTSCALE, 35 * HEIGHTSCALE)];
    [self addSubview: _im];

    _redViews = [[UIView alloc]initWithFrame:CGRectMake(_im.frame.origin.x + _im.frame.size.width - 1, _im.frame.origin.y - 1, 8, 8)];
    _redViews.backgroundColor = [UIColor redColor];
    _redViews.layer.cornerRadius = 4;
    _redViews.hidden = YES;
    [self addSubview: _redViews];

    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, _im.frame.origin.y + _im.frame.size.height + 5, (WIDHT - 2) / 3, 20)];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _title];
}

@end
