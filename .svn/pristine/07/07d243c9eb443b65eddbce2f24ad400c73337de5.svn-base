//
//  TCFailTableViewCell.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCFailTableViewCell.h"

@implementation TCFailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //用户名  时间
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12 , 12 , 155, 15)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 12, 159, 14)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.textColor = SmallTitleColor;
    [self addSubview:_timeLabel];
    
    _pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 185 - 12,  12, 185, 15)];
    _pricelabel.font = [UIFont systemFontOfSize:15];
    _pricelabel.textAlignment = NSTextAlignmentRight;
    _pricelabel.textColor = RedColor;
    [self addSubview:_pricelabel];

    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 185 - 12,  _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 12, 185, 14)];
    _stateLabel.font = [UIFont systemFontOfSize:14];
    _stateLabel.textAlignment = NSTextAlignmentRight;
    _stateLabel.textColor = FontColor;
    [self addSubview:_stateLabel];
    
   //画条线
    _lineLabel = [[UIView alloc]initWithFrame:CGRectMake(0, _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 12, WIDHT, 1)];
    _lineLabel.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    [self addSubview:_lineLabel];
    
    
    
    _failLabel = [[UILabel alloc]initWithFrame:CGRectMake(12,  _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 25, 60, 14)];
    _failLabel.text = @"失败原因";
    _failLabel.font = [UIFont systemFontOfSize:14];
    _failLabel.textAlignment = NSTextAlignmentLeft;
    _failLabel.textColor = FontColor;
    [self addSubview:_failLabel];
    
    //view
    _resonView = [[UIView alloc]initWithFrame:CGRectMake(_failLabel.frame.origin.x + _failLabel.frame.size.width + 8, _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 25, WIDHT - 16 - 60 - 12, 40)];
    _resonView.backgroundColor = [UIColor colorWithRed:232/255.0 green:236/255.0 blue:237/255.0 alpha:1.0];
    _resonView.layer.cornerRadius = 4;
    [self addSubview: _resonView];
    
    _resonLabel = [[UILabel alloc]init];
    _resonLabel.font = [UIFont systemFontOfSize:12];
    _resonLabel.numberOfLines = 0;//多行显示，计算高度
    _resonLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];

    [_resonView addSubview:_resonLabel];
    [_resonView setFrame:CGRectMake(_failLabel.frame.origin.x + _failLabel.frame.size.width + 8, _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 25, WIDHT - 16 - 60 - 12, _resonLabel.frame.size.height + 16)];
    _height = self.frame.size.height;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
