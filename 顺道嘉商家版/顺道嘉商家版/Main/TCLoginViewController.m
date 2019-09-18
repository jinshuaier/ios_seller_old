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
#import "TCServerSecret.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "TCGetDeviceId.h"

@interface TCLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *mainimageview;
@property (nonatomic, strong) UITextField *usetf;
@property (nonatomic, strong) UITextField *secrettf;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *eyebtn;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeend) name:UITextFieldTextDidEndEditingNotification object:nil];
    _userdefault = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    //设置图片
    _mainimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 250 * HEIGHTSCALE)];
    _mainimageview.image = [UIImage imageNamed:@"shundaojias"];
    [self.view addSubview: _mainimageview];

    //用户名
    UIImageView *userim = [[UIImageView alloc]initWithFrame:CGRectMake(24, _mainimageview.frame.size.height + _mainimageview.frame.origin.y + 40, 32 * WIDHTSCALE, 32 * WIDHTSCALE)];
    userim.image = [UIImage imageNamed:@"loginuser"];
    [self.view addSubview: userim];
    _usetf = [[UITextField alloc]initWithFrame:CGRectMake(userim.frame.size.width + userim.frame.origin.x + 18, userim.frame.origin.y, WIDHT - userim.frame.size.width - userim.frame.origin.x - 18 - 24, userim.frame.size.height)];
    _usetf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usetf.keyboardType = UIKeyboardTypeNumberPad;
    _usetf.placeholder = @"输入您的手机号码";
    if ([UIScreen mainScreen].bounds.size.height < IS_IPHONE_5) {
        _usetf.delegate = self;
    }
    [self.view addSubview: _usetf];
    UIImageView *lineim1 = [[UIImageView alloc]initWithFrame:CGRectMake(_usetf.frame.origin.x - 10, _usetf.frame.size.height + _usetf.frame.origin.y, _usetf.frame.size.width + 10, 1)];
    lineim1.backgroundColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1];
    [self.view addSubview: lineim1];

    //密码
    UIImageView *secretim = [[UIImageView alloc]initWithFrame:CGRectMake(24, userim.frame.size.height + userim.frame.origin.y + 20 * HEIGHTSCALE, 32 * WIDHTSCALE, 32 * WIDHTSCALE)];
    secretim.image = [UIImage imageNamed:@"loginsecret"];
    [self.view addSubview: secretim];
    _secrettf = [[UITextField alloc]initWithFrame:CGRectMake(secretim.frame.size.width + secretim.frame.origin.x + 18, secretim.frame.origin.y, WIDHT - secretim.frame.size.width - secretim.frame.origin.x - 18 - 24 - 25, secretim.frame.size.height)];
    _secrettf.delegate = self;
    _secrettf.secureTextEntry = YES;
    _secrettf.placeholder = @"输入您的密码";
    _secrettf.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview: _secrettf];
    UIImageView *lineim2 = [[UIImageView alloc]initWithFrame:CGRectMake(_secrettf.frame.origin.x - 10, _secrettf.frame.size.height + _secrettf.frame.origin.y, _secrettf.frame.size.width + 10 + 25, 1)];
    lineim2.backgroundColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1];
    [self.view addSubview: lineim2];
    _eyebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _eyebtn.frame = CGRectMake(_secrettf.frame.size.width + _secrettf.frame.origin.x, _secrettf.frame.origin.y + (_secrettf.frame.size.height / 2 - 25 * HEIGHTSCALE / 2), 25 * HEIGHTSCALE, 25 * HEIGHTSCALE);
    [_eyebtn setImage:[UIImage imageNamed:@"logineye"] forState:UIControlStateNormal];
    [_eyebtn addTarget:self action:@selector(see) forControlEvents:UIControlEventTouchUpInside];
    _eyebtn.hidden = YES;
    [self.view addSubview: _eyebtn];

    //忘记密码
    UIButton *forgetbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetbtn.frame = CGRectMake(lineim2.frame.size.width + lineim2.frame.origin.x - 80, lineim2.frame.origin.y + lineim2.frame.size.height + 10, 80, 40);
    [forgetbtn setTitle:@"忘记密码？" forState: UIControlStateNormal];
    forgetbtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetbtn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: forgetbtn];

    //登录
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(45 * WIDHTSCALE, forgetbtn.frame.origin.y + forgetbtn.frame.size.height + 40 * HEIGHTSCALE, WIDHT - 45 * WIDHTSCALE - 45 * WIDHTSCALE, 50 * HEIGHTSCALE);
    _loginBtn.backgroundColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1];
    _loginBtn.userInteractionEnabled = NO;
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _loginBtn];
}

//取消密码显示  移除eye按钮
- (void)see{
    _secrettf.secureTextEntry = NO;
    [_eyebtn removeFromSuperview];
}

//忘记密码
- (void)jump{
    TCChangeViewController *changVC = [[TCChangeViewController alloc]init];
    [self.navigationController pushViewController:changVC animated:YES];
}


//登录
- (void)login{
    TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
    [self presentViewController:tab animated:YES completion:nil];


//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD showWithStatus:@"登录中..."];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"mmapiv1" forHTTPHeaderField:@"Mmapp"];
//    NSDictionary *paramter = @{@"mobile":_usetf.text, @"password":_secrettf.text, @"pushid":[_userdefault valueForKey:@"registrationID"], @"deviceid":[TCGetDeviceId getDeviceId], @"device":[[UIDevice currentDevice]systemVersion]};
//    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100101"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
//        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"str %@", str);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@" 错误 %@", error);
//    }];

}

//呼出键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0.0f, -80.0, self.view.frame.size.width, self.view.frame.size.height); //64-216
        [UIView commitAnimations];
    }
}

//收起键盘
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
    [UIView commitAnimations];
}

//当输入框结束编辑
- (void)changeend{
    //如果密码或账号为空
    if ([_usetf.text isEqualToString:@""] || [_secrettf.text isEqualToString:@""]) {
        //灰化  不可点击
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1];
    }
}

//当输入框编辑
- (void)change{
    //如果密码不为空 显示eye按钮
    if (![_secrettf.text isEqualToString:@""]) {
        _eyebtn.hidden = NO;
    }else{
        _eyebtn.hidden = YES;
    }

    //如果有账号
    if (![_usetf.text isEqualToString:@""]) {
        //改变按钮为绿色 可点击
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:211 / 255.0 blue:208 / 255.0 alpha:1];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_usetf resignFirstResponder];
    [_secrettf resignFirstResponder];
}





@end
