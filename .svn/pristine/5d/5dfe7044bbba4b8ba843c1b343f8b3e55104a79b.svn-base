//
//  TCMyBankViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMyBankViewController.h"
#import "TCBankTableViewCell.h"
#import "TCBankCardInfo.h"
#import "TCinputPViewController.h"


@interface TCMyBankViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSUserDefaults *userdefault;

@end

@implementation TCMyBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.dataArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxinlist) name:@"returnbanklist" object:nil];
    [self creatUI];
    [self creatRequest];
    // Do any additional setup after loading the view.
}
-(void)shuaxinlist{
    [self creatRequest];
}
-(void)creatRequest{
    [self.dataArr removeAllObjects];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"sign":singStr,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201026"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            for (NSDictionary *infoDic in jsonDic[@"data"]) {
                TCBankCardInfo *model = [TCBankCardInfo orderInfoWithDictionary:infoDic];
                [self.dataArr addObject:model];
                [self.mainTableView reloadData];
            }
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
    // dicc = [TCServerSecret report:parameters];
   // [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202006"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic)
}
-(void)creatUI{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(12,0, WIDHT - 24, HEIGHT - 48) style:UITableViewStyleGrouped];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.backgroundColor = TCBgColor;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
//    AdjustsScrollViewInsetNever(self,self.mainTableView);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[TCBankTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mainTableView];
    
    UIButton * Btn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT - 48 - 64, WIDHT - 30, 48)];
    Btn.layer.masksToBounds = YES;
    Btn.layer.cornerRadius = 5;
    [Btn setTitle:@"添加银行卡" forState:(UIControlStateNormal)];
    [Btn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [Btn addTarget:self action:@selector(clcikAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    [Btn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    Btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Btn];
}

#pragma mark -- dataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDHT, 0)];
        headerView.backgroundColor = TCBgColor;
        return headerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.dataArr.count - 1) {
        return 40;
    }else{
        return 0.1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCBankTableViewCell *cell = [[TCBankTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    if (self.dataArr.count != 0) {
        cell.model = self.dataArr[indexPath.section];
    }
    NSString *imageStr = [NSString stringWithFormat:@"http://img.moumou001.com/banks/%@.png",cell.model.bankCode];
    [cell.imageTop sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)clcikAdd:(UIButton *)sender{
    TCinputPViewController *inpPass = [[TCinputPViewController alloc]init];
    inpPass.entranceTypeStr = @"4";
    inpPass.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inpPass animated:YES];
    
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
