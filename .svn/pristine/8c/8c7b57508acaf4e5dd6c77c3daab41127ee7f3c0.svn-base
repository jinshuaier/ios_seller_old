//
//  TCOrderBalanTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderBalanTableViewCell.h"

@implementation TCOrderBalanTableViewCell

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
    //订单的编号
    self.orderNumberLabel = [UILabel publicLab:@"123456789" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    self.orderNumberLabel.frame = CGRectMake(0, 0, WIDHT/3, 53);
    [self addSubview:self.orderNumberLabel];
    
    //订单的时间
    self.orderTimeLabel = [UILabel publicLab:@"2017-12-20 24：00" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    self.orderTimeLabel.frame = CGRectMake(WIDHT/3, 0, WIDHT/3, 53);
    [self addSubview:self.orderTimeLabel];
    
    //订单的金额
    self.orderMoneyLabel = [UILabel publicLab:@"￥6666.00" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    self.orderMoneyLabel.frame = CGRectMake(WIDHT/3*2, 0, WIDHT/3, 53);
    [self addSubview:self.orderMoneyLabel];
    
    //进入的三角
    self.triangleImage = [[UIImageView alloc] init];
    self.triangleImage.image = [UIImage imageNamed:@"ggo"];
    self.triangleImage.frame = CGRectMake(WIDHT - 15 - 5, (53 - 8)/2, 5, 8);
    [self addSubview:self.triangleImage];
    
    //下划线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = TCLineColor;
    self.lineView.frame = CGRectMake(15, 53, WIDHT - 30, 1);
    [self addSubview:self.lineView];
}

//获取数据
- (void)setModel:(TCOrderBalanModel *)model
{
    _model = model;
    self.orderNumberLabel.text = model.ordersn;
    self.orderTimeLabel.text = model.completeTime;
    self.orderMoneyLabel.text = model.sellerMoney;
}

@end
