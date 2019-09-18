//
//  TCFullCutViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCFullCutViewController.h"
#import "TCChooseSlideView.h"
#import "TCAddActiveViewController.h"
#import "TCActivewCell.h"

@interface TCFullCutViewController ()<UITableViewDelegate,UITableViewDataSource,TCChooseSlideProtocol>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) TCChooseSlideView *sliderView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSString *shopID;
@property (nonatomic, strong) NSDictionary *messDic;

@end

@implementation TCFullCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"满减优惠";
    self.dataArr = [NSMutableArray array];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    [self creatUI];
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDHT - 15 - 30, 15, 30, 14)];
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"添加" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    //创建View
    [self creatUI];
    [self creatRequest];
    // Do any additional setup after loading the view.
}
-(void)creatRequest{
    [SVProgressHUD showWithStatus:@"加载中..."];
    self.view.userInteractionEnabled = NO;
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":self.shopID};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":mid,@"token":token,@"shopid":self.shopID};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201017"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *str = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([str isEqualToString:@"1"]) {
            self.messDic = jsonDic[@"data"];
            self.dataArr = self.messDic[@"waiting"];
            [self.mainTableView reloadData];
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        self.view.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];
    }];
    //[TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201016"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
}

-(void)shuaxin{
    [self creatRequest];
}
-(void)creatUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"returndis" object:nil];
    
//    UIView *headView = [[UIView alloc] init];
//    headView.backgroundColor = TCNavColor;
//    headView.frame = CGRectMake(0, 0, WIDHT, 44);
//    [self.view addSubview:headView];
    
    self.sliderView = [[TCChooseSlideView alloc]init];
    self.sliderView.frame = CGRectMake(0, 0, WIDHT, 44);
    self.sliderView.backgroundColor = TCNavColor;
    [self.view addSubview:self.sliderView];
    self.sliderView.sliderDelegate = self;
    NSArray *menuArray = [NSArray arrayWithObjects:@"未开始",@"进行中", @"已结束",nil];
    [self.sliderView  setNameWithArray:menuArray];
    [self _getTag:0];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sliderView.frame), WIDHT, HEIGHT - CGRectGetMaxY(self.sliderView.frame) - 64) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = TCBgColor;
    [self.view addSubview:self.mainTableView];
}

#pragma mark -- UITableViewDelegate
#pragma mark -- tableViewDelegateMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
        headerView.backgroundColor = TCBgColor;
        return headerView;
    }
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 225;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 10;
    }
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCActivewCell *cell = [[TCActivewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    if (self.dataArr.count != 0) {
        cell.name.text = self.dataArr[indexPath.section][@"content"];
        cell.condition.text = [NSString stringWithFormat:@"满%@元",self.dataArr[indexPath.section][@"achieve"]];
        cell.discount.text = [NSString stringWithFormat:@"减%@元",self.dataArr[indexPath.section][@"reduce"]];
        cell.starttime.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.section][@"startTime"]];
        cell.endtime.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.section][@"endTime"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//添加新的活动
-(void)barButtonItemPressed:(UIButton *)sender{
    NSLog(@"添加新的活动");
    TCAddActiveViewController *addActive = [[TCAddActiveViewController alloc]init];
    addActive.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addActive animated:YES];
}

#pragma mark -- 实现
//实现协议方法;
-(void)_getTag:(NSInteger)tag
{
    if (tag == 0){
        NSLog(@"未开始");
        self.dataArr = self.messDic[@"waiting"];
        [self.mainTableView reloadData];
    }else if (tag == 1){
        NSLog(@"进行中");
        self.dataArr = self.messDic[@"online"];
        [self.mainTableView reloadData];
    } else {
        NSLog(@"已结束");
        self.dataArr = self.messDic[@"finished"];
        [self.mainTableView reloadData];
    }
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
