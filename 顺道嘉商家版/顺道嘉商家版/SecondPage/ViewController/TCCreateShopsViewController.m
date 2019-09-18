//
//  TCCreateShopsViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/9.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCreateShopsViewController.h"
#import "TCDingweiViewController.h"
#import "TCshopStyleViewController.h"
#import "TCZiZhiInfoViewController.h"
#import "TCHtmlViewController.h"

@interface TCCreateShopsViewController ()<UIScrollViewDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *nextBtn;//下一步
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSMutableArray *mesArr;//店铺种类数组
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *shopID; //店铺ID
@property (nonatomic, strong) NSString *mid; //mid
@property (nonatomic, strong) NSString *token; //token

@property (nonatomic, strong) UIButton *checkBtn;//勾选框

@end

@implementation TCCreateShopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.enterStr isEqualToString:@"1"]) {
        self.title = @"店铺介绍管理";
    }else{
        self.title = @"店铺介绍";
    }
    self.view.backgroundColor = TCBgColor;
    self.userdefaults = [NSUserDefaults standardUserDefaults];
    self.shopID = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"shopID"]];
    self.mid = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userID"]];
    self.token = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userToken"]];
    self.mobile = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userMobile"]];
    self.mesArr = [NSMutableArray array];
    [self creatUI];
    //请求店铺种类
    [self creatRequest];
    
    [self creatshopInfo];
}

-(void)creatshopInfo{
    
    UITextField *shopname = (UITextField *)[self.view viewWithTag:1000];
    UITextField *state_field = (UITextField *)[self.view viewWithTag:1001];
    UITextField*name_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField*sparePhone = (UITextField *)[self.view viewWithTag:1004];//参数可能要传
    UITextField*userCode = (UITextField *)[self.view viewWithTag:1005];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":self.mid,@"token":self.token,@"shopid":self.shopID,@"type":@"1"};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":self.mid,@"token":self.token,@"shopid":self.shopID,@"type":@"1"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201014"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSString *string = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([string isEqualToString:@"1"]) {
            self.nextBtn.alpha = 1;
            self.nextBtn.userInteractionEnabled = YES;
            NSString *str = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"shopcateid"]];
            self.idStr = str;
            NSString *shopcate = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"shopcatename"]];
            userCode.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"up_user"]];
            shopname.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"name"]];
            userCode.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"up_user"]];
            state_field.text = shopcate;
            name_field.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"sellername"]];
            NSString *backmobile = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"bakmobile"]];
            
            if ([backmobile isEqualToString:@""]) {
                nil;
            }else{
                sparePhone.text = backmobile;
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//经营品类的接口请求
-(void)creatRequest{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    [self.mesArr removeAllObjects];
    self.view.userInteractionEnabled = NO;

    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":self.mid,@"token":self.token};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":self.mid,@"token":self.token};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201015"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        for (NSDictionary *dic in jsonDic[@"data"][@"shopcates"]) {
            NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
            NSString *name = [NSString stringWithFormat:@"%@",dic[@"name"]];
            NSDictionary *info = @{@"id":idStr,@"name":name};
            [self.mesArr addObject:info];
        }
        self.view.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];
    }];
}
-(void)creatUI{
    NSArray *titleS = @[@"店铺名称",@"经营品类",@"店主姓名",@"店主电话",@"备用电话"];
    for (int i = 0; i < titleS.count; i ++) {
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0,i *55, WIDHT, 55)];
        mainView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [self.view addSubview:mainView];
        UILabel *titLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 15)];
        titLabel.text = titleS[i];
        titLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        titLabel.textColor = TCUIColorFromRGB(0x666666);
        titLabel.textAlignment = NSTextAlignmentLeft;
        [mainView addSubview:titLabel];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titLabel.frame) + 10, 20, WIDHT - 30 - 60 - 10, 15)];
        textField.tag = 1000 + i;
        [textField addTarget:self action:@selector(alueChange:) forControlEvents:(UIControlEventAllEditingEvents)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.textAlignment = NSTextAlignmentRight;
        textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [mainView addSubview:textField];
        
        if (i == 0) {
            textField.placeholder = @"输入店铺名称(1-25字)";
        }else if (i == 1){
            textField.frame = CGRectMake(CGRectGetMaxX(titLabel.frame) + 10, 20, WIDHT - 30 - 60 - 10 - 5 - 20, 15);
            textField.text = @"选择商品品类";
            textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            textField.textColor = TCUIColorFromRGB(0x53C3C3);
            UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapText:)];
            [textField addGestureRecognizer:tapText];
    
            UIImageView *sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 - 5, (55 - 8)/2, 5, 8)];
            sanImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
            [mainView addSubview:sanImage];
            
        }else if (i == 2){
            textField.placeholder = @"请输入真实姓名";
        }else if (i == 3){
            textField.text = self.mobile;
            [textField setEnabled:NO];
        }else if (i == 4){
            textField.placeholder = @"填写您的备用电话（选填）";
        }
        
        if (i < titleS.count - 1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 54, WIDHT - 15, 1)];
            line.backgroundColor = TCLineColor;
            [mainView addSubview:line];
        }
//        if (i == titleS.count - 1) {
//            titLabel.frame = CGRectMake(15, 20, WIDHT/2 , 15);
//            if ([self.shopID isEqualToString:@"0"]) {
//                mainView.hidden = YES;
//            }else{
//                mainView.hidden = NO;
//
//            }
//        }
    }
        self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 285, 16, 16)];
        self.checkBtn.selected = YES;
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"小选中框"] forState:(UIControlStateSelected)];
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
//        [self.checkBtn addTarget:self action:@selector(clickCheck:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.checkBtn];
        
        UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkBtn.frame) + 5, 287, 24, 12)];
        agreeLabel.text = @"同意";
        agreeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        agreeLabel.textColor = TCUIColorFromRGB(0x333333);
        agreeLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:agreeLabel];
        
        UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(agreeLabel.frame), 287, 100, 12)];
        [serviceBtn setBackgroundColor:TCBgColor];
        [serviceBtn setTitle:@"《商家入驻协议》" forState:(UIControlStateNormal)];
        [serviceBtn setTitleColor:TCUIColorFromRGB(0x4CA6FF) forState:(UIControlStateNormal)];
        [serviceBtn addTarget:self action:@selector(clickService:) forControlEvents:(UIControlEventTouchUpInside)
         ];
        serviceBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        serviceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:serviceBtn];
    
        self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(serviceBtn.frame) + 60, WIDHT - 30, 48)];
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.alpha = 0.6;
        [self.nextBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        [self.nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        [self.nextBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
        [self.nextBtn addTarget:self action:@selector(clickNext:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.nextBtn];
}
//点击用户服务协议
-(void)clickService:(UIButton*)sender{
    TCHtmlViewController *htmlVC = [[TCHtmlViewController alloc] init];
    htmlVC.hidesBottomBarWhenPushed = YES;
    htmlVC.html = @"https://h5.moumou001.com/help/seller/protocol.html";
    htmlVC.title = @"服务协议";
    [self.navigationController pushViewController:htmlVC animated:YES];
    htmlVC.hidesBottomBarWhenPushed = NO;
}
//-(void)clickCheck:(UIButton *)sender{
//    sender.selected = !sender.selected;
//}

-(void)tapText:(UITapGestureRecognizer *)tap{
    UITextField*shopstate = (UITextField *)[self.view viewWithTag:1001];
    TCshopStyleViewController *shopStyle = [[TCshopStyleViewController alloc]init];
    shopStyle.messArr = self.mesArr;
    shopStyle.block = ^(NSString *str) {
        shopstate.text = str;
    };
    shopStyle.blocks = ^(NSString *idStr) {
        self.idStr = idStr;
    };
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopStyle animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)clickNext:(UIButton *)sender{
    UITextField *shopname = (UITextField *)[self.view viewWithTag:1000];
    UITextField *shopstate = (UITextField *)[self.view viewWithTag:1001];
    UITextField *name_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField *sparePhone = (UITextField *)[self.view viewWithTag:1004];//参数可能要传
    if ([shopstate.text isEqualToString:@"选择商品品类"]) {
        [TCProgressHUD showMessage:@"请选择经营品类"];
    } else if (shopname.text.length == 0 && shopstate.text.length == 0 && name_field.text.length == 0) {
        [TCProgressHUD showMessage:@"请完善您的信息"];
    }else{
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSDictionary *dic;
        NSDictionary *parameters;
        if (sparePhone.text.length != 0) {
            if (sparePhone.text.length < 11 && ![BSUtils checkTelNumber:sparePhone.text]) {
                [TCProgressHUD showMessage:@"请输入正确的备用电话"];
            } else {
                dic = @{@"timestamp":Timestr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"bakmobile":sparePhone.text,@"shopid":self.shopID};
                NSString *singStr = [TCServerSecret signStr:dic];
                parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"bakmobile":sparePhone.text,@"shopid":self.shopID};
            }
        } else {
            dic = @{@"timestamp":Timestr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"shopid":self.shopID};
            NSString *singStr = [TCServerSecret signStr:dic];
            parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"shopid":self.shopID};
        }
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201005"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
//            if ([codeStr isEqualToString:@"1"]) {
                [self.userdefaults setValue:jsonDic[@"data"][@"shopid"] forKey:@"shopID"];
                TCZiZhiInfoViewController *zizhiVC = [[TCZiZhiInfoViewController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zizhiVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
//            }else{
//                [TCProgressHUD showMessage:jsonDic[@"msg"]];
//            }
                [SVProgressHUD dismiss];
                } failure:^(NSError *error) {
                    nil;
                }];
//            }
//                }else{
//                    if ([self.enterStr isEqualToString:@"1"]) {
//                        //备用手机号不为空
//                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认修改店铺信息" message:@"修改您的店铺信息时您的店铺会保留原有信息作展示，客服审核通过后您的店铺将会以修改后的信息做展示。如果您需要快速上线可以联系客服，会加快您的审核进度。" preferredStyle:UIAlertControllerStyleAlert];
//                        UIView *subView1 = alert.view.subviews[0];
//                        UIView *subView2 = subView1.subviews[0];
//                        UIView *subView3 = subView2.subviews[0];
//                        UIView *subView4 = subView3.subviews[0];
//                        UIView *subView5 = subView4.subviews[0];
//                        UILabel *message = subView5.subviews[1];
//                        message.textAlignment = NSTextAlignmentLeft;
//                        message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//                        message.textColor = TCUIColorFromRGB(0x333333);
//                        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认修改" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                            //这里添加了多线程，消除警告
//                            [self editRequest];
//
//
//                        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
//                        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不修改" style:(UIAlertActionStyleCancel) handler:nil];
//                        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
//                        [alert addAction:sure];
//                        [alert addAction:cancle];
//                        [self presentViewController:alert animated:YES completion:nil];
//
}
//-(void)editRequest{
//    UITextField *shopname = (UITextField *)[self.view viewWithTag:1000];
//    UITextField*shopstate = (UITextField *)[self.view viewWithTag:1001];
//    UITextField*name_field = (UITextField *)[self.view viewWithTag:1002];
//    UITextField*phone_field = (UITextField *)[self.view viewWithTag:1003];
//    UITextField*sparePhone = (UITextField *)[self.view viewWithTag:1004];//参数可能要传
//
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD showWithStatus:@"获取中..."];
//
//    NSString *Timestr = [TCGetTime getCurrentTime];
//    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"shopid":self.shopID};
//    NSString *singStr = [TCServerSecret signStr:dic];
//    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":self.mid,@"token":self.token,@"name":shopname.text,@"shopcateid":self.idStr,@"mobile":self.mobile,@"sellername":name_field.text,@"shopid":self.shopID};
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201005"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        NSLog(@"%@--%@",jsonDic,jsonStr);
//        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
//        if ([codeStr isEqualToString:@"1"]) {
//            [TCProgressHUD showMessage:jsonDic[@"msg"]];
//            TCZiZhiInfoViewController *zizhiVC = [[TCZiZhiInfoViewController alloc]init];
//            zizhiVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:zizhiVC animated:YES];
//            self.hidesBottomBarWhenPushed = YES;
//        }else{
//            [TCProgressHUD showMessage:jsonDic[@"msg"]];
//        }
//
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        nil;
//    }];
//}
}

- (void)alueChange:(UITextField *)textField{
    
    UITextField *shopname = (UITextField *)[self.view viewWithTag:1000];
    UITextField *shopstate = (UITextField *)[self.view viewWithTag:1001];
    UITextField *name_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField *phone_field = (UITextField *)[self.view viewWithTag:1003];
    if (shopname.text.length != 0 && name_field.text.length != 0 && shopstate.text.length != 0 && phone_field.text.length != 0) {
        self.nextBtn.userInteractionEnabled = YES;
        self.nextBtn.alpha = 1;
    }else{
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.alpha = 0.6;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITextField *shopname = (UITextField *)[self.view viewWithTag:1000];
    UITextField *state_field = (UITextField *)[self.view viewWithTag:1001];
    UITextField*name_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField*sparePhone = (UITextField *)[self.view viewWithTag:1004];//参数可能要传
    UITextField*userCode = (UITextField *)[self.view viewWithTag:1005];
    
    [shopname resignFirstResponder];
    [state_field resignFirstResponder];
    [name_field resignFirstResponder];
    [sparePhone resignFirstResponder];
    [userCode resignFirstResponder];
}

@end

