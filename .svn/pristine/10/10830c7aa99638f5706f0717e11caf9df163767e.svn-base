//
//  TCMessageDetileViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/3/2.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMessageDetileViewController.h"

@interface TCMessageDetileViewController (){
     NSUserDefaults *userDefaults;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation TCMessageDetileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = TCBgColor;
    userDefaults = [NSUserDefaults standardUserDefaults];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WIDHT - 20, 160)];
    backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,15,WIDHT - 20, 16)];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.titleLabel.textColor = TCUIColorFromRGB(0x4C4C4C);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = self.titleStr;
    [backView addSubview:self.titleLabel];
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.textLabel.textColor = TCUIColorFromRGB(0x999999);
    self.textLabel.text = self.content;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [self.textLabel sizeThatFits:CGSizeMake(WIDHT - 40, size.height)];
    self.textLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame) + 10, WIDHT - 40, size.height);
    [backView addSubview:self.textLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 10 - 15 - 200, CGRectGetMaxY(self.textLabel.frame) + 20, 200, 12)];
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = TCUIColorFromRGB(0x999999);
    self.timeLabel.text = self.timeStr;
    [backView addSubview:self.timeLabel];
    
    backView.frame = CGRectMake(10, 10, WIDHT - 20, CGRectGetMaxY(self.timeLabel.frame) + 15);
    [self.view addSubview:backView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
