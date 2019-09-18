//
//  TCOffLineTableViewCell.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/24.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOffLineTableViewCell.h"

@interface TCOffLineTableViewCell()
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) UIImageView *stateImage; //状态的View
@property (nonatomic, strong) UILabel *titleLabel; //标题的文字
@property (nonatomic, strong) UILabel *timeLabel; //活动的天数
@property (nonatomic, strong) UIButton *changeBtn; //修改活动的按钮
@property (nonatomic, strong) UILabel *stateLabel; //状态的文字
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation TCOffLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.backgroundColor = NEWMAINCOLOR;
    }
    return self;
}

//创建视图的view
-(void)createUI
{
    //主view
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = TCUIColorFromRGB(0x24A7F2);
    self.backView.frame = CGRectMake(12, 0, WIDHT - 24, 256);
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    //状态图
    self.stateImage = [[UIImageView alloc] init];
    self.stateImage.frame = CGRectMake(0, 0, 63, 63);
    self.stateImage.image = [UIImage imageNamed:@"线下活动的三角"];
    [self.backView addSubview:self.stateImage];
    //状态的文字
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.frame = CGRectMake(0, 0, 43.8, 43.8);
    //活动中
    self.stateLabel.text =@"活动中";
    self.stateLabel.textColor = TCUIColorFromRGB(0x24A7F2);
    //审核
//    self.stateLabel.text =@"审核中";
//    self.stateLabel.textColor = TCUIColorFromRGB(0x16A200);
    //未进行
//    self.stateLabel.text =@"审核中";
//    self.stateLabel.textColor = TCUIColorFromRGB(0x999999);
    self.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.stateLabel.transform = CGAffineTransformMakeRotation(-M_PI*45/180);
    [self.stateImage addSubview:self.stateLabel];
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(62, 24, self.backView.frame.size.width - 62 - 18, 60);
    self.titleLabel.text = @"满30减10，满60减30，满30减10，满60减30";
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:22];
    self.titleLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.titleLabel.numberOfLines = 0;
    CGSize titlesize = [self.titleLabel sizeThatFits:CGSizeMake(self.backView.frame.size.width - 62 - 18, MAXFLOAT)];
    self.titleLabel.frame = CGRectMake(62, 24, titlesize.width, titlesize.height);
    [self.backView addSubview:self.titleLabel];
    //活动时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.frame = CGRectMake(0, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 24, self.backView.frame.size.width, 22);
    self.timeLabel.text = @"活动时间：7天";
    self.timeLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.timeLabel];
    //修改活动的按钮
    self.changeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.changeBtn.frame = CGRectMake(64, self.timeLabel.frame.size.height + self.timeLabel.frame.origin.y + 40.5, self.backView.frame.size.width - 128, 44);
    [self.changeBtn setTitle:@"修改活动" forState:(UIControlStateNormal)];
    [self.changeBtn addTarget:self action:@selector(chanBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.changeBtn.layer.cornerRadius = 22;
    self.changeBtn.layer.masksToBounds = YES;
    self.changeBtn.layer.borderWidth = 2;
    //这是审核和进行的颜色，不可点击
    [self.changeBtn setTitleColor:[TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5] forState:(UIControlStateNormal)];
    self.changeBtn.layer.borderColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5].CGColor;
    [self.backView addSubview:self.changeBtn];
    //获取cell的高度
    _cellHeight = _backView.frame.size.height ;
}

//加载数据
-(void)loadData:(id)data
{
    self.model = data;
    self.titleLabel.text = _model.content;
    CGSize titlesize = [self.titleLabel sizeThatFits:CGSizeMake(self.backView.frame.size.width - 62 - 18, MAXFLOAT)];
    self.titleLabel.frame = CGRectMake(62, 24, titlesize.width, titlesize.height);
    self.timeLabel.frame = CGRectMake(0, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 24, self.backView.frame.size.width, 22);
    self.changeBtn.frame = CGRectMake(64, self.timeLabel.frame.size.height + self.timeLabel.frame.origin.y + 40.5, self.backView.frame.size.width - 128, 44);
    self.backView.frame = CGRectMake(12, 0, WIDHT - 24, self.changeBtn.frame.origin.y + self.changeBtn.frame.size.height + 41.5);
    //model的高
    _model.cellHight = _backView.frame.size.height;
    //从网络上获取的时间
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *timeStr = _model.endTime;
    NSDate *dataNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取当前时间时间戳
    long int curTime = (long)[dataNow timeIntervalSince1970];
    NSDate *overDate = [formatter dateFromString: timeStr];
    long int overTime = (long)[overDate timeIntervalSince1970];
    
    NSLog(@"-- %ld -- %ld",curTime,overTime);
    //两个日期的差
    long int timeDice = overTime - curTime;
    NSLog(@"%ld",timeDice);
    //在审核
    if([_model.status isEqualToString:@"0"]){
        self.stateLabel.text =@"审核中";
        self.stateLabel.textColor = TCUIColorFromRGB(0x16A200);
        [self.changeBtn setTitleColor:[TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5] forState:(UIControlStateNormal)];
        self.changeBtn.layer.borderColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5].CGColor;
        [self.changeBtn setTitle:@"正在审核中" forState:(UIControlStateNormal)];
        self.changeBtn.userInteractionEnabled = NO;
    }else if ([_model.status isEqualToString:@"1"] && timeDice > 0){
        //已通过
        self.stateLabel.text =@"活动中";
        self.stateLabel.textColor = TCUIColorFromRGB(0x24A7F2);
        [self.changeBtn setTitleColor:[TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5] forState:(UIControlStateNormal)];
        self.changeBtn.layer.borderColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.5].CGColor;
         [self.changeBtn setTitle:@"活动进行中" forState:(UIControlStateNormal)];
        self.changeBtn.userInteractionEnabled = NO;
    }else if ([_model.status isEqualToString:@"-1"]){
        //未通过
        self.stateLabel.text =@"未通过";
        self.stateLabel.textColor = TCUIColorFromRGB(0x999999);
        [self.changeBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
         self.changeBtn.layer.borderColor = TCUIColorFromRGB(0xFFFFFF).CGColor;
         self.changeBtn.userInteractionEnabled = YES;
    }else if ([_model.status isEqualToString:@"0"] && timeDice < 0){
        self.stateLabel.text =@"已结束";
        self.stateLabel.textColor = TCUIColorFromRGB(0x999999);
        [self.changeBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
        self.changeBtn.layer.borderColor = TCUIColorFromRGB(0xFFFFFF).CGColor;
        self.changeBtn.userInteractionEnabled = YES;
    }
}
#pragma mark -- 修改活动的点击事件
-(void)chanBtn:(UIButton *)sender
{
    //发送页面通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeActity" object:nil userInfo:@{@"content":self.model.content}];
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
