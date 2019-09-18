//
//  TCAddBankCardViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddBankCardViewController.h"
#import "TCZiZhiInfoViewController.h"
#import "TCMyBankViewController.h"
#import "TCWithdrawMoneyViewController.h"
#import "TCHtmlViewController.h"

@interface TCAddBankCardViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSString *stateType;//账号类型 0 对私  1 对公
@property (nonatomic, strong) UITextField *banknumf;//银行卡号
@property (nonatomic, strong) UITextField *peoplef;//持卡人
@property (nonatomic, strong) UITextField *idCordf;//身份证
@property (nonatomic, strong) UITextField *phonef;//预留手机号
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIButton *publicBtn;//对公
@property (nonatomic, strong) UIButton *privateBtn;//对私
@property (nonatomic, strong) UIButton *sureBtn;//确认按钮
@property (nonatomic, strong) UIView *bgckView;
@property (nonatomic, strong) UIButton *checkBtn;

@end

@implementation TCAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =  @"添加银行卡";
    self.stateType = @"0";
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = TCBgColor;
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    UILabel *txLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, WIDHT - 30, 14)];
    txLabel.text = @"请绑定店主本人的银行卡";
    txLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    txLabel.textColor = TCUIColorFromRGB(0x666666);
    txLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:txLabel];
    
    NSArray *arr = @[@"账户类型",@"银行卡号"];
    NSArray *infoArr = @[@"持卡人",@"身份证",@"手机号"];
    NSArray *pharr = @[@"持卡人姓名",@"请输入证件号码",@"银行预留手机号"];
    for (int j = 0; j < arr.count; j++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(txLabel.frame) + 20 + j *(10 + 45), WIDHT, 45)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [self.view addSubview:view];
        
        UILabel *toplabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, WIDHT/3, 15)];
        toplabel.text = arr[j];
        toplabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        toplabel.textColor = TCUIColorFromRGB(0x666666);
        toplabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:toplabel];
        
        if (j == 0) {
            //对公
            self.publicBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 55 - 30 - 55, 12.5, 55, 20)];
            [self.publicBtn setTitle:@"对公" forState:(UIControlStateNormal)];
            [self.publicBtn setTitleColor:TCUIColorFromRGB(0x999E9C) forState:(UIControlStateNormal)];
            [self.publicBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateSelected)];
            [self.publicBtn setImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
            [self.publicBtn setImage:[UIImage imageNamed:@"选中框"] forState:(UIControlStateSelected)];
            [self.publicBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,35)];
            //button标题的偏移量，这个偏移量是相对于图片的
            [self.publicBtn setTitleEdgeInsets:UIEdgeInsetsMake(2.5,0,2.5, 0)];
            self.publicBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [self.publicBtn addTarget:self action:@selector(clickPublic:) forControlEvents:(UIControlEventTouchUpInside)];
            [view addSubview:self.publicBtn];
            
            //对私
            self.privateBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 55, 12.5, 55, 20)];
            [self.privateBtn setTitle:@"对私" forState:(UIControlStateNormal)];
            self.privateBtn.selected = YES;
            [self.privateBtn setTitleColor:TCUIColorFromRGB(0x999E9C) forState:(UIControlStateNormal)];
            [self.privateBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateSelected)];
            [self.privateBtn setImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
            [self.privateBtn setImage:[UIImage imageNamed:@"选中框"] forState:(UIControlStateSelected)];
            [self.privateBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
            //button标题的偏移量，这个偏移量是相对于图片的
            [self.privateBtn setTitleEdgeInsets:UIEdgeInsetsMake(2.5,0,2.5, 0)];
            self.privateBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [self.privateBtn addTarget:self action:@selector(clickPrivate:) forControlEvents:(UIControlEventTouchUpInside)];
            [view addSubview:self.privateBtn];
        }else{
            self.banknumf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(toplabel.frame) + 15, 15, WIDHT/3 * 2 - 30 - 12, 15)];
            self.banknumf.delegate = self;
            self.banknumf.borderStyle = UITextBorderStyleNone;
            self.banknumf.placeholder = @"请输入您的银行卡号";
            self.banknumf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.banknumf.textColor = TCUIColorFromRGB(0x333333);
            self.banknumf.textAlignment = NSTextAlignmentRight;
            [self.banknumf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
            [view addSubview:self.banknumf];
        }

    }
    UILabel *redLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(txLabel.frame) + 20 + 110, WIDHT - 30, 12)];
    redLabel.text = @"提醒：后续只能绑定该持卡人的银行卡";
    redLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    redLabel.textColor = TCUIColorFromRGB(0xFF5544);
    redLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:redLabel];
    
    for (int i = 0; i < infoArr.count; i ++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(redLabel.frame) + 20 + i * 45, WIDHT, 45)];
        bgView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [self.view addSubview:bgView];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 45, 15)];
        nameLabel.text = infoArr[i];
        nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        nameLabel.textColor = TCUIColorFromRGB(0x4C4C4C);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:nameLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 44, WIDHT - 15, 1)];
        line.backgroundColor = TCLineColor;
        [bgView addSubview:line];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 20 + 15, 15, WIDHT - 30 - 45 - 35, 15)];
        field.delegate = self;
        field.tag = 1000 + i;
        field.borderStyle = UITextBorderStyleNone;
        field.placeholder = pharr[i];
        field.textAlignment = NSTextAlignmentRight;
        field.textColor = TCUIColorFromRGB(0x333333);
        field.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [field addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
        [bgView addSubview:field];
        if (i == 0) {
            self.peoplef = field;
        }else if (i == 1){
            self.idCordf = field;
        }else if (i == 2){
            self.phonef = field;
            UIButton *queBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 15, 15, 15)];
            [queBtn setImage:[UIImage imageNamed:@"问号"] forState:(UIControlStateNormal)];
            [queBtn addTarget:self action:@selector(clickQues:) forControlEvents:(UIControlEventTouchUpInside)];
            [bgView addSubview:queBtn];
        }

    }
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(redLabel.frame) + 20 + 45 * 3 + 10, 16, 16)];
    self.checkBtn.selected = YES;
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"小选中框"] forState:(UIControlStateSelected)];
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
    [self.checkBtn addTarget:self action:@selector(clickCheck:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.checkBtn];
    
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkBtn.frame) + 5, CGRectGetMaxY(redLabel.frame) + 20 + 45 * 3 + 12, 24, 12)];
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    agreeLabel.textColor = TCUIColorFromRGB(0x333333);
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:agreeLabel];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(agreeLabel.frame), CGRectGetMaxY(redLabel.frame) + 20 + 45 * 3 + 12, 100, 12)];
    [serviceBtn setBackgroundColor:TCBgColor];
    [serviceBtn setTitle:@"《商家入驻协议》" forState:(UIControlStateNormal)];
    [serviceBtn setTitleColor:TCUIColorFromRGB(0x4CA6FF) forState:(UIControlStateNormal)];
    [serviceBtn addTarget:self action:@selector(clickService:) forControlEvents:(UIControlEventTouchUpInside)
     ];
    serviceBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    serviceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:serviceBtn];
    
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(serviceBtn.frame) + 40, WIDHT - 30, 48)];
    self.sureBtn.userInteractionEnabled = NO;
    [self.sureBtn setTitle:@"验证信息" forState:(UIControlStateNormal)];
    [self.sureBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    self.sureBtn.alpha = 0.6;
    [self.sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.sureBtn];  
}
//点击用户服务协议
-(void)clickService:(UIButton*)sender{
    NSLog(@"点击了用户服务协议");
    TCHtmlViewController *htmlVC = [[TCHtmlViewController alloc] init];
    htmlVC.hidesBottomBarWhenPushed = YES;
    htmlVC.html = @"https://h5.moumou001.com/help/seller/protocol.html";
    htmlVC.title = @"服务协议";
    [self.navigationController pushViewController:htmlVC animated:YES];
    htmlVC.hidesBottomBarWhenPushed = NO;
}

-(void)clickQues:(UIButton *)sender{
    NSLog(@"点击了问号");
    [self creatalphaView];
}

-(void)clickCheck:(UIButton *)sender{
    sender.selected = !sender.selected;
}
-(void)creatalphaView{
    self.bgckView = [[UIView alloc] init];
    self.bgckView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgckView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgckView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 173)];
    contentView.center = CGPointMake(WIDHT/2, HEIGHT/2);
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 10;
    [self.bgckView addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(111, 24, 48, 18)];
    titleLabel.text = @"手机号";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    titleLabel.textColor = TCUIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:titleLabel];
    
    
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(titleLabel.frame) + 10, 220, 48)];
        label.text = @"银行预留手机号是在银行办卡时填写的手机号，若遗忘、换号可联系银行客服电话处理";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = TCUIColorFromRGB(0x666666);
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [label sizeThatFits:CGSizeMake(220, MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
        label.frame = CGRectMake(25, CGRectGetMaxY(titleLabel.frame) + 10, 220, size.height);
        [contentView addSubview:label];
        
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 173 - 45 - 1, 270, 1)];
    lineView.backgroundColor = TCLineColor;
    [contentView addSubview:lineView];
    
    
    
    UIButton *knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), 270, 45)];
    [knowBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
    [knowBtn setTitle:@"知道了" forState:(UIControlStateNormal)];
    [knowBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [knowBtn addTarget:self action:@selector(clickKnow:) forControlEvents:(UIControlEventTouchUpInside)];
    knowBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    knowBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:knowBtn];
}

-(void)closeBGView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
}
-(void)clickKnow:(UIButton *)sender{
    [self closeBGView];
}
#pragma mark -- 点击对公按钮
-(void)clickPublic:(UIButton *)sender{
    sender.selected = YES;
    self.stateType = @"1";
    self.privateBtn.selected = NO;
}
-(void)clickPrivate:(UIButton *)sender{
    sender.selected = YES;
    self.stateType = @"0";
    self.publicBtn.selected = NO;
}

- (void)alueChange:(UITextField *)textField{
    self.sureBtn.enabled = (self.banknumf.text.length != 0 &&
                            self.peoplef.text.length != 0 &&
                            self.phonef.text.length != 0 &&
                            self.idCordf.text.length != 00&&
                            self.checkBtn.selected == YES);
    if (self.sureBtn.enabled == YES) {
        [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        self.sureBtn.alpha = 1;
        self.sureBtn.userInteractionEnabled = YES;
    }else{
        [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        self.sureBtn.alpha = 0.6;
        self.sureBtn.userInteractionEnabled = NO;
    }
    
}
-(void)clickSure:(UIButton *)sender{
    if (![BSUtils IsBankCard:self.banknumf.text]) {
        [TCProgressHUD showMessage:@"请输入正确的银行卡号"];
    }else if (![BSUtils IsIdentityCard:self.idCordf.text]){
        [TCProgressHUD showMessage:@"请输入正确的身份信息"];
    }else if (![BSUtils checkTelNumber:self.phonef.text]){
        [TCProgressHUD showMessage:@"预留手机号有误，请重新输入"];
    }else{
        [self request];
    }
}

-(void)request{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"mobile":self.phonef.text,@"mid":mid,@"timestamp":Timestr,@"token":token,@"cardno":self.banknumf.text,@"name":self.peoplef.text,@"idno":self.idCordf.text,@"isPublic":self.stateType};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"mobile":self.phonef.text,@"mid":mid,@"timestamp":Timestr,@"token":token,@"cardno":self.banknumf.text,@"name":self.peoplef.text,@"idno":self.idCordf.text,@"isPublic":self.stateType,@"sign":singStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201013"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
            if ([self.entranceTypeStr isEqualToString:@"0"]) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TCZiZhiInfoViewController class]]) {
                        TCZiZhiInfoViewController *revise =(TCZiZhiInfoViewController *)controller;
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"returnbankcard" object:nil];
                        [self.navigationController popToViewController:revise animated:YES];
                    }
                }
            }else if ([self.entranceTypeStr isEqualToString:@"1"]){
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TCMyBankViewController class]]) {
                        TCMyBankViewController *revise =(TCMyBankViewController *)controller;
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"returnbanklist" object:nil];
                        [self.navigationController popToViewController:revise animated:YES];
                    }
                }
            }else if ([self.entranceTypeStr isEqualToString:@"2"]){
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TCWithdrawMoneyViewController class]]) {
                        TCWithdrawMoneyViewController *revise =(TCWithdrawMoneyViewController *)controller;
                        [self.navigationController popToViewController:revise animated:YES];
                    }
                }
            }
            
            
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
    }];
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITextField *phone_textfield = (UITextField *)[self.view viewWithTag:1002];
//    
//    [phone_textfield resignFirstResponder];
//    //结束编辑时整个试图返回原位
//    [phone_textfield resignFirstResponder];
//    [UIView beginAnimations:@"down" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.frame = CGRectMake(0, 0, WIDHT, HEIGHT );
//    [UIView commitAnimations];
//    
//}

////输入框的两个代理方法
//#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if ([UIScreen mainScreen].bounds.size.height <= 568.0) {
//        if (textField.tag-1000 > 0){
//            //开始编辑时使整个视图整体向上移
//            [UIView beginAnimations:@"up" context:nil];
//            [UIView setAnimationDuration:0.5];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            self.view.frame = CGRectMake(0, -(textField.tag-1000)*60, self.view.bounds.size.width, self.view.bounds.size.height);
//            [UIView commitAnimations];
//        }
//    }else{
//        if (textField.tag-1000 > 1) {
//            //开始编辑时使整个视图整体向上移
//            [UIView beginAnimations:@"up" context:nil];
//            [UIView setAnimationDuration:0.5];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            self.view.frame = CGRectMake(0, -(textField.tag-1000-1)*60, self.view.bounds.size.width, self.view.bounds.size.height);
//            [UIView commitAnimations];
//
//        }
//    }
//    return YES;
//}

//#pragma mark -- 点击return 下滑
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//
//{
//    [textField resignFirstResponder];
//    //结束编辑时整个试图返回原位
//    [textField resignFirstResponder];
//    [UIView beginAnimations:@"down" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.frame = CGRectMake(0, -StatusBarAndNavigationBarHeight, WIDHT, HEIGHT );
//    [UIView commitAnimations];
//
//    return YES;
//}
//
//-(void)keyboardWillBeHidden:(NSNotification*)aNotification
//
//{
//    [UIView beginAnimations:@"down" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.frame = CGRectMake(0, -StatusBarAndNavigationBarHeight, WIDHT, HEIGHT );
//    [UIView commitAnimations];
//}

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
