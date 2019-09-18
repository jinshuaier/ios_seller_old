//
//  TCFinaDetTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCFinaDetTableViewCell.h"

@implementation TCFinaDetTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //创建UI
        [self createUI];
    }
    return self;
}

//创建UI
- (void)createUI
{
    self.nameLabel = [UILabel publicLab:@"开心每日用户" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    self.nameLabel.frame = CGRectMake(15, 20, WIDHT/2, 13);
    [self.contentView addSubview:self.nameLabel];
    
    //时间
    self.timeLabel = [UILabel publicLab:@"2017-12-20 24:00" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.nameLabel.frame) + 10, WIDHT/2, 12);
    [self.contentView addSubview:self.timeLabel];
    
    //价格
    self.priceLabel = [UILabel publicLab:@"￥6666.00" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    self.priceLabel.frame = CGRectMake(WIDHT/2, 20, WIDHT/2 - 15 , 13);
    [self.contentView addSubview:self.priceLabel];
    
    //状态
    self.priceSourceLabel = [UILabel publicLab:@"订单收入" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    self.priceSourceLabel.frame = CGRectMake(WIDHT/2, CGRectGetMaxY(self.priceLabel.frame) + 10, WIDHT/2 - 15, 12);
    [self.contentView addSubview:self.priceSourceLabel];
    
    //细线
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(15, CGRectGetMaxY(self.priceSourceLabel.frame) + 20, WIDHT - 30, 1);
    self.lineView.backgroundColor = TCLineColor;
    [self.contentView addSubview:self.lineView];
}

//数据
- (void)setModel:(TCFinaDetModel *)model
{
    _model = model;
    self.nameLabel.text = model.nickname;
    self.timeLabel.text = model.completeTime;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.money];
    self.priceSourceLabel.text = model.typenameStr;
}

@end
