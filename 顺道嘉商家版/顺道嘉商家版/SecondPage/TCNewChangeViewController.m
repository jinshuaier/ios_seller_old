//
//  TCNewChangeViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2016/12/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNewChangeViewController.h"

@interface TCNewChangeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nametf;
@property (nonatomic, strong) UITextField *numtf;
@property (nonatomic, strong) UITextField *starttf;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCNewChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改店铺";
    self.view.backgroundColor = RGB(242, 242, 242);
    _userdefault = [NSUserDefaults standardUserDefaults];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 300)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: backview];
    
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 65, 32)];
    lb.text = @"店铺名称";
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = TCUIColorFromRGB(0x4d4d4d);
    lb.textAlignment = NSTextAlignmentRight;
    [backview addSubview: lb];
    _nametf = [[UITextField alloc]initWithFrame:CGRectMake(lb.frame.origin.x + lb.frame.size.width + 10, lb.frame.origin.y, WIDHT - lb.frame.origin.x - lb.frame.size.width - 10 - 20, 32)];
    if(self.shopName){
        _nametf.text = self.shopName;
    }else{
        _nametf.placeholder = @"店铺名称";
    }
    _nametf.enabled = NO;
    _nametf.backgroundColor = TCUIColorFromRGB(0xdedede);
    _nametf.textAlignment = NSTextAlignmentCenter;
    _nametf.layer.cornerRadius = 2;
    _nametf.layer.masksToBounds = YES;
    [_nametf addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [backview addSubview: _nametf];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(lb.frame.origin.x, lb.frame.origin.y + lb.frame.size.height + 12, lb.frame.size.width, lb.frame.size.height)];
    name.text = @"联系电话";
    name.textAlignment = NSTextAlignmentRight;
    name.textColor = TCUIColorFromRGB(0x4d4d4d);
    name.font = [UIFont systemFontOfSize:15];
    [backview addSubview: name];
    _numtf = [[UITextField alloc]initWithFrame:CGRectMake(_nametf.frame.origin.x, name.frame.origin.y, _nametf.frame.size.width, _nametf.frame.size.height)];
    if(self.shopTel){
        _numtf.text = self.shopTel;
    }else{
        _numtf.placeholder = @"您的常用电话";
    }
    _numtf.textAlignment = NSTextAlignmentCenter;
    _numtf.layer.cornerRadius = 2;
    _numtf.delegate = self;
    _numtf.layer.masksToBounds = YES;
    [_numtf addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    _numtf.backgroundColor = TCUIColorFromRGB(0xdedede);
    [backview addSubview: _numtf];
    
    UILabel *qisong = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, name.frame.origin.y + name.frame.size.height + 12, name.frame.size.width, name.frame.size.height)];
    qisong.text = @"起送价";
    qisong.textAlignment = NSTextAlignmentRight;
    qisong.textColor = TCUIColorFromRGB(0x4d4d4d);
    qisong.font = [UIFont systemFontOfSize:15];
    [backview addSubview: qisong];
    _starttf = [[UITextField alloc]initWithFrame:CGRectMake(_numtf.frame.origin.x, qisong.frame.origin.y, _numtf.frame.size.width / 2, _numtf.frame.size.height)];
    _starttf.delegate = self;
    _starttf.keyboardType = UIKeyboardTypeDecimalPad;
    if(self.priceStr){
        _starttf.text = self.priceStr;
    }else{
        _starttf.placeholder = @"0";
    }
    _starttf.textAlignment = NSTextAlignmentCenter;
    _starttf.layer.cornerRadius = 2;
    _starttf.layer.masksToBounds = YES;
    _starttf.backgroundColor = TCUIColorFromRGB(0xdedede);
    [_starttf addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [backview addSubview: _starttf];
    UILabel *yuan = [[UILabel alloc]initWithFrame:CGRectMake(_starttf.frame.origin.x + _starttf.frame.size.width + 5, _starttf.frame.origin.y, 30, _starttf.frame.size.height)];
    yuan.text = @"元";
    yuan.textColor = TCUIColorFromRGB(0x4d4d4d);
    [backview addSubview: yuan];
    
    UILabel *yingye = [[UILabel alloc]initWithFrame:CGRectMake(qisong.frame.origin.x, qisong.frame.origin.y + qisong.frame.size.height + 12, qisong.frame.size.width, qisong.frame.size.height)];
    yingye.text = @"是否营业";
    yingye.textAlignment = NSTextAlignmentRight;
    yingye.textColor = TCUIColorFromRGB(0x4d4d4d);
    yingye.font = [UIFont systemFontOfSize:15];
    [backview addSubview: yingye];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"营业",@"暂停", nil];
    _segment = [[UISegmentedControl alloc]initWithItems:arr];
    _segment.frame = CGRectMake(_starttf.frame.origin.x, yingye.frame.origin.y, _starttf.frame.size.width, 32);
    _segment.layer.masksToBounds = YES;
    _segment.layer.cornerRadius = 5;
    _segment.backgroundColor = TCUIColorFromRGB(0xdedede);
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    _segment.selectedSegmentIndex = 0;
    _segment.tintColor = TCUIColorFromRGB(0x2ea8e6);
    [backview addSubview: _segment];
    backview.frame = CGRectMake(0, 0, WIDHT, _segment.frame.origin.y + _segment.frame.size.height + 32);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDHT / 2 - 560 / 4, backview.frame.origin.y + backview.frame.size.height + 40, 560 / 2, 48);
    btn.backgroundColor = TCUIColorFromRGB(0xcccccc);
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    _btn = btn;
}

- (void)commit{
    int status = 1;
    if (_segment.selectedSegmentIndex == 0) {
        status = 1;//上线
    }else{
        status = 0;//停业
    }
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"shopid":[_userdefault valueForKey:@"shopID"], @"price":_starttf.text, @"status":@(status), @"mobile":_numtf.text};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900021"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if ([[NSString stringWithFormat:@"%@", jsonDic[@"retValue"]] isEqualToString:@"5"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)valueChanged:(UITextField *)text{
    if (![_numtf.text isEqualToString:@""] && ![_nametf.text isEqualToString:@""] && ![_starttf.text isEqualToString:@""]) {
        _btn.backgroundColor = TCUIColorFromRGB(0x21d9d9);
        _btn.userInteractionEnabled = YES;
    }else{
        _btn.backgroundColor = TCUIColorFromRGB(0xcccccc);
        _btn.userInteractionEnabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//限制字数
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == _numtf){
        if(range.length + range.location > _numtf.text.length){
            return NO;
        }
        NSInteger newLenght = [_numtf.text length] + [string length] - range.length;
        return newLenght <= 11;
    }
    return YES;
}















@end
