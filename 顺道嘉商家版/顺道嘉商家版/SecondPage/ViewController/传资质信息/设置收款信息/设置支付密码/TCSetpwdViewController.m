//
//  TCSetpwdViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSetpwdViewController.h"
#import "TCfirstPassViewController.h"

@interface TCSetpwdViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, assign) int Timecount;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *bgckView;

@end

@implementation TCSetpwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    self.mobile = [_userdefault valueForKey:@"userMobile"];

    [self creatUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatUI{
    UILabel *messlabel = [[UILabel alloc]initWithFrame:CGRectMake(15,  30, WIDHT - 30, 15)];
    
    NSString *str = [self.mobile substringWithRange:NSMakeRange(0, 3)];
    NSString *str1 = [self.mobile substringWithRange:NSMakeRange(7, 4)];
    NSString *str2 = [[str stringByAppendingString:@"****"] stringByAppendingString:str1];
    
    messlabel.text = [NSString stringWithFormat:@"请输入手机%@收到的的短信验证码",str2];
    messlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    messlabel.textColor = TCUIColorFromRGB(0x666666);
    messlabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:messlabel];
    UIView *verficationView = [[UIView alloc]initWithFrame:CGRectMake(12 , CGRectGetMaxY(messlabel.frame) + 20, WIDHT - 104 - 40, 45)];
    verficationView.backgroundColor = TCBgColor;
    [self.view addSubview:verficationView];
    
    UILabel *verLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 45, 15)];
    verLabel.text = @"验证码";
    verLabel.textColor = TCUIColorFromRGB(0x666666);
    verLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    verLabel.textAlignment = NSTextAlignmentLeft;
    [verficationView addSubview:verLabel];
    
    UITextField *verField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(verLabel.frame) + 10, 15, WIDHT - 104 - 40 - 30 - 45, 15)];
    verField.delegate = self;
    verField.tag = 3031;
    verField.textAlignment = NSTextAlignmentLeft;
    verField.placeholder = @"请输入验证码";
    verField.textColor = TCUIColorFromRGB(0x333333);
    verField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [verField addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    [verficationView addSubview:verField];
    
    UIButton *verBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 104 , CGRectGetMaxY(messlabel.frame) + 20, 104, 45)];
    verBtn.tag = 1000;
    [verBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [verBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    verBtn.userInteractionEnabled = YES;
    [verBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    verBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [verBtn addTarget:self action:@selector(clickVerfication:) forControlEvents:UIControlEventTouchUpInside];
    verBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:verBtn];
    
    UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(verficationView.frame) + 10, 104, 12)];
    [queBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
    [queBtn setTitle:@"获取不到验证码?" forState:(UIControlStateNormal)];
    [queBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [queBtn addTarget:self action:@selector(clickQues:) forControlEvents:(UIControlEventTouchUpInside)];
    queBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    queBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:queBtn];
    
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(queBtn.frame) + 40, WIDHT - 30, 48)];
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 5;
    [_sureBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [_sureBtn setTitle:@"验证信息" forState:UIControlStateNormal];
    _sureBtn.userInteractionEnabled = NO;
    _sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    _sureBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    _sureBtn.alpha = 0.6;
    [self.view addSubview:_sureBtn];
    
}

-(void) countDownAction{
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    if (_Timecount > 0) {
        //倒计时-1
        _Timecount--;
        btn.userInteractionEnabled = NO;
        [btn setBackgroundColor:TCUIColorFromRGB(0xCCCCCC)];
        [btn setTitle:[NSString stringWithFormat:@"（%d S）",_Timecount] forState:(UIControlStateNormal)];
    }
    
    else if (_Timecount == 0) {
        [btn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        btn.userInteractionEnabled = YES;
        [btn setTitle:@"重发验证码" forState:(UIControlStateNormal)];
        
    }
}

#pragma mark -- UITextFieldDelegate
- (void)alueChange:(UITextField *)textField{
    UITextField *ver_textField = (UITextField *)[self.view viewWithTag:3031];
    if (ver_textField.text.length != 0) {
        [_sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        _sureBtn.alpha = 1;
        _sureBtn.userInteractionEnabled = YES;
    }
    else{
        [_sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        _sureBtn.alpha = 0.6;
        _sureBtn.userInteractionEnabled = NO;
    }
}

#pragma mark -- 问题弹框
-(void)clickQues:(UIButton *)sender{
    [self creatalphaView];
}
-(void)creatalphaView{
    self.bgckView = [[UIView alloc] init];
    self.bgckView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgckView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgckView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 229)];
    contentView.center = CGPointMake(WIDHT/2, HEIGHT/2);
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 10;
    [self.bgckView addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(111, 24, 48, 18)];
    titleLabel.text = @"手机号";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    titleLabel.textColor = TCUIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:titleLabel];
    NSArray *arr = @[@"1.请检查短信是否被手机安全软件拦截",@"2.由于运营商网络原因，可能存在延迟，请耐心等待或重新获取",@"3.获得更多帮助，请联系顺道嘉客服"];
    for (int i = 0; i < arr.count; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(titleLabel.frame) + 10 + 40 * i, 220, 40)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 16)];
        label.text = arr[i];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = TCUIColorFromRGB(0x666666);
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [label sizeThatFits:CGSizeMake(220, MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
        label.frame = CGRectMake(0, 0, 220, size.height);
        [view addSubview:label];
    
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 182, 270, 1)];
    lineView.backgroundColor = TCLineColor;
    [contentView addSubview:lineView];
    

    
    UIButton *knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), 270, 45)];
    [knowBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
    [knowBtn setTitle:@"知道了" forState:(UIControlStateNormal)];
    [knowBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [knowBtn addTarget:self action:@selector(clickKnow:) forControlEvents:(UIControlEventTouchUpInside)];
    knowBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    knowBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:knowBtn];
}

-(void)closeBGView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
}
-(void)clickKnow:(UIButton *)sender{
    [self closeBGView];
}

-(void)clickSure:(UIButton *)sender{
    NSLog(@"验证信息");
    UITextField *code_field = (UITextField *)[self.view viewWithTag:3031];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"mobile":self.mobile,@"mid":mid,@"timestamp":Timestr,@"token":token,@"code":code_field.text,@"type":@"4"};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"mobile":self.mobile,@"mid":mid,@"timestamp":Timestr,@"token":token,@"sign":singStr,@"code":code_field.text,@"type":@"4"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"203002"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
            NSLog(@"进入下一页");
            TCfirstPassViewController *firstVC = [[TCfirstPassViewController alloc]init];
            firstVC.entranceTypeStr = self.entranceTypeStr;
            firstVC.titleStr = @"设置密码";
            [self.navigationController pushViewController:firstVC animated:YES];
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
    [SVProgressHUD dismiss];
}
-(void)clickVerfication:(UIButton *)sender{
    NSLog(@"获取验证码");
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    _Timecount = 60;
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    if (_Timecount > 0) {
        //倒计时-1
        _Timecount--;
        btn.userInteractionEnabled = NO;
        [btn setTitle:[NSString stringWithFormat:@"（%d S）",_Timecount] forState:(UIControlStateNormal)];
        [btn setBackgroundColor:TCUIColorFromRGB(0xCCCCCC)];
    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"mobile":self.mobile,@"type":@"4",@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"mobile":self.mobile,@"timestamp":Timestr,@"type":@"4",@"sign":singStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201002"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@----%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
    [SVProgressHUD dismiss];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITextField *code_field = (UITextField *)[self.view viewWithTag:3031];
    [code_field resignFirstResponder];
}

@end
