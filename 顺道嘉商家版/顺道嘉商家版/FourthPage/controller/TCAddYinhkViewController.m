//
//  TCAddYinhkViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddYinhkViewController.h"

@interface TCAddYinhkViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@end

@implementation TCAddYinhkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    self.view.backgroundColor = backGgray;

    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDHT - 20, 40)];
    lb.text = @"    为方便以后给您转账，请填写正确信息，以免造成不必要的损失，填写信息后，请仔细核对无误后方可绑定";
    lb.textColor = [UIColor redColor];
    lb.numberOfLines = 0;
//    lb.backgroundColor = [UIColor greenColor];
    lb.font = [UIFont systemFontOfSize:14];
    [self.view addSubview: lb];

    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, lb.frame.origin.y + lb.frame.size.height + 10, WIDHT, HEIGHT  - 400 * HEIGHTSCALE)];
    views.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:views];

    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, (views.frame.size.height - 4) /  5)];
    name.font = [UIFont systemFontOfSize:17];
    name.text = @"持卡人";
    //    name.backgroundColor = [UIColor redColor];
    [views addSubview:name];
    _nametf = [[UITextField alloc]initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 8, 12, WIDHT - name.frame.size.width - 10 - 8, name.frame.size.height - 10)];
    _nametf.placeholder = @"账号开户所用姓名";
    //    _nametf.backgroundColor = [UIColor redColor];
    _nametf.font = [UIFont systemFontOfSize:14];
    [views addSubview:_nametf];
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, name.frame.origin.y + name.frame.size.height, WIDHT - 20, 1)];
    imageview1.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [views addSubview:imageview1];

    UILabel *cardnum = [[UILabel alloc]initWithFrame:CGRectMake(10, imageview1.frame.origin.y + 1, 70, (views.frame.size.height - 4) /  5)];
    cardnum.text = @"卡号";
    cardnum.font = [UIFont systemFontOfSize:17];
    //    cardnum.backgroundColor = [UIColor redColor];
    [views addSubview:cardnum];
    _cardNumtf = [[UITextField alloc]initWithFrame:CGRectMake(cardnum.frame.origin.x + cardnum.frame.size.width + 8, imageview1.frame.origin.y + 8, WIDHT - cardnum.frame.size.width - 10 - 8, cardnum.frame.size.height - 10)];
    _cardNumtf.placeholder = @"银行卡号";
    _cardNumtf.font = [UIFont systemFontOfSize:14];
    //    _cardNumtf.backgroundColor = [UIColor redColor];
    [views addSubview:_cardNumtf];
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, cardnum.frame.origin.y + cardnum.frame.size.height, WIDHT - 20, 1)];
    imageview2.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [views addSubview:imageview2];

    UILabel *bankname = [[UILabel alloc]initWithFrame:CGRectMake(10, imageview2.frame.origin.y + 1, 70, (views.frame.size.height - 4) / 5)];
    bankname.text = @"开户银行";
    bankname.font = [UIFont systemFontOfSize:17];
    [views addSubview:bankname];
    _bankNametf = [[UITextField alloc]initWithFrame:CGRectMake(bankname.frame.origin.x + bankname.frame.size.width + 8, imageview2.frame.origin.y + 8, WIDHT - bankname.frame.size.width - 10 - 8, bankname.frame.size.height - 10)];
    _bankNametf.placeholder = @"开户银行的名称";
    _bankNametf.font = [UIFont systemFontOfSize:14];
    [views addSubview:_bankNametf];
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, bankname.frame.origin.y + bankname.frame.size.height, WIDHT - 20, 1)];
    imageview3.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [views addSubview:imageview3];

    UILabel *idnum = [[UILabel alloc]initWithFrame:CGRectMake(10, imageview3.frame.origin.y + 1, 70, (views.frame.size.height - 4) / 5)];
    idnum.text = @"身份证号";
    idnum.font = [UIFont systemFontOfSize:17];
    [views addSubview:idnum];
    _idnumtf = [[UITextField alloc]initWithFrame:CGRectMake(idnum.frame.origin.x + idnum.frame.size.width + 8, imageview3.frame.origin.y + 8, WIDHT - idnum.frame.size.width - 10 - 8, idnum.frame.size.height - 10)];
    _idnumtf.placeholder = @"身份证号必须与该账号实名认证信息一致";
    _idnumtf.font = [UIFont systemFontOfSize:14];
    [views addSubview:_idnumtf];
    UIImageView *imageview4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, idnum.frame.origin.y + idnum.frame.size.height, WIDHT - 20, 1)];
    imageview4.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [views addSubview:imageview4];

    UILabel *phonenum = [[UILabel alloc]initWithFrame:CGRectMake(10, imageview4.frame.origin.y + 1, 70, (views.frame.size.height - 4) / 5)];
    phonenum.text = @"手机号";
    phonenum.font = [UIFont systemFontOfSize:17];
    [views addSubview:phonenum];
    _phoneNumtf = [[UITextField alloc]initWithFrame:CGRectMake(phonenum.frame.origin.x + phonenum.frame.size.width + 8, imageview4.frame.origin.y + 8, WIDHT - phonenum.frame.size.width - 10 - 8, phonenum.frame.size.height - 10)];
    _phoneNumtf.placeholder = @"卡户时银行预留手机号";
    _phoneNumtf.font = [UIFont systemFontOfSize:14];
    [views addSubview:_phoneNumtf];

    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(50 * WIDHTSCALE, views.frame.origin.y + views.frame.size.height + 40 * HEIGHTSCALE, WIDHT - 100 * WIDHTSCALE, 48 * HEIGHTSCALE);
    _btn.backgroundColor = btnColors;
    [_btn setTitle:@"确认添加" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 5;
    [_btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _btn];


    //设置tf代理
    _nametf.delegate = self;
    _cardNumtf.delegate = self;
    _bankNametf.delegate = self;
    _idnumtf.delegate = self;
    _phoneNumtf.delegate = self;
    //设置tf键盘类型
    _cardNumtf.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumtf.keyboardType = UIKeyboardTypeNumberPad;
    _userdefaults  = [NSUserDefaults standardUserDefaults];
}

//提交方法
- (void)commit{
    if (![_nametf.text isEqualToString:@""] && ![_cardNumtf.text isEqualToString:@""] && ![_bankNametf.text isEqualToString:@""] && ![_idnumtf.text isEqualToString:@""] && ![_phoneNumtf.text isEqualToString:@""]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"提交中..."];
        NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"cardid":_cardNumtf.text, @"certifId":_idnumtf.text, @"bank":_bankNametf.text, @"name":_nametf.text, @"mobile":_phoneNumtf.text};
        [manager POST:[TCServerSecret loginAndRegisterSecret:@"100115"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"绑定返回%@", str);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"retMessage"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([dic[@"retMessage"] isEqualToString:@"绑定成功"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            nil;
        }];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整！"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nametf resignFirstResponder];
    [_cardNumtf resignFirstResponder];
    [_bankNametf resignFirstResponder];
    [_idnumtf resignFirstResponder];
    [_phoneNumtf resignFirstResponder];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];

}

//屏幕上移
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _idnumtf) {
        if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:0.3];
            self.view.frame = CGRectMake(0.0f, -30.0, self.view.frame.size.width, self.view.frame.size.height); //64-216
            [UIView commitAnimations];
        }
    }
    if (textField == _phoneNumtf) {
        if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:0.3];
            self.view.frame = CGRectMake(0.0f, -80.0, self.view.frame.size.width, self.view.frame.size.height); //64-216
            [UIView commitAnimations];
        }
    }
}

//屏幕恢复
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
    [UIView commitAnimations];
}


@end
