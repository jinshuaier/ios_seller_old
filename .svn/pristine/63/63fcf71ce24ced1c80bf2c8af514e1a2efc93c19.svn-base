//
//  TCNoMessageView.m
//  ShunDaoJia
//
//  Created by 胡高广 on 2017/12/21.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "TCNoMessageView.h"

@implementation TCNoMessageView

- (instancetype)initWithFrame:(CGRect)frame AndImage:(NSString *)image AndLabel:(NSString *)disLabel andButton:(NSString *)clickBtn
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = TCBgColor;
        //搭建UI
        [self setUpUI:image AndLabel:disLabel AndButton:clickBtn];
    }
    return self;
}

//搭建view
- (void)setUpUI:(NSString *)image AndLabel:(NSString *)disLabel AndButton:(NSString *)clickBtn
{
    self.plImage = [[UIImageView alloc] init];
    self.plImage.image = [UIImage imageNamed:image];
    self.plImage.frame = CGRectMake((WIDHT - 176)/2, 132, 176, 88);
    [self addSubview:self.plImage];
    
    //文字
    self.plLabel = [UILabel publicLab:disLabel textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    self.plLabel.frame = CGRectMake(0, CGRectGetMaxY(self.plImage.frame) + 8, WIDHT, 20);
    [self addSubview:self.plLabel];
    
    //button
    self.plButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.plButton setTitle:clickBtn forState:UIControlStateNormal];
    [self.plButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.plButton.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    self.plButton.layer.cornerRadius = 4;
    self.plButton.layer.masksToBounds = YES;
    [self.plButton addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    self.plButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.plButton.frame = CGRectMake((WIDHT - 120)/2, CGRectGetMaxY(self.plLabel.frame) + 20, 120, 36);
    [self addSubview:self.plButton];
}

#pragma mark -- 点击事件
- (void)click:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(reloadData)]) {
        [self.delegate  reloadData];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
