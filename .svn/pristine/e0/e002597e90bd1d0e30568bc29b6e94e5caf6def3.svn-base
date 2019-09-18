//
//  TCRechargeTerViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCRechargeTerViewController.h"

@interface TCRechargeTerViewController ()

@end

@implementation TCRechargeTerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"充值保证金";
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56*WIDHTSCALE, 17)];
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"说明" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    //创建view
    [self createUI];
    // Do any additional setup after loading the view.
}

//创建View
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, WIDHT, 112);
    headView.backgroundColor = TCNavColor;
    [self.view addSubview:headView];
    //保证金的标蓝
    UILabel *titleLabel = [UILabel publicLab:@"充值保证金金额" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:13 numberOfLines:0];
    titleLabel.frame = CGRectMake(20, 15, WIDHT/2, 13);
    [headView addSubview:titleLabel];
    //详情
    UILabel *disLabel = [UILabel publicLab:@"(充值前请和服务人员进行确认)" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:11 numberOfLines:0];
    disLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 5, WIDHT/2, 13);
    [headView addSubview:disLabel];
    //金额
    UILabel *priceLabel = [UILabel publicLab:@"￥10000.00" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Semibold" size:36 numberOfLines:0];
    priceLabel.frame = CGRectMake(15, CGRectGetMaxY(disLabel.frame) + 15, WIDHT - 30, 36);
    [headView addSubview:priceLabel];
    
    //服务编码
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    codeView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame) + 10, WIDHT, 53);
    [self.view addSubview:codeView];
    //文字
    UILabel *codeLabel = [UILabel publicLab:@"服务人员编码：12113321" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    codeLabel.frame = CGRectMake(15, 0, WIDHT - 30, 53);
    [codeView addSubview:codeLabel];
    
    //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15, CGRectGetMaxY(codeView.frame) + 173, WIDHT - 30, 45);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"提交保证金" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

#pragma mark -- 提交保证金
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"提交保证金");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- barButtonItemPressed
- (void)barButtonItemPressed:(UIButton *)sender
{
    NSLog(@"说明");
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
