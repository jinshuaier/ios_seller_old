//
//  TCLookDepositCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLookDepositCell.h"
@interface TCLookDepositCell()
@property (nonatomic, strong) UIView *backView; //
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UILabel *moneyLabel; //金钱的文字
@property (nonatomic, strong) UILabel *rechargeLabel; //充值的文字
@property (nonatomic, strong) UILabel *freezeLabel; //冻结的文字

@end

@implementation TCLookDepositCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    //背景
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 112)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview: _backView];
    
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(12, 16, WIDHT, 22);
    self.titleLabel.text = @"保证金：";
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.titleLabel.textColor = TCUIColorFromRGB(0x4C4C4C);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:self.titleLabel];
    
    //钱数
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.frame = CGRectMake(12, CGRectGetMaxY(self.titleLabel.frame) + 16,  25 + 103, 42);
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",@"900"];
    self.moneyLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    self.moneyLabel.textColor = TCUIColorFromRGB(0x24A7F2);
    self.moneyLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:self.moneyLabel];
    
    //充值时间
    self.rechargeLabel = [[UILabel alloc] init];
    self.rechargeLabel.frame = CGRectMake(WIDHT - 12 - 192, 54, 192, 17);
    self.rechargeLabel.text = [NSString stringWithFormat:@"充值时间：%@",@"2017-06-12 12:30:30"];
    self.rechargeLabel.textColor = TCUIColorFromRGB(0x999999);
    self.rechargeLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.rechargeLabel.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.rechargeLabel];
    
    //冻结时间
    self.freezeLabel = [[UILabel alloc] init];
    self.freezeLabel.frame = CGRectMake(WIDHT - 12 - 192, CGRectGetMaxY(self.rechargeLabel.frame) + 8, 192, 17);
    self.freezeLabel.text = [NSString stringWithFormat:@"充值时间：%@",@"2017-06-12 12:30:30"];
    self.freezeLabel.textColor = TCUIColorFromRGB(0x999999);
    self.freezeLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.freezeLabel.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.freezeLabel];
}
//加载数据
-(void)loadData:(id)data
{
    self.model = data;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:",self.model.title];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.model.money];
    self.rechargeLabel.text = [NSString stringWithFormat:@"充值时间：%@",self.model.createTime];
    self.freezeLabel.text = [NSString stringWithFormat:@"冻结时间：%@",self.model.endTime];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
