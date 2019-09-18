//
//  TCRightGoodsViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCRightGoodsViewCell.h"

static float kLeftTableViewWidth = 96;

@implementation TCRightGoodsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 72, 72)];
        [self.contentView addSubview:self.imageV];
        
        self.sortImage = [[UIImageView alloc] init];
        self.sortImage.frame = CGRectMake(0, 0, 31, 17);
        self.sortImage.image = [UIImage imageNamed:@"sort"];
        [self.contentView addSubview:self.sortImage];
        
        self.sortLabel = [UILabel publicLab:@"0" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:10 numberOfLines:0];
        self.sortLabel.frame = self.sortImage.frame;
        [self.sortImage addSubview:self.sortLabel];
        
        self.nameLabel = [UILabel publicLab:@"浪琴牌手表瑞士直供" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 8, 8, WIDHT - kLeftTableViewWidth - 12 - (CGRectGetMaxX(self.imageV.frame) + 8), 15);
        
        CGSize size = [self.nameLabel sizeThatFits:CGSizeMake(self.contentView.frame.size.width - 12 - (CGRectGetMaxX(self.imageV.frame) + 8), MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 8, 8, WIDHT - kLeftTableViewWidth - 12 - (CGRectGetMaxX(self.imageV.frame) + 8), size.height);
        [self.contentView addSubview:self.nameLabel];
        //月售
        self.monthSellLabel = [UILabel publicLab:@"月售45单" textColor:TCUIColorFromRGB(0x808080) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
        self.monthSellLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 8, CGRectGetMaxY(self.nameLabel.frame) + 4, WIDHT - kLeftTableViewWidth - 12 - (CGRectGetMaxX(self.imageV.frame) + 8), 16);
        [self.contentView addSubview:self.monthSellLabel];
        //价格
        self.priceLabel = [UILabel publicLab:@"¥ 9" textColor:TCUIColorFromRGB(0xFF3355) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangTC-Semibold" size:18 numberOfLines:0];
        self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 8, CGRectGetMaxY(self.monthSellLabel.frame) + 13, 100, 22);
        [self.contentView addSubview:self.priceLabel];
        
        //未选择的小框
        self.noSelecBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.noSelecBtn.frame = CGRectMake(WIDHT - 15 - 20 - kLeftTableViewWidth, CGRectGetMaxY(self.nameLabel.frame) + 26, 20, 20);
        [self.noSelecBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
        [self.noSelecBtn setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:(UIControlStateSelected)];
        [self.noSelecBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.noSelecBtn.selected = self.isSelected;
        [self.contentView addSubview:self.noSelecBtn];
        
    }
    return self;
}

- (void)setModel:(TCShopGoodsModel *)model
{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.shopSrcThumbs] placeholderImage:[UIImage imageNamed:@"占位图（方形）"]];
    self.nameLabel.text = model.shopName;
    self.monthSellLabel.text = model.shopStockTotal;
    self.priceLabel.text = model.shopPrice;
    self.noSelecBtn.selected = self.isSelected;
    self.sortLabel.text = model.sort;
}

//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    self.noSelecBtn.selected = !self.noSelecBtn.selected;
    if (self.cartBlock) {
        self.cartBlock(self.noSelecBtn.selected);
    }
}

@end
