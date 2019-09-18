//
//  TCLookTermInaViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLookTermInaViewController.h"

@interface TCLookTermInaViewController ()

@end

@implementation TCLookTermInaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"查看保证金";
    
    //创建View
    [self createUI];
    // Do any additional setup after loading the view.
}

//创建view
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(15, 10, WIDHT - 30, 165);
    headView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:headView];
    
    //状态
    NSArray *titleArr = @[@"支付时间：",@"使用时间：",@"支付方式：",@"支付方式：",@"使用状态："];
    NSArray *disArr = @[@"2017-11-22",@"2017-11-22至2018-11-21",@"余额支付",@"3000",@"正常使用"];
    for (int i = 0; i < titleArr.count; i ++) {
        UILabel *titleLable = [UILabel publicLab:titleArr[i] textColor:TCUIColorFromRGB(0x454545) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        titleLable.frame = CGRectMake(26, 25 + (15+10)*i, 80, 15);
        [headView addSubview:titleLable];
        
        //详情
        UILabel *disLable = [UILabel publicLab:disArr[i] textColor:TCUIColorFromRGB(0x454545) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        disLable.frame = CGRectMake(CGRectGetMaxX(titleLable.frame), 25 + (15+10)*i, WIDHT - 30 - CGRectGetMaxX(titleLable.frame) , 15);
        [headView addSubview:disLable];
    }
    
    //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15, CGRectGetMaxY(headView.frame) + 50, WIDHT - 30, 45);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"申请转出" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    /******************  状态不一样，显示不一样 *********************/
    UILabel *staLabel = [UILabel publicLab:@"您的申请以提交，等待XX小时后自动到账" textColor:TCUIColorFromRGB(0x454545) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
    staLabel.hidden = YES;
    staLabel.frame = CGRectMake(0, 0, WIDHT, 164);
    [headView addSubview:staLabel];
    
}

#pragma mark -- buttonAction
- (void)buttonAction:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"申请转出保证金后，平台需先将终端机收回，终端机确保无误后返还您全部保证金" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"暂不退款" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定退款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定退款");
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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
