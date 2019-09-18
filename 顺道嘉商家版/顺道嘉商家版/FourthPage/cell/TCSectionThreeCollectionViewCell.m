//
//  TCSectionThreeCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSectionThreeCollectionViewCell.h"

@implementation TCSectionThreeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _im = [[UIImageView alloc]initWithFrame:CGRectMake(8, (25 / 2) * HEIGHTSCALE, 35 * HEIGHTSCALE, 35 * HEIGHTSCALE)];
    [self addSubview: _im];

    _title = [[UILabel alloc]initWithFrame:CGRectMake(_im.frame.origin.x + _im.frame.size.width + 20 * WIDHTSCALE, _im.frame.origin.y, WIDHT - 8 - 20 * HEIGHTSCALE - 35 * WIDHTSCALE - 40 * WIDHTSCALE, 35 * HEIGHTSCALE)];
    _title.font = [UIFont systemFontOfSize:18];
    [self addSubview: _title];


    _im2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 12 * WIDHTSCALE - 10 * WIDHTSCALE, (_title.frame.origin.y + 10 * HEIGHTSCALE), 10 * WIDHTSCALE, 20 * HEIGHTSCALE)];
    _im2.image = [UIImage imageNamed:@"ggo.png"];
    [self addSubview: _im2];
}

@end
