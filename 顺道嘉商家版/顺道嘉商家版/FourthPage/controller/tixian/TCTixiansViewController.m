//
//  TCTixiansViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTixiansViewController.h"
#import "TCAddYinhkViewController.h"
#import "TCYinhangkaViewController.h"
#import "TCShuomingViewController.h"
#import "TCTXjluViewController.h"

@interface TCTixiansViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *haveView;
@property (nonatomic, strong) UILabel *namelb;
@property (nonatomic, strong) UIView *aview;
@property (nonatomic, strong) UILabel *numlb;
@property (nonatomic, strong) UIView *daozhangView;
@property (nonatomic, strong) UIView *zhuanchuView;
@property (nonatomic, strong) UITextField *moneyTf;
@property (nonatomic, strong) UIButton *queBtn;
@property (nonatomic, strong) NSMutableArray *messArr;
@property (nonatomic, strong) NSString *cardid;
@end

@implementation TCTixiansViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get:) name:@"cardMes" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(he) name:@"refresh" object:nil];
}

- (void)get:(NSNotification *)not{
    NSLog(@"cardid --- %@", not.userInfo[@"id"]);
    NSDictionary *dic = not.userInfo[@"id"];
    _cardid = dic[@"id"];
    _namelb.text = dic[@"bank"];
    NSString *strs = dic[@"cardid"];
    _numlb.text = [NSString stringWithFormat:@"尾号%@  %@", [strs substringFromIndex:(strs.length - 4)], dic[@"type"]];
}

- (void)he{
    [self request];
}

//请求 判断是否有银行卡
- (void)request{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]};
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100116"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"返回信息%@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"]) {
            //如果银行卡
            [_messArr addObjectsFromArray:dic[@"data"]];
            [_backView removeFromSuperview];
            [self has];

        }else{
            [_haveView removeFromSuperview];
            //无银行卡
            [self hasno];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGgray;
    self.title = @"提现";
    _userdefaults = [NSUserDefaults standardUserDefaults];
    _messArr = [NSMutableArray array];

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提现记录" style:UIBarButtonItemStyleDone target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem  = right;

    [self request];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //控制长度
    if(range.location>=20)
        return NO;
    
    const char * ch=[string cStringUsingEncoding:NSUTF8StringEncoding];
    if(*ch == 0)
        return YES;
    //字符0－9 和 .
    if( *ch != 46 && ( *ch<48 || *ch>57) )
        return NO;
    
    //有了小数点
    if([_moneyTf.text rangeOfString:@"."].length==1)
    {
        NSUInteger length=[textField.text rangeOfString:@"."].location;
        
        //小数点后面两位小数 且不能再是小数点
        if([[_moneyTf.text substringFromIndex:length] length]>2 || *ch ==46)   //3表示后面小数位的个数。。
            
            return NO;
    }
    
    return YES;
}
//- (void)textFieldDidChange:(UITextField *) textField
//{
//    NSString *text = textField.text;
//    NSUInteger index = [text rangeOfString:@"."].location;
//    if (index != NSNotFound) {
//        double amount = [[text stringByReplacingOccurrencesOfString:@"." withString:@""] doubleValue];
//        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 9999999)/100];
//    } else {
//        double amount = [text doubleValue];
//        text = [NSString stringWithFormat:@"%.02f", MIN(amount, 9999999)/100];
//    }
//    textField.text = text;
//}

- (void)has{
    _haveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64)];
    [self.view addSubview: _haveView];
    _aview = [[UIView alloc]initWithFrame:CGRectMake(2, 2, WIDHT - 4, 100 * HEIGHTSCALE)];
    _aview.layer.cornerRadius = 5;
    _aview.layer.masksToBounds = YES;
    _aview.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chose)];
    [_aview addGestureRecognizer:tap];
    [_haveView addSubview:_aview];

    _namelb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDHT - 20 - 50, (_aview.frame.size.height - 30) / 2)];
    _namelb.text = _messArr[0][@"bank"];
    _cardid = _messArr[0][@"id"];
    _namelb.numberOfLines = 0;
    _namelb.font = [UIFont systemFontOfSize:15];
    [_aview addSubview:_namelb];

    _numlb = [[UILabel alloc]initWithFrame:CGRectMake(10, _namelb.frame.origin.y + _namelb.frame.size.height + 10, WIDHT - 20 - 50, (_aview.frame.size.height - 30) / 2)];
    NSString *strs = _messArr[0][@"cardid"];
    if (strs.length > 4) {
        _numlb.text = [NSString stringWithFormat:@"尾号%@  %@", [strs substringFromIndex: (strs.length - 4)], _messArr[0][@"type"]];
    }else{
        _numlb.text = [NSString stringWithFormat:@"尾号%@  %@", strs, _messArr[0][@"type"]];
    }
    
    _numlb.numberOfLines = 0;
    _numlb.font = [UIFont systemFontOfSize:15];
    [_aview addSubview:_numlb];


    UILabel *biaozhilb = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 10 - 30, 10, 30, _aview.frame.size.height - 20)];
    biaozhilb.text = @">";
    biaozhilb.font = [UIFont systemFontOfSize:20];
    biaozhilb.textAlignment = NSTextAlignmentCenter;
    [_aview addSubview:biaozhilb];

    //创建到账时间
    _daozhangView = [[UIView alloc]initWithFrame:CGRectMake(0, _aview.frame.origin.y + _aview.frame.size.height + 20, WIDHT, 60 * HEIGHTSCALE)];
    _daozhangView.backgroundColor = [UIColor whiteColor];
    [_haveView addSubview:_daozhangView];

    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, _daozhangView.frame.size.height - 20)];
    timeLb.textAlignment = NSTextAlignmentCenter;
    timeLb.text = @"到账时间";
    [_daozhangView addSubview:timeLb];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(timeLb.frame.size.width + timeLb.frame.origin.x, timeLb.frame.origin.y, WIDHT - timeLb.frame.size.width - 20, timeLb.frame.size.height)];
    lb.text = @"24小时内到账";
    lb.font = [UIFont systemFontOfSize:13];
    lb.textAlignment = NSTextAlignmentCenter;
    [_daozhangView addSubview:lb];



    //创建转出金额
    _zhuanchuView = [[UIView alloc]initWithFrame:CGRectMake(0, _daozhangView.frame.origin.y + _daozhangView.frame.size.height + 20, WIDHT, 60 *HEIGHTSCALE)];
    _zhuanchuView.backgroundColor = [UIColor whiteColor];
    [_haveView addSubview:_zhuanchuView];

    UILabel *momeny = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, _zhuanchuView.frame.size.height - 20)];
    momeny.textAlignment = NSTextAlignmentCenter;
    momeny.text = @"转出金额";
    [_zhuanchuView addSubview:momeny];

    _moneyTf = [[UITextField alloc]initWithFrame:CGRectMake(momeny.frame.origin.x + momeny.frame.size.width + 10, 10, WIDHT - momeny.frame.size.width - 10 - 20 - 20, _zhuanchuView.frame.size.height - 20)];
    _moneyTf.placeholder = [NSString stringWithFormat:@"本次可转出余额%@", _ye];
    _moneyTf.font = [UIFont systemFontOfSize:14];
    _moneyTf.textAlignment = NSTextAlignmentCenter;
    _moneyTf.delegate = self;
//    _moneyTf.keyboardType = UIKeyboardTypeNumberPad;
//    [_moneyTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_zhuanchuView addSubview:_moneyTf];

    UILabel *lbb = [[UILabel alloc]initWithFrame:CGRectMake(_moneyTf.frame.origin.x + _moneyTf.frame.size.width, 10, 18, _zhuanchuView.frame.size.height - 20)];
    lbb.text = @"元";
    lbb.textColor = [UIColor redColor];
    lbb.font = [UIFont systemFontOfSize:14];
    [_zhuanchuView addSubview:lbb];


    UILabel *laab = [[UILabel alloc]initWithFrame:CGRectMake(10,  _zhuanchuView.frame.origin.y + _zhuanchuView.frame.size.height + 2, WIDHT / 2 + 20, 15)];
    laab.text = @"";
    laab.textColor = Color;
    laab.font = [UIFont systemFontOfSize:10];
    [_haveView addSubview:laab];

    UIButton *shuom = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT / 2, _zhuanchuView.frame.origin.y + _zhuanchuView.frame.size.height + 2, WIDHT / 2 - 10 * WIDHTSCALE, 15 * HEIGHTSCALE)];
    [shuom setTitle:@"提现说明" forState:UIControlStateNormal];
    [shuom setTitleColor:Color forState:UIControlStateNormal];
    shuom.titleLabel.font = [UIFont systemFontOfSize:10 * HEIGHTSCALE];
    shuom.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shuom addTarget:self action:@selector(shuoming) forControlEvents:UIControlEventTouchUpInside];
    [_haveView addSubview:shuom];



    UIImageView *imageviews = [[UIImageView alloc]initWithFrame:CGRectMake(0, laab.frame.origin.y + laab.frame.size.height, WIDHT, 180 * HEIGHTSCALE)];
    imageviews.image = [UIImage imageNamed:@"date.png"];
    [_haveView addSubview:imageviews];

    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, laab.frame.origin.y + laab.frame.size.height + 5, WIDHT, 180 * HEIGHTSCALE)];
    view1.backgroundColor = [UIColor whiteColor];
    [_haveView addSubview: view1];
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, 30)];
    lb1.text = @"  提现到账时间:";
    lb1.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1];
    [view1 addSubview: lb1];
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, lb1.frame.size.height + lb1.frame.origin.y + 5, view1.frame.size.width - 20, 70)];
    lb2.text = @"     工作日24小时内到账，节假日顺延!";
    lb2.font = [UIFont systemFontOfSize:15];
    lb2.numberOfLines = 0;
    [view1 addSubview: lb2];


    //创建确认转出按钮
    _queBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _haveView.frame.size.height - 50 - 10, WIDHT - 20, 50)];
    _queBtn.backgroundColor = btnColors;
    [_queBtn setTitle:@"确认转出" forState:UIControlStateNormal];
    [_queBtn setTitleColor:BtnTitleColor forState:UIControlStateNormal];
    _queBtn.layer.cornerRadius = 5;
    _queBtn.layer.masksToBounds = YES;
    [_queBtn addTarget: self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_haveView addSubview:_queBtn];
}

- (void)hasno{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64)];
    [self.view addSubview: _backView];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT / 2 - WIDHT / 6, 40 * HEIGHTSCALE, WIDHT / 3, WIDHT / 3)];
    imageview.image = [UIImage imageNamed:@"bangdingk"];
    //    imageview.backgroundColor = [UIColor redColor];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.autoresizesSubviews = YES;
    imageview.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_backView addSubview:imageview];

    //创建字体
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y + imageview.frame.size.height, WIDHT, 30)];
    label.text = @"您还没有添加可用银行卡";
    label.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:label];

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30 * WIDHTSCALE, label.frame.origin.y + label.frame.size.height + 5, WIDHT / 2, 30)];
    label2.text = @"您的可提现金额:";
    label2.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:label2];

    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(label2.frame.origin.x + label2.frame.size.width, label2.frame.origin.y, WIDHT / 2, 30)];
    label3.text = [NSString stringWithFormat:@"%@", _ye];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.textColor = [UIColor redColor];
    [_backView addSubview:label3];

    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, label3.frame.origin.y + label3.frame.size.height + 40 * HEIGHTSCALE, WIDHT, 160 * HEIGHTSCALE)];
    views.backgroundColor = [UIColor whiteColor];
    [_backView addSubview: views];
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDHT, 20)];
    lb1.text = @"如何提现?";
    [views addSubview: lb1];
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(58 * WIDHTSCALE, lb1.frame.size.height + 10 + 10, WIDHT - 120 * WIDHTSCALE, 20)];
    lb2.font = [UIFont systemFontOfSize:14];
    lb2.text = @"第一步:先确定您有可提现的余额";
    [views addSubview: lb2];
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(58 * WIDHTSCALE, lb2.frame.size.height + lb2.frame.origin.y + 2, WIDHT - 120 * WIDHTSCALE, 20)];
    lb3.font = [UIFont systemFontOfSize:14];
    lb3.text = @"第二部:确定已经绑定了您的银行卡";
    [views addSubview: lb3];
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(58 * WIDHTSCALE, lb3.frame.size.height + lb3.frame.origin.y + 2, WIDHT - 120 * WIDHTSCALE, 20)];
    lb4.font = [UIFont systemFontOfSize:14];
    lb4.text = @"第三步:转出金额";
    [views addSubview: lb4];
    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(58 * WIDHTSCALE, lb4.frame.size.height + lb4.frame.origin.y + 2, WIDHT - 120 * WIDHTSCALE, 20)];
    lb5.font = [UIFont systemFontOfSize:14];
    lb5.text = @"第四部:等待金额的到账";
    [views addSubview: lb5];

    views.frame = CGRectMake(0, label3.frame.origin.y + label3.frame.size.height + 20 * HEIGHTSCALE, WIDHT, lb5.frame.origin.y + lb5.frame.size.height + 5);

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30 * WIDHTSCALE, views.frame.origin.y + views.frame.size.height + 20 * HEIGHTSCALE, WIDHT - 60 * WIDHTSCALE, 48 * HEIGHTSCALE)];
    btn.backgroundColor = btnColors;
    [btn setTitle:@"马上添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    [btn addTarget: self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview: btn];

}

- (void)right{
    TCTXjluViewController *xj = [[TCTXjluViewController alloc]init];
    [self.navigationController pushViewController:xj animated:YES];
}

//去添加银行卡
- (void)go{
    TCAddYinhkViewController *add = [[TCAddYinhkViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_moneyTf resignFirstResponder];
}


//确认转出
- (void)queding{
    NSLog(@"卡号 %@", _cardid);
    if ([_moneyTf.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
    }else{
        [SVProgressHUD showWithStatus:@"操作中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"money":_moneyTf.text, @"bankid":_cardid};
        [manager POST:[TCServerSecret loginAndRegisterSecret:@"700003"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"请求提现返回结果 %@", str);
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"retMessage"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            nil;
        }];
    }
}


//提现说明
- (void)shuoming{
    TCShuomingViewController *shuo = [[TCShuomingViewController alloc]init];
    [self.navigationController pushViewController:shuo animated:YES];
}

- (void)chose{
    TCYinhangkaViewController *yi = [[TCYinhangkaViewController alloc]init];
    yi.isCome = YES;
    [self.navigationController pushViewController:yi animated:YES];
}

//屏幕上移
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _moneyTf) {
        if ([UIScreen mainScreen].bounds.size.height <= IS_IPHONE_5) {
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:0.3];
            self.view.frame = CGRectMake(0.0f, -30.0, WIDHT, HEIGHT); //64-216
            [UIView commitAnimations];
        }
    }
}

//屏幕恢复
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:@"ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0.0f, 64.0f, WIDHT, HEIGHT); //64-216
    [UIView commitAnimations];
}



@end
