//
//  TCRechargeMoneyViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCRechargeMoneyViewController.h"
#import "TCDeviceName.h"
#import "TCGetDeviceId.h"
#import "TCTotalMoneyViewController.h"
@interface TCRechargeMoneyViewController ()
{
    UIButton *agreenButton;
    UITextField *monField;
}
@property (nonatomic, strong) UIView *bgView;

@end

@implementation TCRechargeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"充值";
    
    //创建view
    [self createUI];
    // Do any additional setup after loading the view.
}

//创建view
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    headView.frame = CGRectMake(12, 12, WIDHT - 24, 83);
    [self.view addSubview:headView];
    //label
    UILabel *titlelabel = [UILabel publicLab:@"充值金额" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    titlelabel.frame =CGRectMake(12, 15.5, 60, 14);
    [headView addSubview:titlelabel];
    //人民币的符号
    UILabel *monIconLabel = [UILabel publicLab:@"¥" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:24 numberOfLines:0];
    monIconLabel.frame = CGRectMake(12, CGRectGetMaxY(titlelabel.frame) + 15, 15, 24);
    [headView addSubview:monIconLabel];
    
    //输入框
    monField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(monIconLabel.frame) + 5, CGRectGetMaxY(titlelabel.frame) + 15, WIDHT - 24 - (CGRectGetMaxX(monIconLabel.frame) + 5) - 12, 24)];
    monField.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    monField.textColor = TCUIColorFromRGB(0x333333);
    monField.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    monField.borderStyle = UITextBorderStyleNone;
    [headView addSubview:monField];
    
    //按钮
    agreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agreenButton.frame = CGRectMake(15, CGRectGetMaxY(headView.frame) + 10, 15, 15);
    agreenButton.layer.masksToBounds = YES;
    agreenButton.layer.cornerRadius = 4;
    agreenButton.layer.borderWidth = 1;
    agreenButton.layer.borderColor = TCUIColorFromRGB(0x979797).CGColor;
    [agreenButton setTitle:@"√" forState:UIControlStateSelected];
    [agreenButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:87 / 255.0 blue:0 / 255.0 alpha:1] forState:UIControlStateSelected];
    [agreenButton addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [agreenButton setTitle:nil forState:UIControlStateNormal];
    [self.view addSubview:agreenButton];
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(agreenButton.frame) + 5, CGRectGetMaxY(headView.frame) + 12,WIDHT/2, 12)];
    agreeLabel.text = @"同意《用户服务协议》";
    agreeLabel.font = [UIFont systemFontOfSize:12];
    agreeLabel.textColor = TCUIColorFromRGB(0x333333);
    [self.view addSubview:agreeLabel];
    
    //下一步
    //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(12, CGRectGetMaxY(agreeLabel.frame) + 50, WIDHT - 24, 46);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"下一步" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

#pragma mark -- 下一步
- (void)buttonAction:(UIButton *)sender
{
    
    if (monField.text.length == 0 && [monField.text intValue] <= 0){
        [TCProgressHUD showMessage:@"请输入充值金额"];
    } else {
        if (agreenButton.selected == NO){
            [TCProgressHUD showMessage:@"请同意用户服务协议"];
        } else {
            self.bgView = [[UIView alloc] init];
            self.bgView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
            self.bgView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
            [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
            
            UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapbgView)];
            [self.bgView addGestureRecognizer:tapHead];
            UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT - 167, WIDHT, 167)];
            contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            [self.bgView addSubview:contentView];
            UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 55)];
            topView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            [contentView addSubview:topView];
            
            UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 18, 9, 19)];
            [returnBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:(UIControlStateNormal)];
            [returnBtn addTarget:self action:@selector(clickReturn:) forControlEvents:(UIControlEventTouchUpInside)];
            [topView addSubview:returnBtn];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDHT - 102)/2, 20, 102, 15)];
            titleLabel.text = @"选择充值方式";
            titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            titleLabel.textColor = TCUIColorFromRGB(0x333333);
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [topView addSubview:titleLabel];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 19, WIDHT, 1)];
            line.backgroundColor = TCLineColor;
            [topView addSubview:line];
            
            UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), WIDHT, 112)];
            bgView1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            [contentView addSubview:bgView1];
            NSArray *arr = @[@"微信充值",@"支付宝充值"];
            for (int i = 0; i < arr.count; i++) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i*56, WIDHT, 56)];
                view.tag = 100 + i;
                view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
                [bgView1 addSubview:view];
                
                //加入手势
                if (i == 0) {
                    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWeChat)];
                    [view addGestureRecognizer:tapHead];
                }else{
                    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPay)];
                    [view addGestureRecognizer:tapHead];
                }
                
                
                UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 16, 24, 24)];
                if (i == 0) {
                    iconImage.image = [UIImage imageNamed:@"微信支付"];
                }else{
                    iconImage.image = [UIImage imageNamed:@"支付宝支付"];
                }
                [view addSubview:iconImage];
                
                UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) + 12, 20, 80, 16)];
                textLabel.text = arr[i];
                textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
                textLabel.textColor = TCUIColorFromRGB(0x4C4C4C);
                textLabel.textAlignment = NSTextAlignmentLeft;
                [view addSubview:textLabel];
                
                if (i == 0) {
                    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(48, CGRectGetMaxY(textLabel.frame) + 19, WIDHT - 48, 1)];
                    lineView.backgroundColor = TCLineColor;
                    [view addSubview:lineView];
                }
                
                UIImageView *sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 38 - 5, (56 - 8)/2, 5, 8)];
                sanImage.image = [UIImage imageNamed:@"进入三角"];
                [view addSubview:sanImage];
                
            }
        }
    }
}

#pragma mark -- 关闭充值弹窗
-(void)tapbgView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}

-(void)clickReturn:(UIButton *)sender{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}
-(void)tapWeChat{
    NSLog(@"进入微信充值");
    [self tapbgView];
    [self quest:@"3"];
}

-(void)tapPay{
     NSLog(@"进入支付宝充值");
     [self tapbgView];
    [self quest:@"2"];
}

//支付
- (void)quest:(NSString *)type
{
    [Pingpp setDebugMode:YES];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSDictionary *dic = @{@"money":monField.text,@"source":type,@"deviceid":[TCDeviceName getDeviceName],@"terminal":@"IOS",@"mmdid":[TCGetDeviceId getDeviceId]};
    
    NSString *singStr = [TCServerSecret signStr:dic];
    NSDictionary *parameters = @{@"money":monField.text,@"source":type,@"deviceid":[TCDeviceName getDeviceName],@"terminal":@"IOS",@"mmdid":[TCGetDeviceId getDeviceId],@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201022"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            
            [Pingpp createPayment:jsonDic[@"data"][@"alipay"] appURLScheme:@"shundaojia" withCompletion:^(NSString *result, PingppError *error) {
                if ([result isEqualToString:@"success"]) {
                    [TCProgressHUD showMessage:@"支付成功"];
                    NSString *balancebillsid = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"balancebillsid"]];
                    [self updatastate:balancebillsid];
                    
                }else{
                    [TCProgressHUD showMessage:@"支付失败"];
                }
            }];
        } else {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)updatastate:(NSString *)balancebillsid{
    
    NSDictionary *dic = @{@"balancebillsid":balancebillsid};
    
    NSString *singStr = [TCServerSecret signStr:dic];
    NSDictionary *parameters = @{@"balancebillsid":balancebillsid,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201023"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@%@",jsonStr,jsonDic);
        [TCProgressHUD showMessage:jsonDic[@"msg"]];
        //创建通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"banlance" object:nil];
        //通过通知中心发送通知
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TCTotalMoneyViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark -- 是否同意
- (void)agree:(UIButton *)button {
    button.selected = !button.selected;
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
