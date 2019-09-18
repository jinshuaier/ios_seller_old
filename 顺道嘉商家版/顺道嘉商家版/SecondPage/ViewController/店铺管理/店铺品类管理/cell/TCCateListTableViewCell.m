//
//  TCCateListTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/9/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCateListTableViewCell.h"

@implementation TCCateListTableViewCell

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
    //品类名称
    self.nameLabel = [UILabel publicLab:@"" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    self.nameLabel.frame = CGRectMake(15, 0, WIDHT - 30, 59);
    [self.contentView addSubview:self.nameLabel];
    
    self.sortLabel = [UILabel publicLab:@"" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
    self.sortLabel.frame = CGRectMake(15, 0, WIDHT - 30, 59);
    [self.contentView addSubview:self.sortLabel];
    
    //下划线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = TCUIColorFromRGB(0xEDEDED);
    self.lineView.frame = CGRectMake(15, 59, WIDHT - 15, 1);
    [self.contentView addSubview:self.lineView];
}

//数据
- (void)setModel:(TCCateList *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    self.sortLabel.text = model.sort;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
