  //
//  TCWithdrawMoneyViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCWithdrawMoneyViewController.h"
#import "TCChooseBankInfo.h"
#import "TCChooseBankCell.h"
#import "TCMyBankViewController.h"
#import "DCPaymentView.h"
#import "TCDeviceName.h"
#import "TCSetpwdViewController.h"

@interface TCWithdrawMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIButton *agreenButton;
}
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSDictionary *dicMes;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) UILabel *cardLabel;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSString *codeid;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) DCPaymentView *paymentView;
@end

@implementation TCWithdrawMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"剩余额度";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.dataArr = [NSMutableArray array];
    self.arr = [NSMutableArray array];
    //创建View
    [self createUI];
    [self creatRequest];
    // Do any additional setup after loading the view.
}

-(void)creatRequest{
    [self.dataArr removeAllObjects];
     [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"sign":singStr,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201026"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        for (NSDictionary *infoDic in jsonDic[@"data"]) {
            NSString *bank = infoDic[@"bank"];
            [self.arr addObject:bank];
        }
        if (self.arr.count != 0) {
            self.dicMes = jsonDic[@"data"][0];
            self.typeStr = [NSString stringWithFormat:@"%@",self.dicMes[@"type"]];
            if ([self.typeStr isEqualToString:@"0"]) {
                NSString *str = @"借记卡";
                self.codeid = [NSString stringWithFormat:@"%@",self.dicMes[@"id"]];
                self.cardLabel.text = [NSString stringWithFormat:@"中国%@%@（%@)",self.dicMes[@"bank"],str,self.dicMes[@"last_four"]];
            }else if([self.typeStr isEqualToString:@"1"]){
                NSString *str = @"借贷卡";
                self.codeid = [NSString stringWithFormat:@"%@",self.dicMes[@"id"]];
                self.cardLabel.text = [NSString stringWithFormat:@"中国%@%@（%@)",self.dicMes[@"bank"],str,self.dicMes[@"last_four"]];
            }else if([self.typeStr isEqualToString:@"2"]){
                NSString *str = @"其他卡";
                self.codeid = [NSString stringWithFormat:@"%@",self.dicMes[@"id"]];
                self.cardLabel.text = [NSString stringWithFormat:@"中国%@%@（%@)",self.dicMes[@"bank"],str,self.dicMes[@"last_four"]];
            }
            
            NSLog(@"selfdic:%@",self.dicMes);
            for (NSDictionary *infoDic in jsonDic[@"data"]) {
                TCChooseBankInfo *model = [TCChooseBankInfo orderInfoWithDictionary:infoDic];
                [self.dataArr addObject:model];
            }
            NSLog(@"%lu",(unsigned long)self.dataArr.count);
            [self.mainTableView reloadData];
        }else{
            nil;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        nil;
    }];
   // [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201026"]
}

//创建View
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    headView.frame = CGRectMake(12, 12, WIDHT - 24, 165);
    [self.view addSubview:headView];
    //提现至
    UILabel *titleLable = [UILabel publicLab:@"提现至" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    titleLable.frame = CGRectMake(10, 0, 45, 43);
    [headView addSubview:titleLable];
    //银行卡
    UILabel *bankLabel = [UILabel publicLab:@"中国某某银行储蓄卡（8888）" textColor:TCUIColorFromRGB(0x3A759E) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    self.cardLabel = bankLabel;
    bankLabel.userInteractionEnabled = YES;
    bankLabel.frame = CGRectMake(CGRectGetMaxX(titleLable.frame), 0, WIDHT - 24 - 27 - (CGRectGetMaxX(titleLable.frame)), 43);
    [headView addSubview:bankLabel];
    
    
    //手势
    UITapGestureRecognizer *bankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankTap)];
    [bankLabel addGestureRecognizer:bankTap];
    
    //进入的三角
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"进入小三角（灰）"];
    image.frame = CGRectMake(WIDHT - 24 - 12 - 5, (43 - 8)/2, 5, 8);
    [headView addSubview:image];
    //下划线
    UIView *line_oneView = [[UIView alloc] init];
    line_oneView.frame = CGRectMake(10, 43, WIDHT - 24 - 20, 1);
    line_oneView.backgroundColor = TCLineColor;
    [headView addSubview:line_oneView];
    //提现金额
    UILabel *wirthLabel = [UILabel publicLab:@"提现金额" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    wirthLabel.frame = CGRectMake(10, CGRectGetMaxY(line_oneView.frame) + 15.5, 60, 14);
    [headView addSubview:wirthLabel];
    //人民币的符号
    UILabel *monIconLabel = [UILabel publicLab:@"¥" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:24 numberOfLines:0];
    monIconLabel.frame = CGRectMake(12, CGRectGetMaxY(wirthLabel.frame) + 15, 15, 24);
    [headView addSubview:monIconLabel];
    
    //输入框
    UITextField *monField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(monIconLabel.frame) + 5, CGRectGetMaxY(wirthLabel.frame) + 15, WIDHT - 24 - (CGRectGetMaxX(monIconLabel.frame) + 5) - 12, 24)];
    monField.tag = 3004;
    monField.delegate = self;
    [monField addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    monField.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    monField.textColor = TCUIColorFromRGB(0x333333);
    monField.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    monField.borderStyle = UITextBorderStyleNone;
    [headView addSubview:monField];
    
    
    //下划线
    UIView *line_twoView = [[UIView alloc] init];
    line_twoView.backgroundColor = TCLineColor;
    line_twoView.frame = CGRectMake(10, CGRectGetMaxY(monField.frame) + 10, WIDHT - 24 - 20, 1);
    [headView addSubview:line_twoView];
    
    //金额
    UILabel *drawLabel = [UILabel publicLab:[NSString stringWithFormat:@"可提现余额¥%@",self.banlanceStr] textColor:TCUIColorFromRGB(0x999C9E) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
    drawLabel.frame = CGRectMake(12, CGRectGetMaxY(line_twoView.frame), WIDHT/2, 39);
    [headView addSubview:drawLabel];
    
    //全部提现的按钮
    UIButton *allDrawBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    allDrawBtn.frame = CGRectMake(WIDHT - 24 - 12 - 48, CGRectGetMaxY(line_twoView.frame), 48, 39);
    [allDrawBtn setTitle:@"全部提现" forState:(UIControlStateNormal)];
    [allDrawBtn setTitleColor:TCUIColorFromRGB(0x3A759E) forState:(UIControlStateNormal)];
    allDrawBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [allDrawBtn addTarget:self action:@selector(allDrawBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [headView addSubview:allDrawBtn];
    
    //按钮
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(headView.frame) + 13, 16, 16)];
    self.checkBtn.selected = YES;
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"小选中框"] forState:(UIControlStateSelected)];
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
    [self.checkBtn addTarget:self action:@selector(clickCheck:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.checkBtn];
    
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkBtn.frame) + 5, CGRectGetMaxY(headView.frame) + 15, 24, 12)];
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    agreeLabel.textColor = TCUIColorFromRGB(0x333333);
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:agreeLabel];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(agreeLabel.frame), CGRectGetMaxY(headView.frame) + 15, 100, 12)];
    [serviceBtn setBackgroundColor:TCBgColor];
    [serviceBtn setTitle:@"《用户服务协议》" forState:(UIControlStateNormal)];
    [serviceBtn setTitleColor:TCUIColorFromRGB(0x4CA6FF) forState:(UIControlStateNormal)];
    [serviceBtn addTarget:self action:@selector(clickService:) forControlEvents:(UIControlEventTouchUpInside)
     ];
    serviceBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    serviceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:serviceBtn];
    
    //下一步
    //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.sureBtn = button;
    button.frame = CGRectMake(12, CGRectGetMaxY(self.checkBtn.frame) + 48, WIDHT - 24, 46);
    self.sureBtn.alpha = 0.6;
    self.sureBtn.userInteractionEnabled = NO;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"24小时到账，确认提现" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

#pragma mark -- allDrawBtnAction
- (void)allDrawBtnAction:(UIButton *)sender
{
    NSLog(@"全部提现");
    UITextField *money_textfield = (UITextField *)[self.view viewWithTag:3004];
    money_textfield.text = self.banlanceStr;
}

- (void)alueChange:(UITextField *)textField{
    UITextField *man_textfield = (UITextField *)[self.view viewWithTag:3004];
    _sureBtn.enabled = (man_textfield.text.length != 0);
    if(_sureBtn.enabled == YES){
        _sureBtn.userInteractionEnabled = YES;
        _sureBtn.alpha = 1;
    }else{
        _sureBtn.alpha = 0.6;
        _sureBtn.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 提现
- (void)buttonAction:(UIButton *)sender
{
    UITextField *moneyField = (UITextField *)[self.view viewWithTag:3004];
    NSInteger money = [moneyField.text integerValue];
    if (_checkBtn.selected == NO) {
        [TCProgressHUD showMessage:@"没有同意用户服务协议是不行的"];
    }else if (money < 10){
        [TCProgressHUD showMessage:@"余额小于10元不可提现"];
    }else{
        
        DCPaymentView *payAlert = [[DCPaymentView alloc]init];
        self.paymentView = payAlert;
        payAlert.tag = 3212;
        payAlert.title = @"输入提现密码";
        [payAlert.forgetBtn addTarget:self action:@selector(clickForget:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [payAlert show];
        payAlert.completeHandle = ^(NSString *inputPwd) {
            NSLog(@"密码是%@",inputPwd);
            if (inputPwd.length == 6) {
                self.password = inputPwd;
                [self yanRequest];
                [payAlert dismiss];
            }
            
            //            [TCProgressHUD showMessage:@"提现成功"];
        };
    }
}
-(void)clickForget:(UIButton *)sender{
    [self.paymentView dismiss];
    TCSetpwdViewController *setVC = [[TCSetpwdViewController alloc]init];
    setVC.entranceTypeStr = @"2";
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void)yanRequest{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"payCode":self.password};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"sign":singStr,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"payCode":self.password};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201031"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [self drawRequest];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        nil;
    }];
}
-(void)drawRequest{
    UITextField *man_textfield = (UITextField *)[self.view viewWithTag:3004];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *mmdid = [TCGetDeviceId getDeviceId];
    NSString *deviceid = [TCDeviceName getDeviceName];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"bankcardid":self.codeid,@"money":man_textfield.text,@"terminal":@"IOS",@"deviceid":deviceid,@"mmdid":mmdid};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"sign":singStr,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"bankcardid":self.codeid,@"money":man_textfield.text,@"terminal":@"IOS",@"deviceid":deviceid,@"mmdid":mmdid};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201024"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];
    }];
   // [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201026"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
}

-(void)creatalpView{
    self.bgView = [[UIView alloc] init];
    self.bgView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,240, 135)];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 8;
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.bgView addSubview:contentView];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 55)];
    topView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [contentView addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((240 - 90)/2, 16, 90, 22)];
    titleLabel.text = @"选择银行卡";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    titleLabel.textColor = TCUIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    UIButton *closebtn = [[UIButton alloc]initWithFrame:CGRectMake(240 - 12 - 12, 21, 12, 12)];
    [closebtn setBackgroundImage:[UIImage imageNamed:@"关闭按钮"] forState:(UIControlStateNormal)];
    [closebtn addTarget:self action:@selector(clickClose) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:closebtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 15, 240, 1)];
    line.backgroundColor = TCLineColor;
    [topView addSubview:line];
    
    NSLog(@"%lu",self.dataArr.count);
    
    self.mainTableView = [[UITableView alloc]init];
    if (self.dataArr.count <= 3) {
        self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), 240, (self.dataArr.count + 1) *40);
        self.mainTableView.scrollEnabled = NO;
    }else{
        self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), 240, 160);
        self.mainTableView.scrollEnabled = YES;
    }
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [contentView addSubview:self.mainTableView];
    
    contentView.frame = CGRectMake(0, 0,240, CGRectGetMaxY(self.mainTableView.frame));
    contentView.center = CGPointMake(WIDHT/2, HEIGHT/2);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count + 1;
}


//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
        return headerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCChooseBankCell *cell = [[TCChooseBankCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    if (self.dataArr.count != 0) {
        if (indexPath.row < self.dataArr.count) {
            cell.model = self.dataArr[indexPath.row];
            cell.checkBtn.tag = 1000 + indexPath.row;
            cell.checkBtn.hidden = YES;
            [cell.checkBtn addTarget:self action:@selector(clickChe:) forControlEvents:(UIControlEventTouchUpInside)];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, 240, 1)];
            line.backgroundColor = TCLineColor;
            [cell.contentView addSubview:line];
        }else if (indexPath.row == self.dataArr.count){
            cell.txtLabel.hidden = YES;
            UILabel *txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 15, 80, 10)];
            txtLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            txtLabel.textColor = TCUIColorFromRGB(0x333333);
            txtLabel.textAlignment = NSTextAlignmentLeft;
            txtLabel.text = @"添加银行卡";
            [cell.contentView addSubview:txtLabel];
            [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"黄色添加"] forState:(UIControlStateNormal)];
            cell.checkBtn.userInteractionEnabled = NO;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击的是%ld行",(long)indexPath.row);
    [self clickClose];
    if (indexPath.row == self.dataArr.count) {
        
        TCMyBankViewController *bankVC = [[TCMyBankViewController alloc]init];
        bankVC.isDraw = YES;
        bankVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bankVC animated:YES];
    }else{
        TCChooseBankCell *cell = (TCChooseBankCell*)[self.view viewWithTag:1000 + indexPath.row];
        cell.checkBtn.selected = !cell.checkBtn.selected;
        TCChooseBankInfo* model = self.dataArr[indexPath.row];
        NSString * bank = model.bank;
        NSString *tyStr;
        NSString *type = model.type;
        NSString *laftfour = model.last_card_4;
        if ([type isEqualToString:@"0"]) {
            tyStr = @"借记卡";
        }else if ([type isEqualToString:@"1"]){
            tyStr = @"借贷卡";
        }else{
            tyStr = @"其他卡";
        }
        self.cardLabel.text = [NSString stringWithFormat:@"中国%@%@（%@)",bank,tyStr,laftfour];
        self.codeid = model.cardid;
        
    }
    
}

-(void)clickChe:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)clickClose{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}


//点击用户服务协议
-(void)clickService:(UIButton*)sender{
    NSLog(@"点击了用户服务协议");
}
-(void)clickCheck:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark -- 银行卡
- (void)bankTap
{
    NSLog(@"银行卡");
    [self creatalpView];
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
