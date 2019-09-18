//
//  TCChongZhiBZJViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/16.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChongZhiBZJViewController.h"
#import "TCHtmlViewController.h"
#import "TCYuePayHub.h"
#import "TCDeliverView.h"

@interface TCChongZhiBZJViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel  *committimelb;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) NSUserDefaults *defaulte;
@property (nonatomic, assign) BOOL isCommit;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, assign) BOOL isZhuanchu;//判断是否可以转出
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UITextField *momeytf;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation TCChongZhiBZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值保证金";
    self.view.backgroundColor = TCUIColorFromRGB(0xf2f2f2);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStyleDone target:self action:@selector(explain)];
    self.navigationItem.rightBarButtonItem = right;
    _defaulte = [NSUserDefaults standardUserDefaults];
    
    [self createView];
}

- (void)createView{
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, WIDHT - 24, 17)];
    title1.text = @"输入前请和服务人员进行确认";
    title1.font = [UIFont systemFontOfSize:12];
    title1.textColor = TCUIColorFromRGB(0x24a7f2);
    [self.view addSubview: title1];
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, title1.frame.origin.y + title1.frame.size.height + 8, WIDHT, 112)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: topview];
    
    //充值保证金金额
    _committimelb = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, WIDHT - 12, 22)];
    _committimelb.textColor = TCUIColorFromRGB(0x4c4c4c);
    _committimelb.font = [UIFont systemFontOfSize:16];
    _committimelb.text = @"充值保证金金额：";
    [topview addSubview: _committimelb];
    
    //充值金额
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(12, 16 + _committimelb.frame.origin.y + _committimelb.frame.size.height, 25, 42)];
    title2.text = @"￥";
    title2.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    title2.textAlignment = NSTextAlignmentCenter;
    [topview addSubview: title2];
    _momeytf = [[UITextField alloc]initWithFrame:CGRectMake(title2.frame.origin.x + title2.frame.size.width + 8, _committimelb.frame.origin.y + _committimelb.frame.size.height + 16, WIDHT - 12 - (title2.frame.origin.x + title2.frame.size.width + 8), 42)];
    _momeytf.placeholder = @"0.00";
    _momeytf.delegate = self;
    _momeytf.keyboardType = UIKeyboardTypeDecimalPad;
    _momeytf.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    [_momeytf addTarget:self action:@selector(checkTextfiled) forControlEvents:UIControlEventEditingChanged];
    [topview addSubview: _momeytf];
    
    
    UIView *midview = [[UIView alloc]initWithFrame:CGRectMake(0, topview.frame.origin.y + topview.frame.size.height + 4, WIDHT, 102)];
    midview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: midview];
    //填写服务人员编码
    _codeTF = [[UITextField alloc]initWithFrame:CGRectMake(WIDHT / 2 - 248 / 2, 20, 248, 41)];
    _codeTF.backgroundColor = [TCUIColorFromRGB(0x24a7f2)colorWithAlphaComponent:0.1];
    _codeTF.textAlignment = NSTextAlignmentCenter;
    _codeTF.layer.cornerRadius = 41 / 2;
    _codeTF.layer.masksToBounds = YES;
    _codeTF.delegate = self;
    _codeTF.font = [UIFont boldSystemFontOfSize:15];
    _codeTF.textColor = TCUIColorFromRGB(0x333333);
    _codeTF.placeholder = @"填写服务人员编码";
    [_codeTF addTarget:self action:@selector(checkTextfiled) forControlEvents:UIControlEventEditingChanged];
    [midview addSubview: _codeTF];
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, _codeTF.frame.origin.y + _codeTF.frame.size.height + 8, WIDHT, 17)];
    title3.textAlignment = NSTextAlignmentCenter;
    title3.text = @"无服务人员请咨询客服";
    title3.font = [UIFont systemFontOfSize:12];
    title3.textColor = TCUIColorFromRGB(0x999999);
    [midview addSubview: title3];
    
    _gradientLayer = [CAGradientLayer layer];
    //提交按钮
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkBtn.frame = CGRectMake(12, midview.frame.origin.y + midview.frame.size.height + 48, WIDHT - 24, 48);
    [_checkBtn.layer addSublayer: [self addlayer: @[(__bridge id)TCUIColorFromRGB(0xdedede).CGColor, (__bridge id)TCUIColorFromRGB(0xcccccc).CGColor]]];
    [_checkBtn setTitle:@"提交保证金" forState:UIControlStateNormal];
    _checkBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [_checkBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    _checkBtn.userInteractionEnabled = NO;
    [self.view addSubview: _checkBtn];
    
    
    //联系方式
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT - 64 - 20 - 12, WIDHT, 12)];
    lb.font = [UIFont systemFontOfSize:12];
    lb.text = @"如有疑问可拨打免费客服热线：400-0111-228";
    lb.textColor = TCUIColorFromRGB(0x999999);
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: lb];
    
}

- (CAGradientLayer *)addlayer:(NSArray *)colorArr{
    _gradientLayer.colors = colorArr;
    _gradientLayer.locations = @[@0.3, @0.6, @1.0];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1.0, 0);
    _gradientLayer.frame = _checkBtn.bounds;
    _gradientLayer.shadowOpacity = 0.3;//阴影透明度
    _gradientLayer.shadowColor = [UIColor grayColor].CGColor;//颜色
    _gradientLayer.shadowRadius = 3;//扩散范围
    _gradientLayer.shadowOffset = CGSizeMake(1, 2);//范围
    _gradientLayer.cornerRadius = 22;
    return _gradientLayer;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _momeytf) {
        const char *ch=[string cStringUsingEncoding:NSUTF8StringEncoding];
        if ((*ch <= 57 && *ch >= 48) || *ch == 0) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

//输入框监测
- (void)checkTextfiled{
    if (!_isChongzhi) {
        //表示重查看保证金页面进入
        if ([_momeytf.text intValue] > [_maxmoney intValue]) {
            _momeytf.text = _maxmoney;
            [TCDeliverView  ShowHubViewWith:[NSString stringWithFormat:@"您当前保证金最多可提交￥%@", _maxmoney]];
        }
    }else{
        if ([_momeytf.text intValue] > 3000) {
            _momeytf.text = @"3000";
            [TCDeliverView ShowHubViewWith:@"保证金最多可提交￥3000"];
        }
    }
    if (![_codeTF.text isEqualToString:@""] && ![_momeytf.text isEqualToString:@""]) {
        //亮
        _gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1ac6ff).CGColor,  (__bridge id)TCUIColorFromRGB(0x24a7f2).CGColor];
        _gradientLayer.locations = @[@0.3, @0.6, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        _gradientLayer.frame = _checkBtn.bounds;
        _gradientLayer.shadowOpacity = 0.3;//阴影透明度
        _gradientLayer.shadowColor = [UIColor grayColor].CGColor;//颜色
        _gradientLayer.shadowRadius = 3;//扩散范围
        _gradientLayer.shadowOffset = CGSizeMake(1, 2);//范围
        _gradientLayer.cornerRadius = 22;
        [_checkBtn setTitle:@"提交保证金" forState:UIControlStateNormal];
        _checkBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _checkBtn.userInteractionEnabled = YES;
    }else{
        //不亮
        _gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0xdedede).CGColor, (__bridge id)TCUIColorFromRGB(0xcccccc).CGColor];
        _gradientLayer.locations = @[@0.3, @0.6, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        _gradientLayer.frame = _checkBtn.bounds;
        _gradientLayer.shadowOpacity = 0.3;//阴影透明度
        _gradientLayer.shadowColor = [UIColor grayColor].CGColor;//颜色
        _gradientLayer.shadowRadius = 3;//扩散范围
        _gradientLayer.shadowOffset = CGSizeMake(1, 2);//范围
        _gradientLayer.cornerRadius = 22;
        [_checkBtn setTitle:@"提交保证金" forState:UIControlStateNormal];
        _checkBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _checkBtn.userInteractionEnabled = NO;
    }
}
//
//- (void)check{
//    [_codeTF resignFirstResponder];
//    [_momeytf resignFirstResponder];
//    [TCBZJPayView showPayView:_shopid andCode:_codeTF.text andPayMoney:_momeytf.text andpaysuccess:^(NSDictionary *charge) {
//        if (charge) {
//            //跳转快钱
//            TCKuaiqianViewController *kauiqia = [[TCKuaiqianViewController alloc]init];
//            kauiqia.html = charge[@"data"][@"charge"];
//            [kauiqia backRefresh:^{
//                //更新账单
//                NSDictionary *paramter = @{@"id":[_defaulte valueForKey:@"userID"], @"token":[_defaulte valueForKey:@"userToken"], @"bid": charge[@"data"][@"id"], @"shopid":_shopid, @"object": @"success", @"appStatus":@"1", @"terminal":@"ios", @"deviceid":@"iphone"};
//                [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900033"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//                    [SVProgressHUD dismiss];
//                } failure:^(NSError *error) {
//                    nil;
//                }];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//            [self.navigationController pushViewController: kauiqia  animated:YES];
//        }else{
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//        //查看保证金页面进入 回调刷新页面
//        if (!_isChongzhi) {
//            _again();
//        }
//    }];
//}

- (void)explain{
    TCHtmlViewController *html = [[TCHtmlViewController alloc]init];
    html.html = @"https://sellerapi.moumou001.com/h5/bond-view";
    html.title = @"保证金说明";
    [self.navigationController pushViewController:html animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_codeTF resignFirstResponder];
    [_momeytf resignFirstResponder];
}



@end
