//
//  TCListCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/11/1.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCListCell.h"

@interface TCListCell()
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) UILabel *stateTypeLabel; //订单的类型
@property (nonatomic, strong) UILabel *stateLabel; //状态的label
@property (nonatomic, strong) UILabel *deliveryLabel; //送达时间
@property (nonatomic, strong) UILabel *ordelTimeLabel; //订单时间
@property (nonatomic, strong) UIView *lineView_one; //下划线
@property (nonatomic, strong) UILabel *nameLabel; //姓名
@property (nonatomic, strong) UILabel *addressLabel; //收货地址
@property (nonatomic, strong) UIButton *phoneBtn; //电话的按钮
@property (nonatomic, strong) UIView *lineView_two;
@property (nonatomic, strong) UILabel *priceLabel; //价格label

@end

@implementation TCListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.backgroundColor = ViewColor;
    }
    return self;
}

//创建视图的view
-(void)createUI
{
    //主view
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.frame = CGRectMake(10, 0, WIDHT - 20, 212);
    [self.contentView addSubview:self.backView];
    
    //订单的类型
    self.stateTypeLabel = [UILabel publicLab:@"速送订单" textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
    self.stateTypeLabel.frame = CGRectMake(10, 15, WIDHT/2, 14);
    [self.backView addSubview:self.stateTypeLabel];
    //订单的状态
    self.stateLabel = [UILabel publicLab:@"待接单" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    self.stateLabel.frame = CGRectMake( WIDHT - 20 - CGRectGetMaxX(self.stateTypeLabel.frame), 14, WIDHT/2, 14);
    [self.backView addSubview:self.stateLabel];
    //送达的时间
    self.deliveryLabel = [UILabel publicLab:@"18:00之前送达" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    self.deliveryLabel.frame = CGRectMake(10, CGRectGetMaxY(self.stateTypeLabel.frame) + 10, WIDHT/2, 12);
    [self.backView addSubview:self.deliveryLabel];
    //订单时间
    self.ordelTimeLabel = [UILabel publicLab:@"2017-10-31  09:27" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    self.ordelTimeLabel.frame = CGRectMake(WIDHT - WIDHT/2 - 20 - 10, CGRectGetMaxY(self.stateLabel.frame) + 10, WIDHT/2, 12);
    [self.backView addSubview:self.ordelTimeLabel];
    //下划线
    self.lineView_one = [[UIView alloc] init];
    self.lineView_one.backgroundColor = TCLineColor;
    self.lineView_one.frame = CGRectMake(10, CGRectGetMaxY(self.deliveryLabel.frame) + 14, WIDHT - 20 - 20, 1);
    [self.backView addSubview:self.lineView_one];
    //姓名
    self.nameLabel = [UILabel publicLab:@"张先生" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    self.nameLabel.frame = CGRectMake(12, CGRectGetMaxY(self.lineView_one.frame) + 20, WIDHT - 20 - 12, 15);
    [self.backView addSubview:self.nameLabel];
    //地址信息
    self.addressLabel = [UILabel publicLab:@"这是收货地址这是收货地址这是收货地址这是收货地址这是收货地址这是地址...." textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    self.addressLabel.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame) + 10, WIDHT - 20 - 10 - 70, 36);
    [self.backView addSubview:self.addressLabel];
    //电话的图标
    self.phoneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.phoneBtn.frame = CGRectMake(CGRectGetMaxX(self.addressLabel.frame) + 20, CGRectGetMaxY(self.nameLabel.frame) + 6, 40, 40);
    [self.phoneBtn setBackgroundImage:[UIImage imageNamed:@"打电话图标"] forState:(UIControlStateNormal)];
    [self.phoneBtn addTarget:self action:@selector(phoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:self.phoneBtn];
    //下划线
    self.lineView_two = [[UIView alloc] init];
    self.lineView_two.backgroundColor = TCLineColor;
    self.lineView_two.frame = CGRectMake(10, CGRectGetMaxY(self.addressLabel.frame) + 19, WIDHT - 20 - 20, 1);
    [self.backView addSubview:self.lineView_two];
    //本单的金额
    self.priceLabel = [UILabel publicLab:@"￥90.00" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    self.priceLabel.frame = CGRectMake(0, CGRectGetMaxY(self.lineView_two.frame) + 15, WIDHT - 20 - 12, 15);
    [self.backView addSubview:self.priceLabel];

    self.backView.frame = CGRectMake(10, 0, WIDHT - 20, CGRectGetMaxY(self.priceLabel.frame) + 15);
}

#pragma mark -- 获取数据
- (void)setModel:(TCNewOrderModel *)model
{
    _model = model;
    self.stateTypeLabel.text = model.deliverName;
    self.stateLabel.text = model.statusName;
    self.deliveryLabel.text = [NSString stringWithFormat:@"%@",model.sendTime];
    self.ordelTimeLabel.text = model.createTime;
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address; //高度
    CGSize size = [self.addressLabel sizeThatFits:CGSizeMake(WIDHT - 20, MAXFLOAT)];
    self.addressLabel.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame) + 10, WIDHT - 20 - 10 - 70, size.height);
    self.phoneBtn.frame = CGRectMake(CGRectGetMaxX(self.addressLabel.frame) + 20, CGRectGetMaxY(self.nameLabel.frame) + 6, 40, 40);

    self.lineView_two.frame = CGRectMake(10, CGRectGetMaxY(self.addressLabel.frame) + 19, WIDHT - 20 - 20, 1);
     self.priceLabel.frame = CGRectMake(0, CGRectGetMaxY(self.lineView_two.frame) + 15, WIDHT - 20 - 12, 15);
    NSString *str = [NSString stringWithFormat:@"本单金额：¥%@",model.price];
    self.priceLabel.text = str;
    [self fuwenbenLabel:self.priceLabel FontNumber:[UIFont fontWithName:@"PingFangSC-Medium" size:16] AndRange:NSMakeRange(5, str.length - 5) AndColor:TCUIColorFromRGB(0xFF5544)];
    self.backView.frame = CGRectMake(10, 0, WIDHT - 20, CGRectGetMaxY(self.priceLabel.frame) + 15);
    model.cellHight = CGRectGetMaxY(self.backView.frame);
}

//设置不同字体颜色
-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    labell.attributedText = str;
}
#pragma mark -- 打电话
- (void)phoneAction:(UIButton *)sender
{
    NSLog(@"打电话");
    //拨打电话
    NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.mobile];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


@end
