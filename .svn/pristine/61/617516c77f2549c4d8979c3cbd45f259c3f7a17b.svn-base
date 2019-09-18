//
//  TCSearchgoodsTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/5/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSearchgoodsTableViewCell.h"

@implementation TCSearchgoodsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.goodsimage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 96, 96)];
        [self.contentView addSubview:self.goodsimage];
        
        self.nameLabel = [[UILabel alloc]initWithFrame: CGRectMake(CGRectGetMaxX(self.goodsimage.frame) + 12, 12, WIDHT - 12 - 24 - 96, 22)];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        self.nameLabel.textColor = TCUIColorFromRGB(0x4C4C4C);
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

-(void)setGoodsModel:(TCSearchGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    [self.goodsimage  sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsimage] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",goodsModel.goodsname];
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
