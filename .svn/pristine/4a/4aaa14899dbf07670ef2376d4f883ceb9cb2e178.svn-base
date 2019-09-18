//
//  TCTopCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/28.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTopCollectionViewCell.h"

@implementation TCTopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _imviews = [[UIView alloc]initWithFrame:CGRectMake(WIDHT / 2 - (90 * HEIGHTSCALE / 2), 20, 90 * HEIGHTSCALE, 90 * HEIGHTSCALE)];
    _imviews.backgroundColor = Color;
    _imviews.layer.cornerRadius = 45 * HEIGHTSCALE;
    _imviews.layer.borderColor = btnColors.CGColor;
    _imviews.layer.borderWidth = 1;
    _imviews.layer.masksToBounds = YES;
    [self addSubview: _imviews];

    _imageviews = [[UIImageView alloc]initWithFrame:CGRectMake(5 * HEIGHTSCALE, 5 * HEIGHTSCALE, 80 * HEIGHTSCALE, 80 * HEIGHTSCALE)];
    _imageviews.layer.cornerRadius = 40 * HEIGHTSCALE;
    _imageviews.backgroundColor = [UIColor whiteColor];
    _imageviews.layer.masksToBounds = YES;
//    _imageviews.image = [UIImage imageNamed:@"shopimage.png"];
    [_imviews addSubview: _imageviews];




    _lbview = [[UIView alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, _imviews.frame.origin.y + _imviews.frame.size.height + 0 * HEIGHTSCALE, WIDHT - 80 * WIDHTSCALE, 60 * HEIGHTSCALE)];
    _lbview.backgroundColor = Color;
    [self addSubview: _lbview];

    _namelb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _lbview.frame.size.width, _lbview.frame.size.height)];
    _namelb.text = @"世纪华联生活购物超市(新华店)";
    _namelb.textAlignment = NSTextAlignmentCenter;
    _namelb.font = [UIFont systemFontOfSize:18];
    _namelb.numberOfLines = 0;
    _namelb.textColor = [UIColor whiteColor];
    [_lbview addSubview: _namelb];

    _pushView = [[UIView alloc]initWithFrame:CGRectMake(WIDHT - 10 * WIDHTSCALE - 10 * HEIGHTSCALE, _lbview.frame.origin.y + (_lbview.frame.size.height / 2 - 10 * HEIGHTSCALE), 10 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
    [self addSubview: _pushView];
    _pushim = [[UIImageView alloc]initWithFrame:_pushView.bounds];
    _pushim.image = [UIImage imageNamed:@"go.png"];
    [_pushView addSubview: _pushim];

    self.backgroundColor = Color;
}

@end
