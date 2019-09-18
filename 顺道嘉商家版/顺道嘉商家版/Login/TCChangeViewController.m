//
//  TCChangeViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/1.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChangeViewController.h"

@interface TCChangeViewController ()<UITextFieldDelegate>

{
    UIImageView *mainimageview;
    NSArray *textfieldArr;
    //设置定时器
    NSTimer *timer;
    NSInteger timeCount;
    UIButton *eyebtn;
}

@end

@implementation TCChangeViewController

-(void)viewWillAppear:(BOOL)animated{
    //把导航栏的左边箭头后面的字体去掉
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
    UIBarButtonItem *backIetm = [[UIBarButtonItem alloc] init];
    backIetm.title = @"返回";
    [self.navigationItem setBackBarButtonItem:backIetm];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //把导航栏的左边箭头后面的字体去掉
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    //设置图片
    mainimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 250 * HEIGHTSCALE)];
    mainimageview.image = [UIImage imageNamed:@"登录背景"];
    [self.view addSubview: mainimageview];
    //创建下面的textfiled
    [self createTextField];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];;
    sureBtn.tag = 10000;
    sureBtn.frame = CGRectMake(60 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 35  + 40 * 3 + 40, self.view.frame.size.width - 120 * WIDHTSCALE, 45 *HEIGHTSCALE);
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    sureBtn.layer.borderWidth = 0.01;
    sureBtn.layer.cornerRadius = 5;
    sureBtn.userInteractionEnabled = NO;
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:sureBtn];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 创建下面4个textField
-(void)createTextField
{
    textfieldArr = @[@"输入您的新密码(6-20位)",@"输入您的手机号",@"输入您的认证身份证号",@"验证码"];
    
    for (int i = 0; i < textfieldArr.count; i++) {
        UITextField *textField = [[UITextField alloc]init];
        textField.delegate = self;
        textField.tag = 1000 + i;
        textField.placeholder = textfieldArr[i];
        [textField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        //把输入的文本居中显示
        textField.textAlignment = NSTextAlignmentLeft;
        UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
        UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
        UITextField *textField_card = (UITextField *)[self.view viewWithTag:1002];
        UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
        
        //创建通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //注册通知
        [center addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:nil];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_newpass];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_phone];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_card];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_veriCard];
        
        //画三条线
        UILabel *labelLine = [[UILabel alloc]init];
        labelLine.frame = CGRectMake(40 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 35  + 40 * i, self.view.frame.size.width - 80 *WIDHTSCALE, 0.5);
        labelLine.backgroundColor = [UIColor colorWithRed:102.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
        //显示密码和小×
        if(i == 0){
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            
            eyebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            eyebtn.frame = CGRectMake(305 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 60, 25 * HEIGHTSCALE, 25 * HEIGHTSCALE);
            [eyebtn setImage:[UIImage imageNamed:@"密码不可视图标"] forState:UIControlStateNormal];
            [eyebtn setImage:[UIImage imageNamed:@"logineye"] forState:UIControlStateSelected];
           
            [eyebtn addTarget:self action:@selector(see:) forControlEvents:UIControlEventTouchUpInside];
            eyebtn.hidden = YES;
            [self.view addSubview: eyebtn];
        }
        //使文本居中显示
        if (i == 0){
            textField.frame = CGRectMake(40 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*i ,self.view.frame.size.width - 120 *WIDHTSCALE, 40 );
        }
        
        if(i == 1){
            textField.frame = CGRectMake(40 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*i, self.view.frame.size.width - 80 *WIDHTSCALE, 40);
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
        if(i == 2){
            textField.frame = CGRectMake(40 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*i, self.view.frame.size.width - 80 *WIDHTSCALE, 40 );
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if(i == 3){
            textField.frame = CGRectMake(40 * WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*i ,(self.view.frame.size.width - 80 *WIDHTSCALE)/2, 40 );
            textField.keyboardType = UIKeyboardTypeNumberPad;
            UILabel *garyLine = [[UILabel alloc]init];
            garyLine.frame = CGRectMake(210 *WIDHTSCALE , mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*3 + 5, 0.5, 20 );
            garyLine.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
            
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.tag = 10001;
            btn.frame = CGRectMake(231 *WIDHTSCALE, mainimageview.frame.origin.y + mainimageview.frame.size.height + 50 + 40*3 + 3 , 100 *WIDHTSCALE, 30 );
            [btn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithRed:104/255.0 green:173/255.0 blue:216/255.0 alpha:1.0] forState:(UIControlStateNormal)];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(getCode:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.view addSubview:btn];
            
            [self.view addSubview:garyLine];
        }
        
        [self.view addSubview:textField];
        [self.view addSubview:labelLine];
    }
}
//当输入框编辑
- (void)change{
     UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    //如果密码不为空 显示eye按钮
    if (![textField_newpass.text isEqualToString:@""]) {
        eyebtn.hidden = NO;
    }else{
        eyebtn.hidden = YES;
    }
}
#pragma mark -- 点击观看按钮
- (void)see:(UIButton *)sender{
    sender.selected = !sender.selected;
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    if (sender.isSelected) {
        textField_newpass.secureTextEntry = NO;
    }else{
        textField_newpass.secureTextEntry = YES;
    }


}
#pragma mark -- 点击确定按钮
-(void)sureBtnClick:(UIButton *)btn{
    NSLog(@"确定");
    //请求找回密码的接口
    [self createfindQuest];
}
#pragma mark -- 找回密码的接口
-(void)createfindQuest
{
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    
    NSDictionary *paramter = @{@"mobile":textField_phone.text,@"idno":textField_card.text, @"password":textField_newpass.text, @"code":textField_veriCard.text};
    NSLog(@"%@",paramter);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100104"] parameters:paramter success:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"str %@ %@", str, dic);
        //只有 retValue=203 时修改成功，其余全失败
        if (!([[dic valueForKey:@"retValue"]integerValue] == 203)) {
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"找回成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@" 错误 %@", error);
    }];
        
}
#pragma mark -- 获取密码的点击事件
-(void)getCode:(UIButton *)sender{

   
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];

    if([textField_phone.placeholder isEqualToString: @"输入您的手机号"] && textField_phone.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if (textField_phone.text.length != 11) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"请输入正确号码"];
        }else{
            timeCount = 60;
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"获取中..."];
            sender.userInteractionEnabled = NO;
            //发送请求
            [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret2:@"100005"] parameters:@{@"mobile":textField_phone.text} success:^(id responseObject) {

                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:nil];
                [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                if ([dic[@"retValue"] intValue] == 301) {
                    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
                }
                NSLog(@"找回密码短信返回信息%@ %@", dic, dic[@"retMessage"]);
            } failure:^(NSError *error) {
                NSLog(@"找回密码短信请求失败");
            }];
        }
    }
}


#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    btn.enabled = (textField_newpass.text.length != 0 && textField_phone.text.length != 0 && textField_card.text.length != 0 && textField_veriCard.text.length != 0 );
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
        [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]forState:(UIControlStateNormal)];
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
    if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
        if (textField.tag-1000 > 0){
            //开始编辑时使整个视图整体向上移
            [UIView beginAnimations:@"up" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.view.frame = CGRectMake(0, -(textField.tag-1000)*60, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];
        }
    }else{
        if (textField.tag-1000 > 1) {
            //开始编辑时使整个视图整体向上移
            [UIView beginAnimations:@"up" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.view.frame = CGRectMake(0, -(textField.tag-1000-1)*60, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];
            
        }
  }
    return YES;
}

#pragma mark -- 点击return 下滑
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    //结束编辑时整个试图返回原位
    [textField resignFirstResponder];
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = self.view.bounds;
    [UIView commitAnimations];
    
    return YES;
}


//收起键盘
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
    [UIView commitAnimations];
}
#pragma mark -- 点击空白 下滑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_veriCard = (UITextField *)[self.view viewWithTag:1003];
    
    [textField_newpass resignFirstResponder];
    [textField_phone resignFirstResponder];
    [textField_card resignFirstResponder];
    [textField_veriCard resignFirstResponder];
    
    //结束编辑时整个试图返回原位
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = self.view.bounds;
    [UIView commitAnimations];

}
//限制字数
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    UITextField *textField_newpass = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_card = (UITextField *)[self.view viewWithTag:1002];
    
    if(textField == textField_phone){
        if(range.length + range.location > textField_phone.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_phone.text length] + [string length] - range.length;
        return newLenght <= 11;
    }else if (textField == textField_newpass){
        if(range.length + range.location > textField_newpass.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_newpass.text length] + [string length] - range.length;
        return newLenght <= 20;
    }else if (textField == textField_card){
        if(range.length + range.location > textField_card.text.length){
            return NO;
        }
        NSInteger newLenght = [textField_card.text length] + [string length] - range.length;
        return newLenght <= 18;
    }
    else{
        return YES;
    }
}

#pragma mark -- 返回按钮的点击响应事件
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
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
