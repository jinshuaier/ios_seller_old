//
//  TCShopStyleTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopStyleTableViewCell.h"

@implementation TCShopStyleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, WIDHT/2, 15)];
        self.titleLabel.text = @"生活超市";
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.titleLabel.textColor = TCUIColorFromRGB(0x666666);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        
        self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 20, 17.5, 20, 20)];
        self.checkBtn.selected = NO;
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.checkBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 54, WIDHT - 15, 1)];
        line.backgroundColor = TCLineColor;
        [self.contentView addSubview:line];

    }
    return self;
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
