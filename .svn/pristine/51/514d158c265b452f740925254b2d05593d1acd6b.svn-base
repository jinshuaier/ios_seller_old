//
//  TCActivewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActivewCell.h"

@implementation TCActivewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        NSArray *arr = @[@"活动名称:",@"消费方式:",@"优惠方式:",@"开始时间:",@"结束时间:"];
        for (int i = 0; i < arr.count; i ++) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,45*i, WIDHT, 45)];
            view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            [self.contentView addSubview:view];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT/2 - 15, 15)];
            label.text = arr[i];
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = TCUIColorFromRGB(0x666666);
            label.textAlignment = NSTextAlignmentLeft;
            [view addSubview:label];
            
            UILabel *specLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT/2, 15, WIDHT/2 - 15, 15)];
            specLabel.text = @"(暂定为满多少减多少)";
            specLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            specLabel.textColor = TCUIColorFromRGB(0x333333);
            specLabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:specLabel];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 44, WIDHT - 15, 1)];
            line.backgroundColor = TCLineColor;
            [view addSubview:line];
            
            if (i == 0) {
                self.nameLabel = label;
                self.name = specLabel;
            }else if (i == 1){
                self.condotionLabel = label;
                self.condition = specLabel;
            }else if (i == 2){
                self.disLabel = label;
                self.discount = specLabel;
            }else if (i == 3){
                self.startLabel = label;
                self.starttime = specLabel;
            }else if(i == 4){
                self.endLabel = label;
                self.endtime = specLabel;
            }
        }
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
