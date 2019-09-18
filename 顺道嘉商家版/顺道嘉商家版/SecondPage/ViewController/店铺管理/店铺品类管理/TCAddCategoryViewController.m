//
//  TCAddCategoryViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/26.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddCategoryViewController.h"

@interface TCAddCategoryViewController ()<UITextFieldDelegate>
{
    UITextField *mess_field; //排序的输入框
}
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIButton *rightBtn; //确认点击
@property (nonatomic, strong) UITextField *cagtTextField;

@end

@implementation TCAddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    if (self.isChange == YES){
        self.title = @"修改品类";
    } else {
        self.title = @"新增品类";
    }
    self.userdefault = [NSUserDefaults standardUserDefaults];
    
    //右边的确认按钮
    [self setupNavigationItem];
    //创建视图
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationItem{
    
    //确定按钮
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    self.rightBtn.frame = CGRectMake(WIDHT - 30 - 15, 12, 30, 14);
    [self.rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

//创建视图
- (void)createUI
{
    //设置背景框
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    backView.frame = CGRectMake(0, 0, WIDHT, 60 + 44);
    [self.view addSubview:backView];
    //品类名称
    UILabel *nameLabel = [UILabel publicLab:@"品类名称" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    nameLabel.frame = CGRectMake(15, 0, 60, 60);
    [backView addSubview:nameLabel];
    
    //品类名称
    self.cagtTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 0, WIDHT - CGRectGetMaxX(nameLabel.frame) - 16 - 10, 60)];
    self.cagtTextField.delegate = self;
    if (self.isChange == YES){
        self.cagtTextField.text = self.nameStr;
    }
    self.cagtTextField.placeholder = @"请输入品类名称";
    self.cagtTextField.textColor = TCUIColorFromRGB(0x333333);
    [self.cagtTextField setValue:TCUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [self.cagtTextField setValue:[UIFont fontWithName:@"PingFangSC-Regular" size:15] forKeyPath:@"_placeholderLabel.font"];
    self.cagtTextField.returnKeyType = UIReturnKeyDefault;//变为搜索按钮
    self.cagtTextField.textAlignment = NSTextAlignmentRight;
    self.cagtTextField.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [backView addSubview:self.cagtTextField];
    
    //线
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(15, 60, WIDHT - 15, 1);
    lineView.backgroundColor = TCUIColorFromRGB(0xEDEDED);
    [backView addSubview:lineView];
    //排序标题
    UILabel *sortLabel = [UILabel publicLab:@"降序排列（0-9999）" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    sortLabel.frame = CGRectMake(15, CGRectGetMaxY(lineView.frame), 146, 44);
    [backView addSubview:sortLabel];
    
    //商品排序
    UIButton *add_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [add_btn setBackgroundImage:[UIImage imageNamed:@"加商品"] forState:(UIControlStateNormal)];
    add_btn.frame = CGRectMake(WIDHT - 20 - 15, (45 - 20)/2 + CGRectGetMaxY(lineView.frame), 20, 20);
    [add_btn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:add_btn];
    
    mess_field = [[UITextField alloc] init];
    mess_field.frame = CGRectMake(WIDHT - 35 - 8 - 40, CGRectGetMaxY(lineView.frame), 40, 45);
    mess_field.textAlignment = NSTextAlignmentCenter;
    mess_field.keyboardType = UIKeyboardTypeNumberPad;
    mess_field.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    if (self.sortStr) {
        mess_field.text = self.sortStr;
    } else {
        mess_field.text = @"50";
    }
    mess_field.delegate = self;
    [backView addSubview:mess_field];
    
    UIButton *cut_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cut_btn setBackgroundImage:[UIImage imageNamed:@"减商品"] forState:(UIControlStateNormal)];
    cut_btn.frame = CGRectMake(WIDHT - 20 - 15 - 40 - 16 - 20, (45 - 20)/2 + CGRectGetMaxY(lineView.frame), 20, 20);
    [cut_btn addTarget:self action:@selector(cutClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:cut_btn];
    
    //提示语
    UILabel *total_label = [UILabel publicLab:@"注：自定义分类序号为0-9999中任意整数，按降序排列，系统固有分类序号为50，且不可修改。" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    total_label.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 10, WIDHT - 30, 34);
    [self.view addSubview:total_label];
}

#pragma mark -- 加商品排序
- (void)addClick:(UIButton *)sender
{
    int count = [mess_field.text intValue];
    count++;
    if (count > 9999){
        [TCProgressHUD showMessage:@"超过排序最大值"];
    } else {
        mess_field.text = [NSString stringWithFormat:@"%d",count];
    }
}

#pragma mark -- 减商品排序
- (void)cutClick:(UIButton *)sender
{
    int count = [mess_field.text intValue];
    count--;
    if (count < 0){
        [TCProgressHUD showMessage:@"不能少于排序最小值"];
    } else {
        mess_field.text = [NSString stringWithFormat:@"%d",count];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *String = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (mess_field == textField) {
        if (String.length > 4) {
            textField.text = [String substringToIndex:4];
            return NO;
        }
        if (String.length > 1){
            unichar single = [String characterAtIndex:0];//当前输入的字符
            if (single == '0') {
                [TCProgressHUD showMessage:@"亲，第一个数字不能为0!"];
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark -- 确认按钮的点击事件
- (void)AddRest
{
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"shopid":shopID,@"name":self.cagtTextField.text,@"sort":mess_field.text};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"shopid":shopID,@"sign":singStr,@"name":self.cagtTextField.text,@"sort":mess_field.text};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202016"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            if (self.isAddGoods == YES){ //直接跳到添加品类的那个地方
                int index = (int)[[self.navigationController viewControllers]indexOfObject:self]; [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
                //通知传值怎么样
                NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:jsonDic[@"data"][@"name"],@"textOne",jsonDic[@"data"][@"goodscateid"],@"textTwo",nil];
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"addCatetongzhi" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            } else {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinCateList" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }

    } failure:^(NSError *error) {
        nil;
    }];
}

//修改
- (void)changeQuest
{
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"shopid":shopID,@"name":self.cagtTextField.text,@"goodscateid":self.goodscateid,@"sort":mess_field.text};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"shopid":shopID,@"sign":singStr,@"name":self.cagtTextField.text,@"goodscateid":self.goodscateid,@"sort":mess_field.text};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202018"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinCateList" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark -- 确认按钮的点击事件
- (void)clickRightBtn:(UIButton *)sender
{
    if (self.cagtTextField.text.length == 0){
        [TCProgressHUD showMessage:@"品类名称不能为空"];
    } else {
        if (mess_field.text.length == 0) {
            [TCProgressHUD showMessage:@"请输入排序数值"];
        } else {
            //修改
            if (self.isChange == YES){
                [self changeQuest];
            } else {
                //请求接口
            [self AddRest];
         }
       }
    }
}

//点击return下滑
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.cagtTextField resignFirstResponder];
    [mess_field resignFirstResponder];
    return YES;
}

//点击屏幕 键盘下落
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.cagtTextField resignFirstResponder];
    [mess_field resignFirstResponder];
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
