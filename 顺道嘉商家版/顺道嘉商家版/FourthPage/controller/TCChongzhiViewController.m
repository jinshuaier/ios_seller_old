//
//  TCChongzhiViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChongzhiViewController.h"
#import "TCGetDeviceId.h"
#import "Pingpp.h"
#import "TCCMxViewController.h"

@interface TCChongzhiViewController ()
@property (nonatomic, strong) UITextField *mTextField;
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UIView *views;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) NSUserDefaults *userfault;
@end

@implementation TCChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    self.view.backgroundColor = backGgray;
    _userfault = [NSUserDefaults standardUserDefaults];

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"充值记录" style:UIBarButtonItemStyleDone target:self action:@selector(mingxi)];
    self.navigationItem.rightBarButtonItem = right;


    _views = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDHT, 60 * HEIGHTSCALE)];
    _views.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _views];

    _lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, _views.frame.size.height)];
    _lb.text = @"金额";
    _lb.font = [UIFont systemFontOfSize:20];
    _lb.textAlignment = NSTextAlignmentCenter;
    [_views addSubview: _lb];


    self.mTextField = [[UITextField alloc]initWithFrame:CGRectMake(_lb.frame.origin.x + _lb.frame.size.width + 20, 2, WIDHT -  _lb.frame.origin.x - _lb.frame.size.width - 20 - 10, _views.frame.size.height - 2)];
    self.mTextField.backgroundColor = [UIColor whiteColor];
    self.mTextField.placeholder = @"请输入充值金额";
    self.mTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.mTextField.returnKeyType = UIReturnKeyDone;
    [self.mTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_views addSubview: self.mTextField];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30 * WIDHTSCALE, _views.frame.origin.y + _views.frame.size.height + 50 * HEIGHTSCALE, WIDHT - 60 * WIDHTSCALE, 48 * HEIGHTSCALE)];
    btn.backgroundColor = btnColors;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}

- (void)textFieldDidChange:(UITextField *) textField
{
    NSString *text = textField.text;
    NSUInteger index = [text rangeOfString:@"."].location;
    if (index != NSNotFound) {
        double amount = [[text stringByReplacingOccurrencesOfString:@"." withString:@""] doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 9999999)/100];
    } else {
        double amount = [text doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 9999999)/100];
    }
    textField.text = text;
}

- (void)chongzhi{
    if ([self.mTextField.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入金额" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:0 handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [_mTextField resignFirstResponder];
        [self createBackGr];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_mTextField resignFirstResponder];
}

- (void)createBackGr{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_backView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    CGFloat w = WIDHT - 60 * WIDHTSCALE;
    _showView = [[UIView alloc]initWithFrame:CGRectMake(30 * WIDHTSCALE, HEIGHT / 2 - 120 * HEIGHTSCALE / 2, w, 170 * HEIGHTSCALE)];
    _showView.backgroundColor = [UIColor whiteColor];
    _showView.layer.cornerRadius = 8;
    [_backView addSubview: _showView];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 48 * HEIGHTSCALE)];
    lb.text = @"支付渠道";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:17];
    [_showView addSubview: lb];

    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, lb.frame.origin.y + lb.frame.size.height, w, 1)];
    lb2.backgroundColor = backGgray;
    [_showView addSubview: lb2];

    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, lb2.frame.origin.y + 1, w, 60 * HEIGHTSCALE)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_view1 addGestureRecognizer: tap1];
    [_showView addSubview: _view1];
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, 10, _view1.frame.size.height - 20, _view1.frame.size.height - 20)];
    imageview1.image = [UIImage imageNamed:@"支付宝支付"];
    [_view1 addSubview: imageview1];
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(imageview1.frame.origin.x + imageview1.frame.size.width + 20 * WIDHTSCALE, imageview1.frame.origin.y, _view1.frame.size.width - imageview1.frame.origin.x - imageview1.frame.size.width - 20 * WIDHTSCALE - 20 * WIDHTSCALE, imageview1.frame.size.height)];
    lb3.text = @"支付宝支付";
    lb3.font = [UIFont systemFontOfSize:18];
    [_view1 addSubview: lb3];

    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(0, _view1.frame.origin.y + _view1.frame.size.height, w, 1)];
    lb4.backgroundColor = backGgray;
    [_showView addSubview: lb4];

//    _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, lb4.frame.origin.y + 1, w, 60 * HEIGHTSCALE)];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [_view2 addGestureRecognizer: tap2];
//    [_showView addSubview: _view2];
//    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, 10, _view2.frame.size.height - 20, _view2.frame.size.height - 20)];
//    imageview2.image = [UIImage imageNamed:@"银联支付"];
//    [_view2 addSubview: imageview2];
//    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(imageview2.frame.origin.x + imageview2.frame.size.width + 20 * WIDHTSCALE, imageview2.frame.origin.y, _view2.frame.size.width - imageview2.frame.origin.x - imageview2.frame.size.width - 20 * WIDHTSCALE - 20 * WIDHTSCALE, imageview2.frame.size.height)];
//    lb5.text = @"微信支付";
//    lb5.font = [UIFont systemFontOfSize:18];
//    [_view2 addSubview: lb5];

}

- (void)tap:(UIGestureRecognizer *)gue{
    if (gue.view == _backView) {
        [_backView removeFromSuperview];
    }else if (gue.view == _view1){
        //支付宝支付
        [self zhifubao];
    }else if(gue.view == _view2){
        //银联支付
        
    }

}

//支付宝
- (void)zhifubao{
    [_backView removeFromSuperview];
    [SVProgressHUD showWithStatus:@"请稍候..."];
     NSDictionary *paramers = @{@"id":[self.userfault valueForKey:@"userID"], @"token":[self.userfault valueForKey:@"userToken"], @"money":self.mTextField.text, @"type":@"1", @"source":@"2", @"terminal":@"ios", @"mmdid":[TCGetDeviceId getDeviceId]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"700007"] parameters:paramers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"支付宝返回 %@", str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *idstr = dic[@"data"][@"id"];
        [SVProgressHUD dismiss];


        //掉起客户端
        TCChongzhiViewController *__weak weakself = self;
        [SVProgressHUD dismiss];
        [Pingpp createPayment:dic[@"data"][@"charge"] viewController:weakself appURLScheme:@"shundaojia" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@" eeeeeee   %@", result);
            if ([result isEqualToString:@"success"]) {
                //如果支付成功
                NSDictionary *paramter = @{@"id":[self.userfault valueForKey:@"userID"], @"token":[self.userfault valueForKey:@"userToken"], @"oid":idstr, @"appStatus":@"1", @"object":@"success", @"terminal":@"ios"};
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                [manager POST:[TCServerSecret loginAndRegisterSecret:@"700008"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                    NSLog(@"返回结果 %@", str);
                    [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                    [self performSelector:@selector(back) withObject:self afterDelay:1];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    nil;
                }];
            }else{
                NSDictionary *paramter = @{@"id":[self.userfault valueForKey:@"userID"], @"token":[self.userfault valueForKey:@"userToken"], @"oid":idstr, @"appStatus":@"-1", @"object":@"error", @"terminal":@"ios"};
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                [manager POST:[TCServerSecret loginAndRegisterSecret:@"700008"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    NSLog(@"返回结果 %@", str);
                    [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    nil;
                }];
            }

        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

//账单明细
- (void)mingxi{
    TCCMxViewController *mx = [[TCCMxViewController alloc]init];
    [self.navigationController pushViewController:mx animated:YES];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
