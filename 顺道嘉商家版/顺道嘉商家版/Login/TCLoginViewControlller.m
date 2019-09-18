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
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(150 , 120, 83 , 70)];
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

//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT - 35 * HEIGHTSCALE, WIDHT, 30 * HEIGHTSCALE)];
//    version.text = [NSString stringWithFormat:@"版本号：V%@", appCurVersion];
//    version.textAlignment = NSTextAlignmentCenter;
//    version.textColor = Color;
//    [self.view addSubview: version];
     self.currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    //检测更新
//    [self versionUpdate];
}
//
////检测更新
//- (void)versionUpdate{
//    //获得当前发布的版本
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 耗时的操作---获取某个应用在AppStore上的信息，更改id就行
//        NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://itunes.apple.com/lookup?id=1151304737"] encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//        if (data) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSString *version = [[[dic objectForKey:@"results"]firstObject]objectForKey:@"version"];//线上版本号当前版本的更新提示
//            //获得当前版本
//            NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//            dispatch_async(dispatch_get_main_queue(), ^{
////                // 更新界面
////                if (version &&![version isEqualToString:currentVersion]) {
////                    [self request];
////                }else{
////                    //已是最高版本
////                    NSLog(@"已经是最高版本");
//   //             }
//            });
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"网络异常"];
//        }
//    });
//}
//
////请求判断检测更新
//- (void)request{
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"100001"] paramter:nil success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        if (jsonDic[@"data"]) {
//            if ([[NSString stringWithFormat:@"%@", jsonDic[@"data"][@"mst"]] isEqualToString:@"0"]) {
//                [TCUpdateView upDateView];
//            }else{
//                NSLog(@"未开启检测更新");
//            }
//        }
//    } failure:^(NSError *error) {
//        nil;
//    }];
//}

////取消密码显示  移除eye按钮
//- (void)see:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    if (sender.isSelected) {
//        _secrettf.secureTextEntry = NO;
//    }else{
//        _secrettf.secureTextEntry = YES;
//    }
//}

-(void)clickLogin:(UIButton *)sender{
    NSLog(@"进去啊");
    if (self.usetf.text.length < 11 || ![BSUtils checkTelNumber:self.usetf.text]) {
        [TCProgressHUD showMessage:@"请输入正确的11位手机号"];
    }else{
        [BQActivityView showActiviTy];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSDictionary *dic = @{@"mobile":self.usetf.text,@"verifyCode":self.secrettf.text,@"versionId":self.currentVersion,@"deviceid":[TCGetDeviceId getDeviceId],@"deviceSysInfo":@"IOS",@"timestamp":Timestr};
        NSString *singStr = [TCServerSecret signStr:dic];
        NSDictionary *parameters = @{@"mobile":self.usetf.text,@"verifyCode":self.secrettf.text,@"versionId":self.currentVersion,@"deviceid":[TCGetDeviceId getDeviceId],@"deviceSysInfo":@"IOS",@"timestamp":Timestr,@"sign":singStr};
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201001"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSLog(@"%@---%@",jsonDic,jsonStr);
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
                //记录用户ID 和token值  角色类型  是否通过验证
                [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"memberid"] forKey:@"userID"];
                [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"token"] forKey:@"userToken"];
                
                [_userdefault setValue:jsonDic[@"data"][@"mobile"] forKey:@"userMobile"];
                [self.userdefault setValue:jsonDic[@"data"][@"shopid"] forKey:@"shopID"];
                
                TCTabBarViewController *tabVC = [[TCTabBarViewController alloc]init];
                [self  presentViewController:tabVC animated:YES completion:nil];
            }else{
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            [BQActivityView hideActiviTy];
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
        [BQActivityView showActiviTy];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSDictionary *dic = @{@"mobile":self.usetf.text,@"type":@"7",@"timestamp":Timestr};
        NSString *singStr = [TCServerSecret signStr:dic];
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
            [BQActivityView hideActiviTy];
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


////登录
//- (void)login{
//    [self.usetf resignFirstResponder];
//    [self.secrettf resignFirstResponder];
//
////    _loginBtn.userInteractionEnabled = NO;
////    _pushID = [_userdefault valueForKey:@"registrationID"];
////    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
////    [SVProgressHUD showWithStatus:@"登录中..."];
////    if(_pushID == nil){
////        _paramter = @{@"mobile":_usetf.text, @"password":_secrettf.text, @"deviceid":[TCGetDeviceId getDeviceId], @"device":[[UIDevice currentDevice]systemVersion]};
////    }else{
////        _paramter = @{@"mobile":_usetf.text, @"password":_secrettf.text, @"deviceid":[TCGetDeviceId getDeviceId],@"pushid":_pushID, @"device":[[UIDevice currentDevice]systemVersion]};
////    }
////
////    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"100101"] paramter:_paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
////        _loginBtn.userInteractionEnabled = YES;
////        //如果返回数据中的号码与输入的号码不一样，则认为登录失败
////        if (([[jsonDic valueForKey:@"retValue"]integerValue] <  0)) {
////
////            [SVProgressHUD dismiss];
////            [TCProgressHUD showMessage:jsonDic[@"retMessage"]];
////
////            //[SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
////        }else{
////            //记录用户ID 和token值  角色类型  是否通过验证
////            [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"id"] forKey:@"userID"];
////            [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"token"] forKey:@"userToken"];
////            [self.userdefault setValue:[[jsonDic valueForKey:@"data"] valueForKey:@"mid"] forKey:@"userMID"];
////            [_userdefault setValue:jsonDic[@"data"][@"mobile"] forKey:@"userMobile"];
////            [self.userdefault setValue:jsonDic[@"data"][@"role"] forKey:@"userRole"];
////
////            NSString *base64String = jsonDic[@"data"][@"shop"];
////            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
////            NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
////            _mesDic = jsonDic[@"data"];
////
////            if ([decodedString rangeOfString:@","].location == NSNotFound) {
////                //如果不存在逗号
////                [self.userdefault setValue:decodedString forKey:@"shopID"];
////            }else{
////                NSRange range = [decodedString rangeOfString:@","];
////                NSString *str = [decodedString substringToIndex:range.location];
////                [self.userdefault setValue:str forKey:@"shopID"];
////                NSLog(@"%@",[_userdefault valueForKey:@"shopID"]);
////            }
////            if ([[_userdefault valueForKey:@"userRole"] isEqualToString:@"商家"]) {
//////                [self createBack];
////                [_userdefault setValue:@"yes" forKey:@"userList"];
////            }
//////                TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
//////                [_backView removeFromSuperview];
//////                [self presentViewController:tab animated:YES completion:nil];
//////            }else{
//////                TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
//////                [_backView removeFromSuperview];
//////                [self presentViewController:tab animated:YES completion:nil];
//////            }
////
////            //记录isJump
////            //0 跳订单 1跳实名认证 2跳店铺列表 3跳店铺编辑。
////             NSString *isjumpStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"isJump"]];
////             [_backView removeFromSuperview];
////            [SVProgressHUD dismiss];
////            if ([isjumpStr isEqualToString:@"1"]) {
////                TCSJTJViewController *JTJVC = [[TCSJTJViewController alloc] init];
////                JTJVC.hidesBottomBarWhenPushed = YES;
////                JTJVC.iszhuce = YES;
////                [self.navigationController pushViewController:JTJVC animated:YES];
////            } else if ([isjumpStr isEqualToString:@"2"]){
////
////                [_userdefault setValue:@"yes" forKey:@"userList"];
////
////                TCShopManagerViewController *shopManageVC = [[TCShopManagerViewController alloc] init];
////                shopManageVC.zhuce = YES;
////                shopManageVC.hidesBottomBarWhenPushed = YES;
////                [self.navigationController pushViewController:shopManageVC animated:YES];
////            } else if ([isjumpStr isEqualToString:@"3"]){
////                TCCreateShopsViewController *shopVC = [[TCCreateShopsViewController alloc] init];
////                shopVC.isChange = YES;
////                shopVC.zhuce = YES;
////                shopVC.shopid = [_userdefault valueForKey:@"shopID"];
////                NSLog(@"%@",shopVC.shopid);
////                shopVC.hidesBottomBarWhenPushed = YES;
////                [self.navigationController pushViewController:shopVC animated:YES];
////            } else if ([isjumpStr isEqualToString:@"4"]) {
////                TCShopsManaerViewController *shopVC = [[TCShopsManaerViewController alloc] init];
////                shopVC.zhuce = YES;
////                shopVC.shopid = [_userdefault valueForKey:@"shopID"];
////                NSLog(@"%@",shopVC.shopid);
////                shopVC.hidesBottomBarWhenPushed = YES;
////                [self.navigationController pushViewController:shopVC animated:YES];
////
////
////
////            } else {
////                TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
////                [_backView removeFromSuperview];
////                [self presentViewController:tab animated:YES completion:nil];
////
////            }
////        }
////    } failure:^(NSError *error) {
////        nil;
////    }];
//
//}
//
////- (void)createBack{
////    [SVProgressHUD dismiss];
////    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
////    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
////    [[UIApplication sharedApplication].keyWindow addSubview: _backView];
////    //移除手势
////    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
////    [_backView addGestureRecognizer:tap];
////
////    [self check];
////}
////-(void)tap{
////    [_backView removeFromSuperview];
////}
//
////检测view
////- (void)check{
////    UIView *checkView = [[UIView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - 90 * HEIGHTSCALE, WIDHT - 40 * WIDHTSCALE, 180 * HEIGHTSCALE)];
////    checkView.backgroundColor = [UIColor whiteColor];
////    checkView.layer.cornerRadius = 5 * HEIGHTSCALE;
////    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, 40 * HEIGHTSCALE, checkView.frame.size.width - 40 * WIDHTSCALE, 16 * HEIGHTSCALE)];
////    lb.text = @"正在检测您的身份证信息，请稍后...";
////    lb.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];
////    lb.textColor = RGB(22, 152, 217);
////    lb.textAlignment = NSTextAlignmentCenter;
////    [checkView addSubview: lb];
////    [_backView addSubview: checkView];
////    UIImageView *ims = [[UIImageView alloc]initWithFrame:CGRectMake(checkView.frame.size.width / 2 - 16 * WIDHTSCALE, lb.frame.origin.y + lb.frame.size.height + 40 * HEIGHTSCALE, 32 * WIDHTSCALE, 32 * WIDHTSCALE)];
////    ims.image = [UIImage imageNamed:@"加载菊花.png"];
////    CABasicAnimation* rotationAnimation;
////    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
////    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
////    rotationAnimation.duration = 1.5f;
////    rotationAnimation.cumulative = YES;
////    rotationAnimation.repeatCount = 99999;
////    [ims.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
////    [checkView addSubview: ims];
////
////    [UIView animateWithDuration:0.5 animations:^{
////        checkView.transform = CGAffineTransformMakeScale(1.1, 1.1);
////    } completion:^(BOOL finished) {
////        checkView.transform = CGAffineTransformIdentity;
////        //判断是否通过实名认证
////        if ([[NSString stringWithFormat:@"%@", _mesDic[@"auth"]] isEqualToString:@"1"]) {
////            //判断是否有店铺
////            if ([[_userdefault valueForKey:@"shopID"] isEqualToString:@""]) {
////                //要设置为yes 要求新创建商家商品页面有列表
////                [_userdefault setValue:@"yes" forKey:@"userList"];
////                TCCreateShopsViewController *create = [[TCCreateShopsViewController alloc]init];
////                create.loginCome = YES;
////                [_backView removeFromSuperview];
////                [self presentViewController:create animated:YES completion:nil];
////
////            }else{
////                //有店铺
////                //判断是是否为商家
////                if ([[_userdefault valueForKey:@"userRole"] isEqualToString:@"商家"]) {
////                    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200001"] paramter:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
////                        NSArray * arr = jsonDic[@"data"];
////                        //商家有无分店都走列表页面
////                        [_userdefault setValue:@"yes" forKey:@"userList"];
////
////                        TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
////                        [_backView removeFromSuperview];
////                        [self presentViewController:tab animated:YES completion:nil];
////                    } failure:^(NSError *error) {
////                        nil;
////                    }];
////                }else{
////                    TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
////                    [_backView removeFromSuperview];
////                    [self presentViewController:tab animated:YES completion:nil];
////                }
////            }
////        }else if ([[NSString stringWithFormat:@"%@", _mesDic[@"auth"]] isEqualToString:@"0"]){
////            [_backView removeFromSuperview];
////            //表示为未认证
////            TCSJTJViewController *ident = [[TCSJTJViewController alloc]init];
////            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:ident];
////            [self presentViewController:navi animated:YES completion:nil];
////
////        }else if ([[NSString stringWithFormat:@"%@", _mesDic[@"auth"]] isEqualToString:@"-1"]){
////            //表示认证失败
////            [checkView removeFromSuperview];
////            [self defeate];
////        }else if ([[NSString stringWithFormat:@"%@", _mesDic[@"auth"]] isEqualToString:@"2"]){
////            //表示审核中...
////            [checkView removeFromSuperview];
////            [self shenhe];
////        }
////    }];
////
////}
//
////认证失败
//- (void)defeate{
//    _defeatView = [[UIView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - HEIGHT / 4, WIDHT - 40 * WIDHTSCALE, HEIGHT / 2 + 50 * HEIGHTSCALE)];
//    _defeatView.backgroundColor = [UIColor whiteColor];
//    _defeatView.layer.cornerRadius = 5 * HEIGHTSCALE;
//    [_backView addSubview: _defeatView];
//
//    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _defeatView.frame.size.width, 90 * HEIGHTSCALE)];
//    view1.backgroundColor = RGB(222, 222, 222);
//    view1.clipsToBounds = YES;
//    [_defeatView addSubview: view1];
//    UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(16 * WIDHTSCALE, 32 * HEIGHTSCALE, 45 * WIDHTSCALE, 35 * HEIGHTSCALE)];
//    im1.image = [UIImage imageNamed:@"审核不通过图标.png"];
//    [view1 addSubview: im1];
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view1.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5 * HEIGHTSCALE, 5 * HEIGHTSCALE)];
//    CAShapeLayer *shap = [[CAShapeLayer alloc]init];
//    shap.frame = view1.frame;
//    shap.path = path.CGPath;
//    view1.layer.mask = shap;
//
//    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(im1.frame.origin.x + im1.frame.size.width + 12 * WIDHTSCALE, im1.frame.origin.y, view1.frame.size.width - im1.frame.origin.x - im1.frame.size.width - 12 * WIDHTSCALE - 12 * WIDHTSCALE, 15 * HEIGHTSCALE)];
//    lb1.text = @"您的身份信息未通过，请重新认证";
//    lb1.font = [UIFont systemFontOfSize:15 * HEIGHTSCALE];
//    lb1.textColor = RGB(204, 41, 41);
//    [view1 addSubview: lb1];
//
//    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20 * HEIGHTSCALE + view1.frame.size.height, view1.frame.size.width, 15 * HEIGHTSCALE)];
//    lb2.text = @"未通过原因";
//    lb2.font = [UIFont systemFontOfSize:15 * HEIGHTSCALE];
//    lb2.textAlignment = NSTextAlignmentCenter;
//    [_defeatView addSubview: lb2];
//
//    UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * HEIGHTSCALE, lb2.frame.origin.y + lb2.frame.size.height + 20 * HEIGHTSCALE, _defeatView.frame.size.width - 40 * WIDHTSCALE, 140 * HEIGHTSCALE)];
//    im2.image = [UIImage imageNamed:@"虚线框.png"];
//    [_defeatView addSubview: im2];
//
//    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(12 * WIDHTSCALE, 12 * HEIGHTSCALE, im2.frame.size.width - 24 * WIDHTSCALE, 60)];
//    lb3.text = _mesDic[@"noReason"];
//    lb3.numberOfLines = 0;
//    CGSize size = [lb3 sizeThatFits:CGSizeMake(im2.frame.size.width - 24 * WIDHTSCALE, im2.frame.size.height - 24 * HEIGHTSCALE)];
//    lb3.frame = CGRectMake(12 * WIDHTSCALE, 12 * HEIGHTSCALE, im2.frame.size.width - 24 * WIDHTSCALE, size.height);
//    lb3.font = [UIFont systemFontOfSize:14 * HEIGHTSCALE];
//    [im2 addSubview: lb3];
//
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_defeatView.frame.size.width / 2 - 100 * WIDHTSCALE, im2.frame.origin.y + im2.frame.size.height + 40 * HEIGHTSCALE, 200 * WIDHTSCALE, 48 * HEIGHTSCALE)];
//    btn.backgroundColor = btnColors;
//    [btn setTitle:@"重新认证" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:18 * HEIGHTSCALE];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.layer.cornerRadius = 5 * HEIGHTSCALE;
//    [btn addTarget:self action:@selector(chongxin) forControlEvents:UIControlEventTouchUpInside];
//    [_defeatView addSubview: btn];
//}
//
////重新认证
//- (void)chongxin{
//    [_backView removeFromSuperview];
//    TCSJTJViewController *ident = [[TCSJTJViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:ident];
//    [self presentViewController:navi animated:YES completion:nil];
//}
//
////审核中
//- (void)shenhe{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - 100 * HEIGHTSCALE, WIDHT - 40 * WIDHTSCALE, 200 * HEIGHTSCALE)];
//    view.backgroundColor = [UIColor whiteColor];
//    view.layer.cornerRadius = 5 * HEIGHTSCALE;
//    [_backView addSubview: view];
//    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(16 * WIDHTSCALE, 32 * HEIGHTSCALE, 45 * WIDHTSCALE, 35 * HEIGHTSCALE)];
//    im.image = [UIImage imageNamed:@"正在审核中图标.png"];
//    [view addSubview: im];
//
//    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(12 * WIDHTSCALE + im.frame.origin.x + im.frame.size.width, im.frame.origin.y, view.frame.size.width - 24 * WIDHTSCALE - im.frame.origin.x - im.frame.size.width, 60)];
//    lb3.text = @"您的身份信息正在审核中，审核时间为1~2天，请您耐心等待，审核通过后我们会第一时间通知您，请注意查收短信，审核通过后即可登录店铺";
//    lb3.numberOfLines = 0;
//    lb3.font = [UIFont systemFontOfSize: 15 * HEIGHTSCALE];
//    CGSize size = [lb3 sizeThatFits:CGSizeMake(view.frame.size.width - 24 * WIDHTSCALE - im.frame.origin.x - im.frame.size.width, 500 * HEIGHTSCALE)];
//    lb3.frame = CGRectMake(12 * WIDHTSCALE + im.frame.origin.x + im.frame.size.width, im.frame.origin.y, view.frame.size.width - 24 * WIDHTSCALE - im.frame.origin.x - im.frame.size.width, size.height);
//    [view addSubview: lb3];
//
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width / 2 - 100 * WIDHTSCALE, view.frame.size.height - 20 * HEIGHTSCALE - 48 * HEIGHTSCALE, 200 * WIDHTSCALE, 48 * HEIGHTSCALE)];
//    btn.backgroundColor = btnColors;
//    [btn setTitle:@"关闭" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:18 * HEIGHTSCALE];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.layer.cornerRadius = 5 * HEIGHTSCALE;
//    [btn addTarget:self action:@selector(guanbi) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview: btn];
//}
//
//- (void)guanbi{
//    [_backView removeFromSuperview];
//}
////呼出键盘
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:0.3];
//        self.view.frame = CGRectMake(0.0f, -80.0, self.view.frame.size.width, self.view.frame.size.height); //64-216
//        [UIView commitAnimations];
//    }
//}
//
////收起键盘
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [UIView beginAnimations:@"ResizeForKeyboard"  context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
//    [UIView commitAnimations];
//}
//
////当输入框结束编辑
//- (void)changeend{
//    //如果密码或账号为空
//    if ([_usetf.text isEqualToString:@""] || [_secrettf.text isEqualToString:@""]) {
//        //灰化  不可点击
//        _loginBtn.userInteractionEnabled = NO;
//        _loginBtn.backgroundColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1];
//    }
//}
//
////当输入框编辑
//- (void)change{
//    //如果密码不为空 显示eye按钮
//    if (![_secrettf.text isEqualToString:@""]) {
//        _eyebtn.hidden = NO;
//    }else{
//        _eyebtn.hidden = YES;
//    }
//
//    //如果有账号
//    if (![_usetf.text isEqualToString:@""]) {
//        //改变按钮为绿色 可点击
//        _loginBtn.userInteractionEnabled = YES;
//        _loginBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:211 / 255.0 blue:208 / 255.0 alpha:1];
//    }
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_usetf resignFirstResponder];
//    [_secrettf resignFirstResponder];
//}
//
////限制字数
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if(textField == _usetf){
//        if(range.length + range.location > _usetf.text.length){
//            return NO;
//        }
//        NSInteger newLenght = [_usetf.text length] + [string length] - range.length;
//        return newLenght <= 11;
//    }else if (textField == _secrettf){
//        if(range.length + range.location > _secrettf.text.length){
//            return NO;
//        }
//        NSInteger newLenght = [_secrettf.text length] + [string length] - range.length;
//        return newLenght <= 20;
//    }
//    return YES;
//}
//
//
//
//#pragma mark -- 注册成为商家的点击事件
//- (void)registerBtn
//{
//    NSLog(@"注册");
//    TCRegisterViewController *registerVC = [[TCRegisterViewController alloc] init];
//    registerVC.iszhuce = YES;
//    registerVC.hidesBottomBarWhenPushed = YES;
//
//    [self.navigationController pushViewController:registerVC animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [[self navigationController] setNavigationBarHidden:NO animated:NO];
//    [UIApplication sharedApplication].statusBarHidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
//}
@end
