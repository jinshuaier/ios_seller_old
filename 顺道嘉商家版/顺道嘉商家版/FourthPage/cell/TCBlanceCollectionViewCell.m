//
//  TCBlanceCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCBlanceCollectionViewCell.h"

@implementation TCBlanceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat x = (WIDHT - 2) / 2 / 2;
    _im = [[UIImageView alloc]initWithFrame:CGRectMake(x - (35 * HEIGHTSCALE / 2), 8, 35 * HEIGHTSCALE, 35 * HEIGHTSCALE)];
    [self addSubview: _im];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, _im.frame.origin.y + _im.frame.size.height + 5, (WIDHT - 2) / 2, 20)];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview: _title];
    // Initialization code
}

@end
