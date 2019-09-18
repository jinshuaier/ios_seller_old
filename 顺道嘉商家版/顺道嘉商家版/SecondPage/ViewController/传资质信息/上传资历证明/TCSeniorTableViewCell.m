//
//  TCSeniorTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSeniorTableViewCell.h"

@implementation TCSeniorTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 135)];
        self.bgImage.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        self.bgImage.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.bgImage];
        
        self.deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        self.deleBtn.clipsToBounds = NO;
        self.deleBtn.center = CGPointMake(232, 8);
        [self.deleBtn setBackgroundImage:[UIImage imageNamed:@"删除图片减号"] forState:(UIControlStateNormal)];
        [self.deleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:self.deleBtn];
        
        UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 240, 35)];
        alphaView.backgroundColor = TCUIColorFromRGB(0x000000);
        alphaView.alpha = 0.6;
        [self.bgImage addSubview:alphaView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 240, 15)];
        label.text = @"点击修改资历证明";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = TCUIColorFromRGB(0xFFFFFF);
        label.textAlignment = NSTextAlignmentCenter;
        [alphaView addSubview:label];

    }
    return self;
}

-(void)clickBtn:(UIButton *)btn{
    [self.delegate didClickDelete:btn];
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
