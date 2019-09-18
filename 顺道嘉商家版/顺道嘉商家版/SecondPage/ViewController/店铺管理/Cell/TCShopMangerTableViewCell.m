//
//  TCShopMangerTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopMangerTableViewCell.h"

@implementation TCShopMangerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, WIDHT/2, 15)];
        _topLabel.text = @"店铺管理介绍";
        _topLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.textColor = TCUIColorFromRGB(0x333333);
        [self.contentView addSubview:_topLabel];
        
        _grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_topLabel.frame) + 10, WIDHT - 50, 12)];
        _grayLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _grayLabel.textColor = TCUIColorFromRGB(0x999C9E);
        _grayLabel.textAlignment = NSTextAlignmentLeft;
        _grayLabel.text = @"店铺介绍管理可修改内容为店铺名称、联系人等";
        [self.contentView addSubview:_grayLabel];
        
        _sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 - 5, 35, 5, 8)];
        _sanImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
        [self.contentView addSubview:_sanImage];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 15 - 45, 35, 45, 14)];
        _stateLabel.text = @"审核中";
        _stateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _stateLabel.textColor = TCUIColorFromRGB(0xFF5544);
        _stateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_stateLabel];
        _stateLabel.hidden = YES;

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
