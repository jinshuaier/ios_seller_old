//
//  TCGoodsNumTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCGoodsNumTableViewCell.h"

@implementation TCGoodsNumTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.backgroundColor = ViewColor;
    }
    return self;
}

//创建视图的view
-(void)createUI
{
    //主view
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor redColor];
    self.backView.frame = CGRectMake(10, 0, WIDHT - 20, 212);
    [self.contentView addSubview:self.backView];
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
