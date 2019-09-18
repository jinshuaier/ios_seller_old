//
//  TCRightTableViewCell.m
//  shundaojia商家版
//
//  Created by 吕松松 on 2017/12/21.
//  Copyright © 2017年 吕松松. All rights reserved.
//

#import "TCRightTableViewCell.h"

static float kLeftTableViewWidth = 96;
@interface TCRightTableViewCell ()

@property (nonatomic, assign) NSInteger shopCount;
@property (nonatomic, strong) UILabel *countLb;//规格小图标

@end
@implementation TCRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 72, 72)];
        [self.contentView addSubview:self.imageV];
        
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
        
        //添加按钮
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.frame = CGRectMake(WIDHT - kLeftTableViewWidth - 24 - 12, CGRectGetMaxY(_monthSellLabel.frame) + 12, 24, 24);
        [self.addBtn setImage:[UIImage imageNamed:@"加商品"] forState: UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.addBtn];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
