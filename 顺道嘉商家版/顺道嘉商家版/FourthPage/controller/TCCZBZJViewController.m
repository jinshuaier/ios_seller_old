//
//  TCCZBZJViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/3/3.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCZBZJViewController.h"
#import "TCBZJPayView.h"
#import "TCKuaiqianViewController.h"
#import "TCHtmlViewController.h"

@interface TCCZBZJViewController ()
@property (nonatomic, strong) UILabel  *moneylb;
@property (nonatomic, strong) UILabel  *committimelb;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) NSUserDefaults *defaulte;
@property (nonatomic, assign) BOOL isCommit;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, assign) BOOL isZhuanchu;//判断是否可以转出
@end

@implementation TCCZBZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值保证金";
    self.view.backgroundColor = TCUIColorFromRGB(0xf2f2f2);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"保证金说明" style:UIBarButtonItemStyleDone target:self action:@selector(explain)];
    self.navigationItem.rightBarButtonItem = right;
    _defaulte = [NSUserDefaults standardUserDefaults];
    
    [self request];
}

- (void)request{
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSDictionary *paramter = @{@"id":[_defaulte valueForKey:@"userID"], @"token":[_defaulte valueForKey:@"userToken"], @"shopid":_shopid};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900030"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic) {
            _dic = jsonDic[@"data"];
            _isZhuanchu = [[NSString stringWithFormat:@"%@", _dic[@"status"]] isEqualToString:@"1"]? YES : NO;
            _isCommit = [jsonDic[@"retValue"] intValue] > 0 ? YES : NO;
            [self createView];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)createView{
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 80)];
    topview.backgroundColor = TCUIColorFromRGB(0xe5f6ff);
    [self.view addSubview: topview];
    
    //保证金
    _moneylb = [[UILabel alloc]initWithFrame:topview.bounds];
    _moneylb.textColor = TCUIColorFromRGB(0x2ea8e6);
    _moneylb.textAlignment = NSTextAlignmentCenter;
    if (_isCommit) {
        _moneylb.text = [NSString stringWithFormat:@"￥%@", _dic[@"money"]];
    }else{
        _moneylb.text = @"￥0.00";
    }
    _moneylb.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview: _moneylb];
    
    
    _committimelb = [[UILabel alloc]initWithFrame:CGRectMake(0, _moneylb.frame.origin.y + _moneylb.frame.size.height - 12 - 8, WIDHT, 12)];
    
    _committimelb.textColor = RGB(100, 140, 160);
    _committimelb.font = [UIFont systemFontOfSize:12];
    _committimelb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _committimelb];
    if (_isCommit) {
        //提交时间
        _committimelb.text = [NSString stringWithFormat:@"提交时间:%@", _dic[@"createTime"]];
    }else{
        _committimelb.text = [NSString stringWithFormat:@"充值金额为￥3000"];
    }
    
    UIView *midview = [[UIView alloc]initWithFrame:CGRectMake(0, topview.frame.size.height, WIDHT, 328 / 2)];
    midview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: midview];
    
    if (_isCommit) {
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, midview.frame.origin.y + midview.frame.size.height + 6, WIDHT - 10, 12)];
        lb2.font = [UIFont systemFontOfSize:12];
        lb2.textColor = TCUIColorFromRGB(0x2ea8e6);
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.text = @"转出到余额后即可提现";
        [self.view addSubview: lb2];
    }
    
    UILabel *tiplb = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, WIDHT - 5, 12)];
    tiplb.text = @"保证金冻结期为1年，冻结期内保证金无法提现";
    tiplb.font = [UIFont systemFontOfSize:12];
    tiplb.textAlignment = NSTextAlignmentCenter;
    tiplb.textColor = TCUIColorFromRGB(0xc4c4c4);
    [midview addSubview: tiplb];
    
    //提交按钮
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkBtn.frame = CGRectMake(WIDHT / 2 - 90, tiplb.frame.origin.y + tiplb.frame.size.height + 60, 180, 44);
    
    _checkBtn.layer.cornerRadius = 22
    ;
    _checkBtn.layer.masksToBounds = YES;
    if (_isCommit) {
        if (_isZhuanchu) {
            _checkBtn.backgroundColor = TCUIColorFromRGB(0x57d9d9);
            [_checkBtn setTitle:@"转出保证金" forState:UIControlStateNormal];
            _checkBtn.userInteractionEnabled = YES;
        }else{
            _checkBtn.backgroundColor = TCUIColorFromRGB(0xe6e6e6);
            [_checkBtn setTitle:@"转出保证金" forState:UIControlStateNormal];
            _checkBtn.userInteractionEnabled = NO;
        }
    }else{
        _checkBtn.backgroundColor = TCUIColorFromRGB(0x57d9d9);
        [_checkBtn setTitle:@"充值保证金" forState:UIControlStateNormal];
        _checkBtn.userInteractionEnabled = YES;
    }
    [_checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    [midview addSubview: _checkBtn];
    
    //联系方式
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT - 64 - 20 - 12, WIDHT, 12)];
    lb.font = [UIFont systemFontOfSize:12];
    lb.text = @"如有疑问可拨打免费客服热线：400-0111-228";
    lb.textColor = TCUIColorFromRGB(0x2ea8e6);
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: lb];
}

- (void)check{
    if (_isZhuanchu){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"转出金额到余额" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self zhuanchu];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }else{
        [TCBZJPayView showPayView:_shopid andpaysuccess:^(NSString *charge) {
            if (![charge isEqualToString:@""]) {
                TCKuaiqianViewController *kauiqia = [[TCKuaiqianViewController alloc]init];
                kauiqia.html = charge;
                [kauiqia backRefresh:^{
                    [self request];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
                }];
                [self.navigationController pushViewController: kauiqia  animated:YES];
            }else{
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self request];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
            }
        }];
    }
}

- (void)explain{
    TCHtmlViewController *html = [[TCHtmlViewController alloc]init];
    html.html = @"https://sellerapi.moumou001.com/h5/bond-view";
    html.title = @"保证金说明";
    [self.navigationController pushViewController:html animated:YES];
}

//转出到余额
- (void)zhuanchu{
    NSDictionary *paramter = @{@"id":[_defaulte valueForKey:@"userID"], @"token":[_defaulte valueForKey:@"userToken"], @"shopid":_shopid, @"bid": _dic[@"id"], @"terminal":@"iOS", @"deviceid":@"iphone"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200026"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic) {
            if ([[NSString stringWithFormat:@"%@", jsonDic[@"retValue"]] intValue] > 0) {
                [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self request];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
    
}







@end
