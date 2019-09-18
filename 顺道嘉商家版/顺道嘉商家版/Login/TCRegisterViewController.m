//
//  TCRegisterViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/10/13.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCRegisterViewController.h"
#import "TCHubView.h"
#import "TCProgressHUD.h"
#import "BSUtils.h"
#import "TCSJTJViewController.h"
#import "TCCreateShopsViewController.h"
#import "TCShopManagerViewController.h"

@interface TCRegisterViewController () <UITextFieldDelegate>

{
    UIButton *eyebtn; //眼睛
    UIButton *neweyebtn;
    //设置定时器
    NSTimer *timer;
    NSInteger timeCount;
}
@property (nonatomic , strong) UIButton *submitBtn;
@property (nonatomic, strong) NSUserDefaults *userdefault;

@end

@implementation TCRegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.iszhuce) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = Color;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         
  @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        //左边导航栏的按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12*WIDHTSCALE, 20*HEIGHTSCALE)];
        // Add your action to your button
        [leftButton addTarget:self action:@selector(barButtonItemsao:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
        UIBarButtonItem *barleftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = barleftBtn;

    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.title = @"成为商家";
    // 添加视图
    [self createUI];
    
    // Do any additional setup after loading the view.
}

//添加视图
- (void)createUI
{
//    UIView *navView = [[UIView alloc] init];
//    navView.frame = CGRectMake(0, 0, WIDHT, 64);
//    navView.backgroundColor = Color;
//    [self.view addSubview:navView];
    
//    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    backButton.frame = CGRectMake(15, 26, 35, 35);
//    [backButton setImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
//    [backButton addTarget:self action:@selector(backButton) forControlEvents:(UIControlEventTouchUpInside)];
//    [navView addSubview:backButton];
//    
//    //title
//    UILabel *navTitle = [[UILabel alloc] init];
//    navTitle.frame = CGRectMake(0, 33, WIDHT, 18);
//    navTitle.text = @"成为商家";
//    navTitle.textColor = TCUIColorFromRGB(0xFFFFFF);
//    navTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
//    navTitle.textAlignment = NSTextAlignmentCenter;
//    [navView addSubview:navTitle];
    
    //题目
    NSArray *titlearray = @[@"手机号：",@"密码：",@"确认密码：",@"身份证号：",@"店铺名称：",@"验证码："];
    //虚化
    NSArray *placearray = @[@"请输入手机号",@"设置您的登录密码(6~20位)",@"再次输入密码",@"输入您的身份证号",@"输入店铺名称（12字以内）",@""];
    
    for (int i = 0; i < 6; i ++) {
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(40, (26 + (33 + 21) * i) *HEIGHTSCALE, 80*WIDHTSCALE, 21 *HEIGHTSCALE);
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*HEIGHTSCALE];
        titleLabel.textColor = TCUIColorFromRGB(0x666666);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = titlearray[i];
        [self.view addSubview:titleLabel];
        
        //textField
        UITextField *textField = [[UITextField alloc] init];
        textField.delegate = self;
        
        if (i == 0){
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        if (i == 1){
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            eyebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            eyebtn.frame = CGRectMake(315 * WIDHTSCALE, 78 *HEIGHTSCALE, 22 * HEIGHTSCALE, 22 * HEIGHTSCALE);
            [eyebtn setImage:[UIImage imageNamed:@"密码不可视图标"] forState:UIControlStateNormal];
            [eyebtn setImage:[UIImage imageNamed:@"logineye"] forState:UIControlStateSelected];
            
            [eyebtn addTarget:self action:@selector(see:) forControlEvents:UIControlEventTouchUpInside];
            eyebtn.hidden = YES;
            [self.view addSubview: eyebtn];
        }
        
        if (i == 2) {
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            neweyebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            neweyebtn.frame = CGRectMake(315 * WIDHTSCALE, 132 *HEIGHTSCALE, 22 * HEIGHTSCALE, 22 * HEIGHTSCALE);
            [neweyebtn setImage:[UIImage imageNamed:@"密码不可视图标"] forState:UIControlStateNormal];
            [neweyebtn setImage:[UIImage imageNamed:@"logineye"] forState:UIControlStateSelected];
            
            [neweyebtn addTarget:self action:@selector(neweyebtn:) forControlEvents:UIControlEventTouchUpInside];
            neweyebtn.hidden = YES;
            [self.view addSubview: neweyebtn];
            
        }
        if (i == 1){
            textField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), (26 + (33 + 21) * i) *HEIGHTSCALE , 180 *WIDHTSCALE, 21 *HEIGHTSCALE);
        } else if (i == 2){
            textField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), (26 + (33 + 21) * i) *HEIGHTSCALE, 180 *WIDHTSCALE, 21 *HEIGHTSCALE);
        } else if (i == 5){
            textField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), (26 + (33 + 21) * i) *HEIGHTSCALE, 100 *WIDHTSCALE, 21 *HEIGHTSCALE);
        } else {
            textField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), (26 + (33 + 21) * i) *HEIGHTSCALE, WIDHT - 40*WIDHTSCALE - 120 *WIDHTSCALE, 21 *HEIGHTSCALE);
        }
        
        textField.textColor = TCUIColorFromRGB(0x333333);
        textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15 *HEIGHTSCALE];
        textField.placeholder = placearray[i];
        textField.tag = 1000 + i;
        [self.view addSubview:textField];
        
        //把输入的文本居中显示
        textField.textAlignment = NSTextAlignmentLeft;
        UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000]; //手机号
        UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
        UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002]; //确认密码
        UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
        UITextField *textField_shop = (UITextField *)[self.view viewWithTag:1004]; //店铺名称
        UITextField *textField_verification = (UITextField *)[self.view viewWithTag:1005]; //验证码
        
        [textField_number addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
        
        
        //创建通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //注册通知
        [center addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:nil];  //显示眼睛
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_phone];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_card];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_querenCard];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_number];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_shop];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_verification];
        
        
        //下划线
        UIView *lineview = [[UIView alloc] init];
        if (i == 5){
           lineview.frame = CGRectMake(40, (53 + 53.5 * i) *HEIGHTSCALE, 176*WIDHTSCALE, 0.5);
            
            //验证码
            UIButton * yanzhengButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            yanzhengButton.frame = CGRectMake(CGRectGetMaxX(lineview.frame) + 19, (53 + 53.5 * 4 + 24.5) *HEIGHTSCALE ,75 *WIDHTSCALE,21 *HEIGHTSCALE);
            [yanzhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [yanzhengButton setTitleColor:TCUIColorFromRGB(0x0088CC) forState:(UIControlStateNormal)];
            yanzhengButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*HEIGHTSCALE];
            yanzhengButton.tag = 100001;
            [yanzhengButton addTarget:self action:@selector(yanzhengButton:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:yanzhengButton];
            
            //下划线
            UIView *lineyanzheng = [[UIView alloc] init];
            lineyanzheng.frame = CGRectMake(CGRectGetMaxX(lineview.frame) + 8, (53 + 53.5 * i) *HEIGHTSCALE, 96 *WIDHTSCALE, 0.5);
            lineyanzheng.backgroundColor = TCUIColorFromRGB(0x666666);
            [self.view addSubview:lineyanzheng];
        } else {
           lineview.frame = CGRectMake(40, (53 + 53.5 * i) *HEIGHTSCALE, WIDHT - 80 *WIDHTSCALE, 0.5);
        }
        
        lineview.backgroundColor = TCUIColorFromRGB(0x666666);
        [self.view addSubview:lineview];
    }
    
    //提交按钮
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    submitBtn.frame = CGRectMake(40,  (53 + 53.5 * 5 + 40.5) *HEIGHTSCALE, WIDHT - 80 *WIDHTSCALE, 42*HEIGHTSCALE);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    submitBtn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
    submitBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18*HEIGHTSCALE];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    submitBtn.tag = 10000;
    submitBtn.userInteractionEnabled = NO;
    [self.view addSubview:submitBtn];
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"店铺通过认证图"];
    imageView.frame = CGRectMake(WIDHT/2 - 93/2, CGRectGetMaxY(submitBtn.frame) + 40 *HEIGHTSCALE, 93 *WIDHTSCALE, 77 *HEIGHTSCALE);
    [self.view addSubview:imageView];
    
    //文字
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 16*HEIGHTSCALE, WIDHT, 21 *HEIGHTSCALE);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"在顺道嘉开店更容易";
    label.textColor = TCUIColorFromRGB(0xB4B4B4);
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15 *HEIGHTSCALE];
    [self.view addSubview:label];
    
}

#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000]; //手机号
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002]; //确认密码
    UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
    UITextField *textField_shop = (UITextField *)[self.view viewWithTag:1004]; //店铺名称
    UITextField *textField_verification = (UITextField *)[self.view viewWithTag:1005]; //验证码
    
    if (textField_phone) {
        if (textField_phone.text.length > 11) {
            textField_phone.text = [textField_phone.text substringToIndex:11];
        }
    } else if (textField_number) {
        if (textField_number.text.length > 18) {
            textField_number.text = [textField_phone.text substringToIndex:18];
        }
    }

    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    btn.enabled = (textField_phone.text.length != 0 && textField_card.text.length != 0 && textField_querenCard.text.length != 0 && textField_number.text.length != 0 && textField_shop.text.length != 0 && textField_verification.text.length != 0 );
        if(btn.enabled == YES){
            btn.backgroundColor = TCUIColorFromRGB(0x00D9D9);
            btn.userInteractionEnabled = YES;
        }else{
            btn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
        }
}

#pragma mark -- 点击观看按钮
- (void)see:(UIButton *)sender{
    sender.selected = !sender.selected;
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
    
    if (sender.isSelected) {
        textField_newpass.secureTextEntry = NO;
    }else{
        textField_newpass.secureTextEntry = YES;
    }
}

- (void)neweyebtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002];
    
    if (sender.isSelected) {
        textField_querenCard.secureTextEntry = NO;
    }else{
        textField_querenCard.secureTextEntry = YES;
    }
}

//当输入框编辑
- (void)change{
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002];
    
    //如果密码不为空 显示eye按钮
    if (![textField_newpass.text isEqualToString:@""]) {
        eyebtn.hidden = NO;
    }else{
        eyebtn.hidden = YES;
    }
    
    if (![textField_querenCard.text isEqualToString:@""]) {
        neweyebtn.hidden = NO;
    }else{
        neweyebtn.hidden = YES;
    }
}
#pragma mark -- 验证码
- (void)yanzhengButton:(UIButton *)sender
{
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000];
    
        if (textField_phone.text.length != 11) {
            [TCProgressHUD showMessage:@"请输入您的手机号"];
        }else{
            timeCount = 60;
            
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"获取中..."];
            sender.userInteractionEnabled = NO;
            //发送请求
            [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"301010"] parameters:@{@"mobile":textField_phone.text} success:^(id responseObject) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:nil];
                [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",dic[@"retMessage"]]];
                [SVProgressHUD dismiss];
                if ([dic[@"retValue"] intValue] == 301) {
                    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
                } else {
                    [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",dic[@"retMessage"]]];
                    sender.userInteractionEnabled = YES;
                }
                NSLog(@"找回密码短信返回信息%@ %@", dic, dic[@"retMessage"]);
            } failure:^(NSError *error) {
                NSLog(@"找回密码短信请求失败");
            
            }];
        }
    }

//定时器触发事件
- (void)reduceTime:(NSTimer *)coderTimer{
    timeCount--;
    if (timeCount == 0) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100001];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:TCUIColorFromRGB(0x0088CC) forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
        //停止定时器
        [timer invalidate];
    }else{
        UIButton *btn = (UIButton *)[self.view viewWithTag:100001];
        [btn setTitleColor:TCUIColorFromRGB(0x0088CC) forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 * WIDHTSCALE];
        NSString *str = [NSString stringWithFormat:@"%lus", (long)timeCount];
        
        [btn setTitle:str forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
    }
}

#pragma mark -- 提交按钮
-(void)submitBtn:(UIButton *)sender
{
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000]; //手机号
    
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002]; //确认密码
    UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
    
    if (![BSUtils checkTelNumber:textField_phone.text]) {
        [TCProgressHUD showMessage:@"请输入正确的手机号"];
    } else {
        if(![BSUtils checkPayPwd:textField_card.text]) {
            [TCProgressHUD showMessage:@"请输入(6~20)位密码"];
        } else {
            if (textField_card.text != textField_querenCard.text) {
                [TCProgressHUD showMessage:@"两次密码输入不一致"];
            } else {
                if(![BSUtils IsIdentityCard:textField_number.text])
                {
                    [TCProgressHUD showMessage:@"请输入正确的身份证号"];
                } else {
                    [self createQuest];
                }
            }
      }
   }
}
#pragma mark -- 网络请求
- (void)createQuest{
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000]; //手机号
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
    UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
    UITextField *textField_shop = (UITextField *)[self.view viewWithTag:1004]; //店铺名称
    UITextField *textField_verification = (UITextField *)[self.view viewWithTag:1005]; //验证码
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    
    NSDictionary *paramter = @{@"mobile":textField_phone.text,@"password":textField_card.text,@"idno":textField_number.text, @"name":textField_shop.text, @"code":textField_verification.text,@"device":@"ios",@"deviceid":[TCGetDeviceId getDeviceId]};
    NSLog(@"%@",paramter);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"1000001"] parameters:paramter success:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"str %@ %@", str, dic);
        //只有 retValue=203 时修改成功，其余全失败
        if (!([[dic valueForKey:@"retValue"]integerValue] > 0)) {
            [TCProgressHUD showMessage:dic[@"retMessage"]];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD dismiss];
            NSString *isjumpStr = [NSString stringWithFormat:@"%@",dic[@"data"][@"isJump"]];
            //解析
            NSString *base64String = dic[@"data"][@"shop"];
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
            NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",decodedString);
       
            if ([decodedString rangeOfString:@","].location == NSNotFound) {
                //如果不存在逗号
                [self.userdefault setValue:decodedString forKey:@"shopID"];
            }else{
                NSRange range = [decodedString rangeOfString:@","];
                NSString *str = [decodedString substringToIndex:range.location];
                [self.userdefault setValue:str forKey:@"shopID"];
            }
            
            //记录用户ID 和token值  角色类型  是否通过验证
            [self.userdefault setValue:[[dic valueForKey:@"data"] valueForKey:@"id"] forKey:@"userID"];
            [self.userdefault setValue:[[dic valueForKey:@"data"] valueForKey:@"token"] forKey:@"userToken"];
            [self.userdefault setValue:[[dic valueForKey:@"data"] valueForKey:@"mid"] forKey:@"userMID"];
            [self.userdefault setValue:dic[@"data"][@"mobile"] forKey:@"userMobile"];
            [self.userdefault setValue:dic[@"data"][@"role"] forKey:@"userRole"];
            
            //"auth": -1,//-1未通过，0未认证，1已通过，2待认证。
            if ([isjumpStr isEqualToString:@"1"]){
                TCSJTJViewController *sjtjVC = [[TCSJTJViewController alloc] init];
                sjtjVC.hidesBottomBarWhenPushed = YES;
                sjtjVC.iszhuce = YES;
                sjtjVC.tiaozhuan = YES;
                [self.navigationController pushViewController:sjtjVC animated:YES];
            } else if ([isjumpStr isEqualToString:@"3"]) {
                TCCreateShopsViewController *shopVC = [[TCCreateShopsViewController alloc] init];
                shopVC.isChange = YES;
                shopVC.zhuce = YES;
                shopVC.shopid = [_userdefault valueForKey:@"shopID"];
                NSLog(@"%@",shopVC.shopid);
                shopVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopVC animated:YES];
            } else if ([isjumpStr isEqualToString:@"2"]){
                
                TCShopManagerViewController *shopManageVC = [[TCShopManagerViewController alloc] init];
                shopManageVC.zhuce = YES;
                shopManageVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopManageVC animated:YES];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@" 错误 %@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 点击空白 下滑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000]; //手机号
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002]; //确认密码
    UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
    UITextField *textField_shop = (UITextField *)[self.view viewWithTag:1004]; //店铺名称
    UITextField *textField_verification = (UITextField *)[self.view viewWithTag:1005]; //验证码
    
    [textField_phone resignFirstResponder];
    [textField_card resignFirstResponder];
    [textField_querenCard resignFirstResponder];
    [textField_number resignFirstResponder];
    [textField_shop resignFirstResponder];
    [textField_verification resignFirstResponder];
    
}

#pragma mark -- 点击return 下滑
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    
    return YES;
}

//限制字数
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_newcard = (UITextField *)[self.view viewWithTag:1002];
     UITextField *textField_identity = (UITextField *)[self.view viewWithTag:1003];
    
    if(textField == textField_phone){
        if(range.length + range.location > textField_phone.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_phone.text length] + [string length] - range.length;
        return newLenght <= 11;
    }else if (textField == textField_card){
        if(range.length + range.location > textField_card.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_card.text length] + [string length] - range.length;
        return newLenght <= 20;
    }else if (textField == textField_newcard){
        if(range.length + range.location > textField_newcard.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_newcard.text length] + [string length] - range.length;
        return newLenght <= 20;
    } else if (textField == textField_identity){
        if(range.length + range.location > textField_identity.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_identity.text length] + [string length] - range.length;
        return newLenght <= 18;
    }
    else{
        return YES;
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1001]; //密码
    UITextField *textField_querenCard = (UITextField *)[self.view viewWithTag:1002]; //确认密码
    
     UITextField *textField_number = (UITextField *)[self.view viewWithTag:1003]; //身份证号
    if (textField == textField_number) {
        if (textField_card.text != textField_querenCard.text) {
            
            [TCProgressHUD showMessage:@"两次密码输入不一致"];
        }
    }
}

#pragma mark -- 返回按钮
- (void) barButtonItemsao:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark -- 返回按钮
//- (void)backButton
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
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
