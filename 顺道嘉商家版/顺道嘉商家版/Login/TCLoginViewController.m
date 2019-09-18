//
//  TCLoginViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/7/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLoginViewController.h"
#import "TCTabBarViewController.h"
#import "TCChangeViewController.h"
#import "TCCreateShopsViewController.h"
#import "TCSJTJViewController.h"
#import "TCMyMesViewController.h"

#import "TCRegisterViewController.h" //注册

#import "TCShopManagerViewController.h" //店铺列表

#import "TCShopsManaerViewController.h" //商品列表

#import "TCUpdateView.h"

@interface TCLoginViewController ()<UITextFieldDelegate>
{
    NSTimer *timer;
}
@property (nonatomic, strong) UIImageView *mainimageview;
@property (nonatomic, strong) UITextField *usetf;
@property (nonatomic, strong) UITextField *secrettf;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *eyebtn;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSString *pushID; //推送的id
@property (nonatomic, strong) NSDictionary *paramter;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSDictionary *mesDic;
@property (nonatomic, strong) UIView *defeatView;
@property (nonatomic, strong) UIButton *obtainBtn;
@property (nonatomic, assign) int Timecount;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, strong) NSString *currentVersion;

@end

@implementation TCLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha = 0;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TCUIColorFromRGB(0x5BBFBE);
    self.userdefault = [NSUserDefaults standardUserDefaults];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 83)/2 , 120, 83 , 70)];
    iconImage.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:iconImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDHT - 96)/2 , CGRectGetMaxY(iconImage.frame) + 12, 96, 22)];
    titleLabel.text = @"顺道嘉商家端";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake((WIDHT - 275)/2, CGRectGetMaxY(titleLabel.frame) + 45, 275, 45)];
    bgView1.backgroundColor = TCUIColorFromRGB(0x5BBFBE);
    bgView1.layer.masksToBounds = YES;
    bgView1.layer.cornerRadius = 14;
    bgView1.layer.borderColor = TCUIColorFromRGB(0xFFFFFF).CGColor;
    bgView1.layer.borderWidth = 1;
    [self.view addSubview:bgView1];
    
    UIImageView *phoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 17, 19)];
    phoneImage.image = [UIImage imageNamed:@"ren"];
    [bgView1 addSubview:phoneImage];
    
    self.usetf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImage.frame) + 20, 15, 275 - 20 - 17 - 15 - 20, 15)];
    [self.usetf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    self.usetf.borderStyle = UITextBorderStyleNone;
    self.usetf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.usetf.textAlignment = NSTextAlignmentLeft;
    self.usetf.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.usetf.placeholder = @"请输入手机号";
    //修改placeholder颜色字体
    [self.usetf setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4] forKeyPath:@"_placeholderLabel.textColor"];
    [bgView1 addSubview:self.usetf];
    
    UIView *yanzhengView = [[UIView alloc]initWithFrame:CGRectMake((WIDHT - 275)/2, CGRectGetMaxY(bgView1.frame) + 15, 174, 45)];
    yanzhengView.backgroundColor = TCUIColorFromRGB(0x5BBFBE);
    yanzhengView.layer.masksToBounds = YES;
    yanzhengView.layer.cornerRadius = 14;
    yanzhengView.layer.borderWidth = 1;
    yanzhengView.layer.borderColor = TCUIColorFromRGB(0xFFFFFF).CGColor;
    [self.view addSubview:yanzhengView];
    
    UIImageView *souImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 14.5, 19)];
    souImage.image = [UIImage imageNamed:@"锁头"];
    [yanzhengView addSubview:souImage];
    
    self.secrettf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(souImage.frame) + 21.5, 15, 174 - 21 - 15 - 16 - 20, 15)];
    self.secrettf.borderStyle = UITextBorderStyleNone;
    [self.secrettf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    self.secrettf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.secrettf.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.secrettf.textAlignment = NSTextAlignmentLeft;
    self.secrettf.placeholder = @"请输入验证码";
    
    //修改placeholder颜色字体
    [self.secrettf setValue:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4] forKeyPath:@"_placeholderLabel.textColor"];
    [yanzhengView addSubview:self.secrettf];
    
    UIButton *obtainBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yanzhengView.frame) + 15, CGRectGetMaxY(bgView1.frame) + 15, 86, 45)];
    self.obtainBtn = obtainBtn;
    self.obtainBtn.userInteractionEnabled = YES;
    obtainBtn.layer.masksToBounds = YES;
    obtainBtn.layer.cornerRadius = 14;
    obtainBtn.layer.borderWidth = 1;
    obtainBtn.layer.borderColor = TCUIColorFromRGB(0xFFFFFF).CGColor;
    [obtainBtn setBackgroundColor:TCUIColorFromRGB(0x5BBFBE)];
    [obtainBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [obtainBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    obtainBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    obtainBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [obtainBtn addTarget:self action:@selector(clickobtainBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:obtainBtn];
    
    //登录
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake((WIDHT - 275)/2, CGRectGetMaxY(obtainBtn.frame) + 30, 275, 45);
    _loginBtn.backgroundColor = TCUIColorFromRGB(0x52AFAE);
    _loginBtn.alpha = 0.6;
    _loginBtn.userInteractionEnabled = YES;
    _loginBtn.layer.cornerRadius = 14;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _loginBtn];

    self.currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
}

-(void)clickLogin:(UIButton *)sender{
    NSLog(@"进去啊");
    if (self.usetf.text.length < 11 || ![BSUtils checkTelNumber:self.usetf.text]) {
        [TCProgressHUD showMessage:@"请输入正确的11位手机号"];
    }else{
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
    
        // 2.1.9版本新增获取registration id block接口。
        [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
            if(resCode == 0){
                NSLog(@"极光推送 , registrationID获取成功 =======> %@",registrationID);
//                NSUserDefaults *user_registrationID = [NSUserDefaults standardUserDefaults];
//                [user_registrationID setObject:registrationID forKey:@"registrationID"];
//                [user_registrationID synchronize];
                self.pushID = registrationID;

            } else {
                NSLog(@"极光推送 , registrationID获取失败 =======> code：%d",resCode);
            }
        }];
        
        NSString *Timestr = [TCGetTime getCurrentTime];
        if (self.pushID == nil) {
            self.pushID = @"0";
        }
        NSDictionary *dic = @{@"mobile":self.usetf.text,@"verifyCode":self.secrettf.text,@"versionId":self.currentVersion,@"deviceid":[TCGetDeviceId getDeviceId],@"deviceSysInfo":@"IOS",@"timestamp":Timestr,@"pushid":self.pushID};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *parameters = @{@"mobile":self.usetf.text,@"verifyCode":self.secrettf.text,@"versionId":self.currentVersion,@"deviceid":[TCGetDeviceId getDeviceId],@"deviceSysInfo":@"IOS",@"timestamp":Timestr,@"sign":singStr,@"pushid":self.pushID};
        
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201001"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSLog(@"%@---%@",jsonDic,jsonStr);
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                //记录用户ID 和token值  角色类型  是否通过验证
                [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"memberid"] forKey:@"userID"];
                [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"showQr"] forKey:@"showQR"];
                [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"token"] forKey:@"userToken"];

                [_userdefault setValue:jsonDic[@"data"][@"mobile"] forKey:@"userMobile"];
                [self.userdefault setValue:jsonDic[@"data"][@"shopid"] forKey:@"shopID"];
    
                TCTabBarViewController *tabVC = [[TCTabBarViewController alloc]init];
                [self  presentViewController:tabVC animated:YES completion:nil];
            }
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}

-(void)alueChange:(UITextField *)textField{
    if (self.usetf.text.length != 0) {
        self.obtainBtn.userInteractionEnabled = YES;
    }
    //    }else{
    //        codeBtn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
    //        codeBtn.userInteractionEnabled = NO;
    //    }
    
    self.loginBtn.enabled = (self.usetf.text.length != 0 && self.secrettf.text.length != 0);
    if(self.loginBtn.enabled == YES){
        self.loginBtn.userInteractionEnabled = YES;
        self.loginBtn.alpha = 1;
        self.loginBtn.backgroundColor = TCUIColorFromRGB(0x52AFAE);
        
    }else{
        self.loginBtn.alpha = 0.6;
        self.loginBtn.userInteractionEnabled = NO;
        
    }
}


-(void)clickobtainBtn:(UIButton *)sender{
    NSLog(@"获取验证码");
    if (self.usetf.text.length < 11 || ![BSUtils checkTelNumber:self.usetf.text]) {
        [TCProgressHUD showMessage:@"请输入正确的11位手机号"];
    }else{
        _Timecount = 60;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSDictionary *dic = @{@"mobile":self.usetf.text,@"type":@"7",@"timestamp":Timestr};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *paramters = @{@"mobile":self.usetf.text,@"timestamp":Timestr,@"type":@"7",@"sign":singStr};
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201002"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSLog(@"%@---%@",jsonDic,jsonStr);
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }else{
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}

//定时器触发事件
- (void)reduceTime:(NSTimer *)coderTimer{
    _Timecount--;
    if (_Timecount == 0) {
        [self.obtainBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.obtainBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        self.obtainBtn.userInteractionEnabled = YES;
        //停止定时器
        [timer invalidate];
    }else{
        NSString *str = [NSString stringWithFormat:@"%lus", (long)_Timecount];
        [self.obtainBtn setTitle:str forState:UIControlStateNormal];
        //        codeBtn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
        self.obtainBtn.userInteractionEnabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usetf resignFirstResponder];
    [self.secrettf resignFirstResponder];
}


@end

