//
//  TCTotalMoneyViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTotalMoneyViewController.h"
#import "TCRechargeMoneyViewController.h" //充值
#import "TCWithdrawMoneyViewController.h" //提现

@interface TCTotalMoneyViewController ()
@property (nonatomic, strong)NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UIView *mainView;


@end

@implementation TCTotalMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户总金额";
    self.view.backgroundColor = TCBgColor;
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(banlance) name:@"banlance" object:nil];
    
    [self quest];
    
    // Do any additional setup after loading the view.
}

//充值成功
- (void)banlance
{
    [self quest];
}

#pragma mark -- 请求余额的接口
- (void)quest
{
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userDefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userDefaults valueForKey:@"userToken"]];
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
  
    NSString *singStr = [TCServerSecret loginStr:dicc];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201025"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            NSLog(@"%@",jsonDic);
            self.dic = jsonDic;
            
            if (self.mainView) {
                [self.mainView removeFromSuperview];
                //创建View
                [self createUI];
            } else {
                //创建View
                [self createUI];
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
}


//创建View
- (void)createUI
{
    self.mainView = [[UIView alloc] init];
    self.mainView.frame = self.view.frame;
    self.mainView.backgroundColor = TCBgColor;
    self.mainView.userInteractionEnabled = YES;
    [self.view addSubview:self.mainView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.frame = CGRectMake((WIDHT - 60)/2, 66, 60, 57);
    iconImage.image = [UIImage imageNamed:@"当前剩余额度"];
    [self.mainView addSubview:iconImage];
    //当前余额的label
    UILabel *titleLabel = [UILabel publicLab:@"当前余额" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Semibold" size:15 numberOfLines:0];
    titleLabel.frame = CGRectMake(0, CGRectGetMaxY(iconImage.frame) + 27, WIDHT, 13);
    [self.mainView addSubview:titleLabel];
    //金额
    UILabel *priceLabel = [UILabel publicLab:self.dic[@"data"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:36 numberOfLines:0];
    priceLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 15, WIDHT, 36);
    [self.mainView addSubview:priceLabel];
    
    //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15, CGRectGetMaxY(priceLabel.frame) + 82, WIDHT - 30, 45);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"充值" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mainView addSubview:button];
    
    //提现
    UIButton *button_tixian = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button_tixian.frame = CGRectMake(15, CGRectGetMaxY(button.frame) + 20, WIDHT - 30, 45);
    button_tixian.layer.cornerRadius = 5;
    button_tixian.layer.masksToBounds = YES;
    [button_tixian setTitleColor:TCUIColorFromRGB(0x333333) forState:(UIControlStateNormal)];
    [button_tixian setTitle:@"提现" forState:(UIControlStateNormal)];
    button_tixian.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    button_tixian.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [button_tixian addTarget:self action:@selector(button_tixianAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mainView addSubview:button_tixian];
    
    //常见问题
    UILabel *queLabel = [UILabel publicLab:@"常见问题" textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    queLabel.frame = CGRectMake(0, HEIGHT - 20 - 13 - 64, WIDHT, 13);
    queLabel.userInteractionEnabled = YES;
    [self.mainView addSubview:queLabel];
    //手势
    UITapGestureRecognizer *queTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(queTap)];
    [queLabel addGestureRecognizer:queTap];
}

#pragma mark -- 充值
- (void)buttonAction:(UIButton *)sender
{
    TCRechargeMoneyViewController *rechargeVC = [[TCRechargeMoneyViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)button_tixianAction:(UIButton *)sender
{
    TCWithdrawMoneyViewController *withdrawVC = [[TCWithdrawMoneyViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    withdrawVC.banlanceStr = self.dic[@"data"];
    [self.navigationController pushViewController:withdrawVC animated:YES];
}

- (void)queTap
{
    NSLog(@"常见问题");
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
