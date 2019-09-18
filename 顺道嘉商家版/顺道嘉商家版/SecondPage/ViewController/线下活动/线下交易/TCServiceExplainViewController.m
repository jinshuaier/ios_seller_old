//
//  TCServiceExplainViewController.m
//  商家版线下活动付款
//
//  Created by 胡高广 on 2017/5/26.
//  Copyright © 2017年 胡高广. All rights reserved.
//

#import "TCServiceExplainViewController.h"

@interface TCServiceExplainViewController ()

@end

@implementation TCServiceExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    //顶部返回
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, WIDHT, 64);
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"扫码返回按钮"] forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(5, 18, 48.1, 48.1);
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backBtn];
    //标题
    UILabel *navTitleLabel = [[UILabel alloc] init];
    navTitleLabel.frame = CGRectMake(0, 33, WIDHT, 18);
    navTitleLabel.text = @"服务费说明";
    navTitleLabel.textColor = TCUIColorFromRGB(0x525F66);
    navTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:navTitleLabel];
    //说明的View
    UIView *explainView = [[UIView alloc] init];
    explainView.frame = CGRectMake(0, navTitleLabel.frame.size.height + navTitleLabel.frame.origin.y + 25, WIDHT, 140);
    explainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:explainView];
    //说明的文字
    UILabel *explainLabel = [[UILabel alloc] init];
    explainLabel.frame = CGRectMake(12, 16, WIDHT - 24, 87);
    explainLabel.text = @"除商超外的其他店铺顺道嘉均需收取每笔订单金额的5%为其平台服务费";
    explainLabel.textColor = TCUIColorFromRGB(0x666666);
    explainLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    explainLabel.numberOfLines = 0;
    CGSize titlesize = [explainLabel sizeThatFits:CGSizeMake(WIDHT - 24, MAXFLOAT)];
    explainLabel.frame = CGRectMake(12, 16, titlesize.width, titlesize.height);
    explainView.frame = CGRectMake(0, navTitleLabel.frame.size.height + navTitleLabel.frame.origin.y + 25, WIDHT, explainLabel.frame.size.height + 32);
    [explainView addSubview:explainLabel];
    // Do any additional setup after loading the view.
}
#pragma mark -- 返回
-(void)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
