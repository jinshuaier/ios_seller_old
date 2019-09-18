//
//  TCSetetTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSetetTableViewCell.h"

@implementation TCSetetTableViewCell

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
    self.titleLabel = [UILabel publicLab:@"消息设置提醒" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    self.titleLabel.frame = CGRectMake(15, 0, 100, 45);
    [self addSubview:self.titleLabel];
    
    //三角
    self.goImage = [[UIImageView alloc] init];
    self.goImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
    self.goImage.frame = CGRectMake(WIDHT - 15 - 5, (45 - 8)/2, 5, 8);
    [self addSubview:self.goImage];
    
    //线
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(12, 44, WIDHT - 12, 1);
    self.lineView.backgroundColor = TCBgColor;
    [self addSubview:self.lineView];
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
