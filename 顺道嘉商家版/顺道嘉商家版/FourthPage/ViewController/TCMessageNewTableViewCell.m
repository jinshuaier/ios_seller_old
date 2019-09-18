//
//  TCMessageNewTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMessageNewTableViewCell.h"

@implementation TCMessageNewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //图的icon
        self.LabelIcon = [UILabel publicLab:@"订" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Semibold" size:14 numberOfLines:0];
        self.LabelIcon.frame = CGRectMake(15, 20, 24, 24);
        self.LabelIcon.layer.cornerRadius = 5;
        self.LabelIcon.layer.masksToBounds = YES;
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x53C3C3);
        [self.contentView addSubview:self.LabelIcon];
        
        //小红点
        self.redhotView = [[UIView alloc] init];
        self.redhotView.frame = CGRectMake(CGRectGetMaxX(self.LabelIcon.frame) - 3, self.LabelIcon.frame.origin.y - 3, 6, 6);
        self.redhotView.layer.cornerRadius = 3;
        self.redhotView.layer.masksToBounds = YES;
        self.redhotView.backgroundColor = TCUIColorFromRGB(0xFF5544);
        [self.contentView addSubview:self.redhotView];
        
        //内容
        self.messageLabel = [UILabel publicLab:@"您的订单2017**********888，尚未…" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
        self.messageLabel.frame = CGRectMake(CGRectGetMaxX(self.LabelIcon.frame) + 10, 20, WIDHT - (CGRectGetMaxX(self.LabelIcon.frame) + 10) - 30, 15);
        [self.contentView addSubview:self.messageLabel];
        
        //进入的小图标
        self.goImage = [[UIImageView alloc] init];
        self.goImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
        self.goImage.frame = CGRectMake(CGRectGetMaxX(self.messageLabel.frame) + 10, 23, 5, 8);
        [self.contentView addSubview:self.goImage];
        
        //时间
        self.timeLabel = [UILabel publicLab:@"2017-12-20  20：30" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
        self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.LabelIcon.frame) + 10, CGRectGetMaxY(self.messageLabel.frame) + 10, WIDHT - (CGRectGetMaxX(self.LabelIcon.frame) + 10), 13);
        [self.contentView addSubview:self.timeLabel];
        
        //线
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(CGRectGetMaxX(self.LabelIcon.frame) + 10, CGRectGetMaxY(self.timeLabel.frame) + 20, WIDHT - (CGRectGetMaxX(self.LabelIcon.frame) + 10), 1);
        self.lineView.backgroundColor = TCBgColor;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

//数据
- (void)setModel:(TCMessNewModel *)model
{
    _model = model;
    
    //未读和已读
    if ([model.status isEqualToString:@"0"]){
        self.redhotView.hidden = NO;
    } else if ([model.status isEqualToString:@"1"]){
        self.redhotView.hidden = YES;
    }
    
    //
    self.messageLabel.text = model.content;
    self.timeLabel.text = model.createTime;
    
    //状态
    if ([model.type isEqualToString:@"0"]){
        self.LabelIcon.text = @"系";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x93C2C2);
        
    } else if ([model.type isEqualToString:@"1"]){
        self.LabelIcon.text = @"活";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0xE068C2);
        
    } else if ([model.type isEqualToString:@"2"]){
        self.LabelIcon.text = @"帐";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0xFFAA00);
        
    } else if ([model.type isEqualToString:@"3"]){
        self.LabelIcon.text = @"优";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x93C2C2);
        
    } else if ([model.type isEqualToString:@"4"]){
        self.LabelIcon.text = @"订";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x53C3C3);
        
    } else if ([model.type isEqualToString:@"5"]){
        self.LabelIcon.text = @"店";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x53C3C3);
        
    } else if ([model.type isEqualToString:@"6"]){
        self.LabelIcon.text = @"催";
        self.LabelIcon.backgroundColor = TCUIColorFromRGB(0x93C2C2);
    }
}


@end
