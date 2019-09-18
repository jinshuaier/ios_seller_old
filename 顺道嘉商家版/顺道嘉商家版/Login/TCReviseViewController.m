//
//  TCReviseViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCReviseViewController.h"

@interface TCReviseViewController ()<UITextFieldDelegate>

{
    NSArray *textfieldArr;
    //设置定时器
    NSTimer *timer;
    NSInteger timeCount;
    UIButton *eyebtn;
}
@property (nonatomic, strong) NSUserDefaults *userdefaults;

@end

@implementation TCReviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGgray;
    self.title = @"修改密码";
    //创建下面的textfiled
    [self createTextField];
   _userdefaults = [NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view.
}
#pragma mark -- 创建下面4个textField
-(void)createTextField
{
    //创建view
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, WIDHT, 220*HEIGHTSCALE);
    [self.view addSubview:view];
    
    //修改密码的按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];;
    sureBtn.tag = 10000;
    sureBtn.frame = CGRectMake((WIDHT - 240 * WIDHTSCALE)/2, view.frame.origin.y + view.frame.size.height + 60*HEIGHTSCALE,240*WIDHTSCALE, 48*HEIGHTSCALE);
    [sureBtn setTitle:@"修改密码" forState:(UIControlStateNormal)];
    sureBtn.layer.borderWidth = 0.01;
    sureBtn.layer.cornerRadius = 4;
    sureBtn.userInteractionEnabled = NO;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:sureBtn];
    
    
    textfieldArr = @[@"输入旧密码",@"输入新密码",@"输入您的手机号",@"输入验证码"];
    
    for (int i = 0; i < textfieldArr.count; i++) {
        UITextField *textField = [[UITextField alloc]init];
        textField.delegate = self;
        textField.tag = 1000 + i;
        textField.textColor = [UIColor colorWithRed:51/155.0 green:51/155.0 blue:51/155.0 alpha:1.0];
        textField.placeholder = textfieldArr[i];
        [textField setValue:[UIFont boldSystemFontOfSize:15*HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];
        [textField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        //把输入的文本居中显示
        textField.textAlignment = NSTextAlignmentCenter;
        UITextField *textField_oldpass = (UITextField *)[self.view viewWithTag:1000];
        UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
        UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1002];
        UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
        
        //创建通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //注册通知
    
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_oldpass];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_newpass];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_phone];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_veriCard];

        //画三条线
        UILabel *labelLine = [[UILabel alloc]init];
        labelLine.frame = CGRectMake(40 * WIDHTSCALE, 75*HEIGHTSCALE  + 40 * i*HEIGHTSCALE, self.view.frame.size.width - 80 *WIDHTSCALE, 0.5);
        labelLine.backgroundColor = [UIColor colorWithRed:102.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
                //使文本居中显示
       

        if(i < 2){
            textField.frame = CGRectMake(40 * WIDHTSCALE, 40*HEIGHTSCALE  + 40 * i*HEIGHTSCALE, self.view.frame.size.width - 80 *WIDHTSCALE, 40*HEIGHTSCALE);
        }
        if(i == 1){
           
        }
        if(i == 2){
            textField.frame = CGRectMake(40 * WIDHTSCALE, 40*HEIGHTSCALE  + 40 * i*HEIGHTSCALE, self.view.frame.size.width - 80 *WIDHTSCALE, 40*HEIGHTSCALE );
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if(i == 3){
            textField.frame = CGRectMake(40 * WIDHTSCALE, 40*HEIGHTSCALE  + 40 * i*HEIGHTSCALE ,(self.view.frame.size.width - 80 *WIDHTSCALE)/2, 40 *HEIGHTSCALE );
            textField.keyboardType = UIKeyboardTypeNumberPad;
            UILabel *garyLine = [[UILabel alloc]init];
            garyLine.frame = CGRectMake(210 *WIDHTSCALE , 40*HEIGHTSCALE + (40*3 + 5)*HEIGHTSCALE, 0.5, 20*HEIGHTSCALE  );
            garyLine.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
            
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.tag = 10001;
            btn.frame = CGRectMake(231 *WIDHTSCALE, 40*HEIGHTSCALE  + (40 * 3 + 3)*HEIGHTSCALE , 100 *WIDHTSCALE, 30 *HEIGHTSCALE  );
            [btn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithRed:104/255.0 green:173/255.0 blue:216/255.0 alpha:1.0] forState:(UIControlStateNormal)];
            btn.titleLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE ];
            [btn addTarget:self action:@selector(getVCode:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [view addSubview:btn];
            
            [view addSubview:garyLine];
        }
        
        [view addSubview:textField];
        [view addSubview:labelLine];
    }
}


#pragma mark -- 点击确定按钮
-(void)sureBtnClick:(UIButton *)btn{
    NSLog(@"确定");
    //请求找回密码的接口
    [self createReviseQuest];
}
#pragma mark -- 修改密码的接口
-(void)createReviseQuest
{
    UITextField *textField_oldpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"],@"password":textField_oldpass.text, @"newpassword":textField_newpass.text, @"mobile":textField_phone.text,@"code":textField_veriCard.text};
    NSLog(@"%@",paramter);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100107"] parameters:paramter success:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"str %@ %@", str, dic);
        //只有 retValue=203 时修改成功，其余全失败
        if (!([[dic valueForKey:@"retValue"]integerValue] == 100107)) {
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@" 错误 %@", error);
    }];
    
}
#pragma mark -- 获取密码的点击事件
-(void)getVCode:(UIButton *)sender{
    NSLog(@"获取验证码");
    
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1002];
    
    if([textField_phone.placeholder isEqualToString: @"输入您的手机号"] && textField_phone.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        timeCount = 60;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        sender.userInteractionEnabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
        //发送请求
        NSLog(@"%@",textField_phone.text);
        [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret2:@"100005"] parameters:@{@"mobile":textField_phone.text} success:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:nil];
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            NSLog(@"找回密码短信返回信息%@ %@", dic, dic[@"retMessage"]);
        } failure:^(NSError *error) {
            NSLog(@"找回密码短信请求失败");
        }];
        
    }
}


#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    UITextField *textField_oldpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];

    
    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    btn.enabled = (textField_oldpass.text.length != 0 && textField_newpass.text.length != 0 && textField_phone.text.length != 0 && textField_veriCard.text.length != 0 );
    if(btn.enabled == YES){
        btn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
        btn.userInteractionEnabled = YES;
    }else{
        btn.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0];;
    }
}
//定时器触发事件
- (void)reduceTime:(NSTimer *)coderTimer{
    timeCount--;
    if (timeCount == 0) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:10001];
        [btn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
        //停止定时器
        [timer invalidate];
    }else{
        UIButton *btn = (UIButton *)[self.view viewWithTag:10001];
        [btn setTitleColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 * WIDHTSCALE];
        NSString *str = [NSString stringWithFormat:@"%lus后重新获取", (long)timeCount];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
    }
}
//输入框的两个代理方法
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark -- 点击return 下滑
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
//    //结束编辑时整个试图返回原位
//    [textField resignFirstResponder];
//    [UIView beginAnimations:@"down" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.frame = self.view.bounds;
//    [UIView commitAnimations];
    
    return YES;
}


//收起键盘
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
//    [UIView commitAnimations];
}
#pragma mark -- 点击空白 下滑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITextField *textField_oldpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
    
    [textField_oldpass resignFirstResponder];
    [textField_newpass resignFirstResponder];
    [textField_phone resignFirstResponder];
    [textField_veriCard resignFirstResponder];
}
#pragma mark -- 返回按钮的点击响应事件
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
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
