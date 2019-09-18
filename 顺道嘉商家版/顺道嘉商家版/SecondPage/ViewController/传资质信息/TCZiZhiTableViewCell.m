//
//  TCZiZhiTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCZiZhiTableViewCell.h"

@implementation TCZiZhiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, WIDHT/2, 15)];
        self.topLabel.text = @"营业执照";
        self.topLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.topLabel.textColor = TCUIColorFromRGB(0x333333);
        [self.contentView addSubview:self.topLabel];
        
        self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 30 - 40, 21, 40, 13)];
        self.stateLabel.text = @"待填写";
        self.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        self.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        self.stateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.stateLabel];
        
        self.sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.stateLabel.frame) + 10, 24, 5, 8)];
        self.sanImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
        [self.contentView addSubview:self.sanImage];
        
        self.grayView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.topLabel.frame) + 10, WIDHT - 30, 48)];
        self.grayView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
        [self.contentView addSubview:self.grayView];
        
        self.teLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, WIDHT - 50, 18)];
        self.teLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        self.teLabel.textColor = TCUIColorFromRGB(0x999E9C);
        self.teLabel.textAlignment = NSTextAlignmentLeft;
        self.teLabel.text = @"无营业执照商家需上传特许经营证";
        [self.grayView addSubview:self.teLabel];
        
//        self.teLabel.numberOfLines = 0;
//        self.teLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = [self.teLabel sizeThatFits:CGSizeMake(WIDHT - 50, MAXFLOAT)];
//        self.teLabel.frame = CGRectMake(10, 15, WIDHT - 50, size.height);
        
        

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
