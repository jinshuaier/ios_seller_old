//
//  TCActivityManageTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/23.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActivityManageTableViewCell.h"

@implementation TCActivityManageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}
#pragma mark -- 创建视图
-(void)createUI
{
    //头部视图
    self.imageTop = [[UIImageView alloc] init];
    self.imageTop.frame = CGRectMake(12, 16, 40, 40);
    [self addSubview:self.imageTop];
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(self.imageTop.frame.size.width + self.imageTop.frame.origin.x + 12, 16, WIDHT - 12 - 16 - 40 - 24, 16);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = TCUIColorFromRGB(0x525F66);
    self.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    [self addSubview:self.titleLabel];
    //副标题
    self.disLabel = [[UILabel alloc] init];
    self.disLabel.frame = CGRectMake(self.imageTop.frame.size.width + self.imageTop.frame.origin.x + 12, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 8, WIDHT - 12 - 16 - 40 - 24, 12);
    self.disLabel.textAlignment = NSTextAlignmentLeft;
    self.disLabel.textColor = TCUIColorFromRGB(0x999999);
    self.disLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:12];
    [self addSubview:self.disLabel];
    //箭头
    self.imageArrow = [[UIImageView alloc] init];
    self.imageArrow.frame = CGRectMake(WIDHT - 13 - 7, 30.6, 7, 11.8);
    self.imageArrow.image = [UIImage imageNamed:@"进入图标.png"];
    [self addSubview:self.imageArrow];
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
