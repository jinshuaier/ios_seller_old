//
//  TCFinanialViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCFinanialViewController.h"
#import "TCFinanDetailViewController.h" // 账单明细
#import "TCTerminalViewController.h"
#import "TCOrderNumViewController.h" //总订单数
#import "TCOrderSellViewController.h" //总销售额
#import "TCOrderBalanViewController.h" //总奖金
#import "TCTotalMoneyViewController.h" //账务总金额
#import "TCMyBankViewController.h"
#import "TCSetpwdViewController.h"

@interface TCFinanialViewController ()
@property (nonatomic, strong) NSUserDefaults *userDefault;
@property (nonatomic, strong) NSDictionary *dic; //保留数据
@property (nonatomic, strong) NSDictionary *dicc;
@property (nonatomic, assign) BOOL isPay;

@end

@implementation TCFinanialViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.userDefault = [NSUserDefaults standardUserDefaults];
    //请求财务总金额
    [self quest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"财务管理";
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80*WIDHTSCALE, 17)];
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"账单明细" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    // Do any additional setup after loading the view.
}

//请求财务总金额
- (void)quest
{
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userDefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userDefault valueForKey:@"userToken"]];
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    
    NSString *singStr = [TCServerSecret loginStr:dicc];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201025"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            NSLog(@"%@",jsonDic);
            self.dicc = jsonDic;
            
            //请求接口
            [self finanialQuest];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//请求接口
- (void)finanialQuest
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userDefault valueForKey:@"shopID"]];
    NSDictionary *dicc;
    //判断是否有shopID
    if ([shopID isEqualToString:@"0"]){
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *midStr = [NSString stringWithFormat:@"%@",[_userDefault valueForKey:@"userID"]];
        NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userDefault valueForKey:@"userToken"]];
        NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
        
        NSString *singStr = [TCServerSecret loginStr:dic];
        dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};        
    } else {
        NSDictionary *dic = @{@"shopId":shopID};
        NSString *singStr = [TCServerSecret signStr:dic];
        NSDictionary *parameters = @{@"shopId":shopID,@"sign":singStr};
        dicc = [TCServerSecret report:parameters];
    }
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202006"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        self.dic = jsonDic[@"data"];
        //创建View
        [self createUI];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];
        
    }];
}

//创建View
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, WIDHT, 145);
    headView.backgroundColor = TCNavColor;
    [self.view addSubview:headView];
    //账单总结额的标题
    UILabel *titleLabel = [UILabel publicLab:@"账户总金额" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    titleLabel.frame = CGRectMake(0, 9, WIDHT, 13);
    [headView addSubview:titleLabel];
    //金额
    UILabel *monLabel = [UILabel publicLab:nil textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Semibold" size:30 numberOfLines:0];
    monLabel.userInteractionEnabled = YES;
    if (self.dicc == nil){
        monLabel.text = @"0";
    } else {
        monLabel.text = self.dicc[@"data"];
    }
    monLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5, WIDHT, 42);
    
    UITapGestureRecognizer *monTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(monTap)];
    [monLabel addGestureRecognizer:monTap];
    
    [headView addSubview:monLabel];
    //view
    NSArray *titleArr = @[@"总销售额",@"订单统计",@"累计奖金"];
    NSArray *numArr;
    if (self.dic == nil) {
       numArr = @[@"0",@"0",@"0"];
    } else {
       numArr = @[self.dic[@"totalSellerMoney"],self.dic[@"totalOrderNum"],self.dic[@"bonus_balance"]];
    }
    for (int i = 0; i < titleArr.count; i++ ) {
        UILabel *evaLabel = [UILabel publicLab:titleArr[i] textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:13 numberOfLines:0];
        evaLabel.frame = CGRectMake(WIDHT/3 * i, CGRectGetMaxY(monLabel.frame) + 17, WIDHT/3, 14);
        [headView addSubview:evaLabel];
        
        //数量
        UILabel *numLabel = [UILabel publicLab:numArr[i] textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Semibold" size:20 numberOfLines:0];
        numLabel.userInteractionEnabled = YES;
        numLabel.tag = 1000 + i;
        numLabel.frame = CGRectMake(WIDHT/3 *i, CGRectGetMaxY(evaLabel.frame), WIDHT/3, 45);
        [headView addSubview:numLabel];
        //两个线
        if (i < 2){
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(WIDHT/3 + WIDHT/3*i,CGRectGetMaxY(evaLabel.frame) + 16, 1, 11);
            lineView.backgroundColor = TCLineColor;
            [headView addSubview:lineView];
        }
        //加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [numLabel addGestureRecognizer:tap];
    }
    
    //加view
    for (int j = 0; j < 3; j ++) {
        UIView *mainView = [[UIView alloc] init];
        mainView.frame = CGRectMake(0,CGRectGetMaxY(headView.frame) +  10 + 45 * j, WIDHT, 45);
        mainView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        mainView.tag = 100 + j;
        mainView.userInteractionEnabled = YES;
        [self.view addSubview:mainView];
        // label
        NSArray *mainTileArr = @[@"终端机保证金",@"银行卡管理",@"设置支付密码"];
        UILabel *mianLabel = [UILabel publicLab:mainTileArr[j] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
        mianLabel.frame = CGRectMake(15, 0, WIDHT - 15, 45);
        [mainView addSubview:mianLabel];
        
        if (j < 2){
            //线
            UIView *viewline = [[UIView alloc] init];
            viewline.backgroundColor = TCLineColor;
            viewline.frame = CGRectMake(0, 44, WIDHT, 1);
            [mainView addSubview:viewline];
        }
        
        //加手势
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [mainView addGestureRecognizer:tapAction];
        
    }
}

#pragma mark -- 手势的点击事件
- (void)tap:(UITapGestureRecognizer *)tap {
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    if ([singleTap view].tag == 1000){
        NSLog(@"总销售了");
        TCOrderSellViewController *orderVC = [[TCOrderSellViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    } else if ([singleTap view].tag == 1001){
        NSLog(@"订单统计");
        TCOrderNumViewController *orderVC = [[TCOrderNumViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    } else if ([singleTap view].tag == 1002){
        NSLog(@"累计奖金");
        TCOrderBalanViewController *orderVC = [[TCOrderBalanViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
}

#pragma mark -- 手势的点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    if ([singleTap view].tag == 100){
        NSLog(@"终端机保证金");
//        TCTerminalViewController *terminaVC = [[TCTerminalViewController alloc] init];
//        terminaVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:terminaVC animated:YES];
        [TCProgressHUD showMessage:@"暂未开启"];
        
    } else if ([singleTap view].tag == 101){
        NSLog(@"银行卡管理");
        TCMyBankViewController *myBankVC = [[TCMyBankViewController alloc]init];
        myBankVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myBankVC animated:YES];
        
    } else if ([singleTap view].tag == 102){
        NSLog(@"设置支付密码");
        TCSetpwdViewController *setpwdVC = [[TCSetpwdViewController alloc]init];
        setpwdVC.entranceTypeStr = @"1";
        if (self.isPay == YES) {
            setpwdVC.titleStr = @"修改支付密码";
        }else{
            setpwdVC.titleStr = @"设置支付密码";
        }
        setpwdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setpwdVC animated:YES];
    }
}

#pragma mark -- 账单明细的点击事件
- (void)barButtonItemPressed:(UIButton *)sender
{
    NSLog(@"订单明细");
    TCFinanDetailViewController *finanVC = [[TCFinanDetailViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:finanVC animated:YES];
}

#pragma mark -- 总金额
- (void)monTap
{
    TCTotalMoneyViewController *totalVC = [[TCTotalMoneyViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:totalVC animated:YES];
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
