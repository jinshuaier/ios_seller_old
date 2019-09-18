//
//  TCCardTableViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCardTableViewCell.h"

@implementation TCCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView = [[UIView alloc]initWithFrame:CGRectMake(8, 2, WIDHT - 16, 96 * HEIGHTSCALE)];
    _backView.backgroundColor = Color;
    _backView.layer.cornerRadius = 5;
    [self addSubview: _backView];

    _im = [[UIImageView alloc]initWithFrame:CGRectMake(8, 50 * HEIGHTSCALE - 40 * HEIGHTSCALE, 80 * HEIGHTSCALE, 80 * HEIGHTSCALE)];
    _im.backgroundColor = [UIColor whiteColor];
    _im.layer.cornerRadius = 40 * HEIGHTSCALE;
    [_backView addSubview: _im];

    _lb = [[UILabel alloc]initWithFrame:CGRectMake(_im.frame.origin.x + _im.frame.size.width + 12, _im.frame.origin.y, _backView.frame.size.width - _im.frame.origin.x - _im.frame.size.width - 12 - 10, _im.frame.size.height / 2)];
    _lb.text = @"中国工商银行";
    _lb.font = [UIFont systemFontOfSize:15];
    [_backView addSubview: _lb];

    _num = [[UILabel alloc]initWithFrame:CGRectMake(_lb.frame.origin.x, _lb.frame.size.height + _lb.frame.origin.y, _lb.frame.size.width, _lb.frame.size.height)];
    _num.text = @"21134514567895543";
    _num.font = [UIFont systemFontOfSize:15];
    [_backView addSubview: _num];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
