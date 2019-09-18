//
//  TCMyshopCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/2.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMyshopCollectionViewCell.h"

@implementation TCMyshopCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.contentView.frame.size.width - 26)/2, 20, 26, 26)];
        self.iconImage.image = [UIImage imageNamed:@"商家学院"];
        [self.contentView addSubview:self.iconImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImage.frame) + 12, self.contentView.frame.size.width, 13)];
        self.titleLabel.text = @"店铺分享";
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        self.titleLabel.textColor = TCUIColorFromRGB(0x333333);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
@end
