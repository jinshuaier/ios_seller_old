//
//  TCBenefitViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCBenefitViewController.h"
#import "TCRecordTableViewCell.h"
@interface TCBenefitViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *rightButton;
    UIView *topView;
    UILabel *titleMoneyLabel;
    UILabel *transferMoneyLabel;
}
@property (nonatomic, strong) UITableView *classifyTable; //导航栏后面的tableView
@property (nonatomic, strong) NSArray *classifyArr; //后面的数组
@property (nonatomic, strong) NSString *className; //文字
@property (nonatomic, strong) UIView *backView;//添加背景颜色
@property (nonatomic, strong) NSString *selectedStr;//记录选中的按钮
@property (nonatomic, strong) UITableView *benefitTable; //tableview
@property (nonatomic, strong) NSMutableArray *benefitArr; 
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *topBackView;
@end

@implementation TCBenefitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化保存
    _userdefault = [NSUserDefaults standardUserDefaults];
    self.title = @"奖金";
    self.view.backgroundColor = backGgray;
    
    //右边导航栏的按钮
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80*WIDHTSCALE, 24)];
    
    // Add your action to your button
    self.className = @"全部账单"; // 这个是默认的值
    rightButton.selected = NO;
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTitle:self.className forState:(UIControlStateNormal)];
    rightButton.layer.borderColor=[UIColor whiteColor].CGColor;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    //数组里的数据
    self.classifyArr = @[@"全部账单",@"转账账单",@"奖金账单"];
    self.benefitArr = [[NSMutableArray alloc]init];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    
    //创建头部的View
    [self createTopView];
    //创建店铺管理tableView
    [self createbenefitTable];
    //下拉刷新
    [self setupRefresh:@"1"];
    // Do any additional setup after loading the view.
}
//添加刷新控件
- (void)setupRefresh:(NSString *)type{
    __block int  page = 1;
    self.benefitTable.userInteractionEnabled = NO;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self requests:type andpages:page];
    }];
    //设置刷新标题
    [header setTitle:@"下拉刷新顺道嘉订单..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新顺道嘉订单..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新顺道嘉订单..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    //上拉加载
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self request:page andtype:type];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉订单" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉订单..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉订单!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    self.benefitTable.mj_header = header;
    self.benefitTable.mj_footer = footer;
    [header beginRefreshing];
    
}
//下拉请求服务器
- (void)requests: (NSString *)type  andpages:(int)page{
    [self.benefitArr removeAllObjects];
    
    page = 1;
    
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"pageNum":@(page), @"type":type,@"limit":@"10"};
    
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"500005"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        
        
        if (dic[@"data"]) {
            [_benefitArr addObjectsFromArray:dic[@"data"][@"list"]];
            titleMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",dic[@"data"][@"bonus_blance"]];
            transferMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",dic[@"data"][@"free_bonus_blance"]];
        }else{
            titleMoneyLabel.text = @"¥ 0.00";
            transferMoneyLabel.text = @"¥ 0.00";
        }
            [self.benefitTable reloadData];
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            [self.benefitTable.mj_header endRefreshing];
            self.benefitTable.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        nil;
    }];
}

//上拉请求服务器
- (void)request:(int)page andtype: (NSString *)type{
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"pageNum":@(page), @"type":type,@"limit":@"10"};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"500005"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"  %@,%@",paramter, dic);
        
        if (dic[@"data"]) {
            [self.benefitArr addObjectsFromArray:dic[@"data"][@"list"]];
            [self.benefitTable reloadData];
            [self.benefitTable.mj_footer endRefreshing];
        }else{
            [self.benefitTable.mj_footer endRefreshing];
            [self.benefitTable.mj_footer endRefreshingWithNoMoreData];
        }
        
        self.benefitTable.userInteractionEnabled = YES;
    }  failure:^(NSError *error) {
        nil;
    }];
    
}

#pragma mark -- 创建头部的view
-(void)createTopView
{
    topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 0, WIDHT, 256/2 *HEIGHTSCALE);
    topView.backgroundColor = Color;
    [self.view addSubview:topView];
//总分润
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"总奖金";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(32 *WIDHTSCALE, 12*HEIGHTSCALE, 54*WIDHTSCALE, 18*HEIGHTSCALE);
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHTSCALE]];
    [topView addSubview:titleLabel];
    
    titleMoneyLabel = [[UILabel alloc]init];
    titleMoneyLabel.frame = CGRectMake(titleLabel.frame.size.width + titleLabel.frame.origin.x + 20*WIDHTSCALE, 12*HEIGHTSCALE, WIDHT - (20 + 32 + 54)*WIDHTSCALE, 18*HEIGHTSCALE);
//    titleMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",@"100.00"];
    titleMoneyLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    titleMoneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:0 alpha:1.0];
    [topView addSubview:titleMoneyLabel];
    
    UILabel *disLabel = [[UILabel alloc]init];
    disLabel.frame = CGRectMake(32 *WIDHTSCALE, titleLabel.frame.size.height + titleLabel.frame.origin.y + 8*HEIGHTSCALE, 8*12*WIDHTSCALE, 12*HEIGHTSCALE);
    disLabel.text = @"(所有奖金总和)";
    disLabel.textColor = [UIColor whiteColor];
    disLabel.font = [UIFont systemFontOfSize:12*HEIGHTSCALE];
    [topView addSubview:disLabel];
    
//可转账分润
    UILabel *transferLabel = [[UILabel alloc]init];
    transferLabel.text = @"可转账奖金";
    transferLabel.textColor = [UIColor whiteColor];
    transferLabel.frame = CGRectMake(32 *WIDHTSCALE, disLabel.frame.size.height + disLabel.frame.origin.y + 20 *HEIGHTSCALE, 90*WIDHTSCALE , 18*HEIGHTSCALE);
    [transferLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHTSCALE]];
    [topView addSubview:transferLabel];
    
    transferMoneyLabel = [[UILabel alloc]init];
    transferMoneyLabel.frame = CGRectMake(transferLabel.frame.size.width + transferLabel.frame.origin.x + 20*WIDHTSCALE, disLabel.frame.size.height + disLabel.frame.origin.y + 20 *HEIGHTSCALE,  WIDHT - (20 + 32 + 90)*WIDHTSCALE, 18*HEIGHTSCALE);
//    transferMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",@"50.00"];
    transferMoneyLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    transferMoneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:0 alpha:1.0];
    [topView addSubview:transferMoneyLabel];
    
    UILabel *distransferLabel = [[UILabel alloc]init];
    distransferLabel.frame = CGRectMake(32 *WIDHTSCALE, transferLabel.frame.size.height + transferLabel.frame.origin.y + 8*HEIGHTSCALE, 12*12*WIDHTSCALE, 12*HEIGHTSCALE);
    distransferLabel.text = @"(可转到金额提现的奖金)";
    distransferLabel.textColor = [UIColor whiteColor];
    distransferLabel.font = [UIFont systemFontOfSize:12*HEIGHTSCALE];
    [topView addSubview:distransferLabel];
    
//添加转到金额的按钮
    UIButton *moneyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    moneyBtn.frame = CGRectMake(WIDHT - (12 + 64)*WIDHTSCALE, topView.frame.size.height + topView.frame.origin.y - (25 + 25)*HEIGHTSCALE, 64*WIDHTSCALE, 25*HEIGHTSCALE);
    [moneyBtn setBackgroundImage:[UIImage imageNamed:@"转到金额按钮"] forState:(UIControlStateNormal)];
    [moneyBtn addTarget:self action:@selector(moneyBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:moneyBtn];
    

}
#pragma mark -- button的点击事件
-(void)moneyBtn
{
    if([transferMoneyLabel.text isEqualToString:@"¥ 0.00"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂时还没有可转奖金" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    //背景色
    _topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _topBackView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    _topBackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:_topBackView];
    //自定义的弹窗
    UIView *shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake((WIDHT - 592*WIDHTSCALE/2)/2, (_topBackView.frame.size.height - 140 *HEIGHTSCALE)/2, 592/2*WIDHTSCALE, 140*HEIGHTSCALE);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 4;
    shoperView.layer.borderWidth = 0.1;
    [_topBackView addSubview:shoperView];
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.frame = CGRectMake(0, 0, 592/2*WIDHTSCALE, 200/2*HEIGHTSCALE);
    messageLabel.text = [NSString stringWithFormat:@"确定将%@转到金额？",transferMoneyLabel.text];
    messageLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0  blue:77/255.0  alpha:1.0];
    messageLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [shoperView addSubview:messageLabel];
    
    //添加两个按钮
    UIButton *cauleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cauleBtn.frame = CGRectMake(0, 100*HEIGHTSCALE, 296/2*WIDHTSCALE, 40*HEIGHTSCALE);
    [cauleBtn setBackgroundImage:[UIImage imageNamed:@"取消按钮"] forState:(UIControlStateNormal)];
    [cauleBtn setBackgroundImage:[UIImage imageNamed:@"取消按钮-（点击）"] forState:(UIControlStateHighlighted)];
    [cauleBtn addTarget:self action:@selector(cauleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:cauleBtn];
    
    UIButton *trueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    trueBtn.frame = CGRectMake(296/2*WIDHTSCALE, 100*HEIGHTSCALE, 296/2*WIDHTSCALE, 40*HEIGHTSCALE);
    [trueBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮"] forState:(UIControlStateNormal)];
    [trueBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮（点击）"] forState:(UIControlStateHighlighted)];
    [trueBtn addTarget:self action:@selector(trueBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:trueBtn];
    }
}

#pragma mark -- 按钮点击事件
-(void)cauleBtn
{
    [_topBackView removeFromSuperview];
}

-(void)trueBtn
{
    NSLog(@"确定转了");
    [_topBackView removeFromSuperview];
    //转到金额的接口
    [self createBrnefitQueste];
}
#pragma mark -- 转到金额的接口
-(void)createBrnefitQueste
{
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"]};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"500006"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"  %@,%@",paramter, dic);
        [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
        //发送刷新
        //发送通知 要求刷新页面
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
        
        [self setupRefresh:@"1"];
    }  failure:^(NSError *error) {
        nil;
    }];
    
}

#pragma mark -- 创建tableView
-(void)createbenefitTable{
    _benefitTable = [[UITableView alloc]init];
    _benefitTable.frame = CGRectMake(0, topView.frame.size.height + topView.frame.origin.y, WIDHT, HEIGHT - topView.frame.size.height - 64 );
    _benefitTable.delegate = self;
    _benefitTable.dataSource = self;
    _benefitTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_benefitTable];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.classifyTable) {
        return 1;
    }else{
        return 0;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classifyTable) {
        return 40 *HEIGHTSCALE;
    }else{
        return 60  ;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.classifyTable) {
        return self.classifyArr.count;
    }else{
        return self.benefitArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classifyTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
            cell.textLabel.text = self.classifyArr[indexPath.section];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if ([self.classifyArr[indexPath.section] isEqualToString:_selectedStr]) {
                cell.textLabel.textColor = [UIColor redColor];
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }else{
        [self.benefitTable registerNib:[UINib nibWithNibName:@"TCRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
         TCRecordTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if(self.benefitArr.count == 0){
            NSLog(@"不知道");
        }else{
        cells.nameLabel.text = self.benefitArr[indexPath.section][@"tt"];
        cells.nameLabel.textColor = FontColor;
        cells.phoneLabel.text = self.benefitArr[indexPath.section][@"sourceMid"];
        cells.phoneLabel.textColor = SmallTitleColor;
        cells.priceLabel.text = [NSString stringWithFormat:@"¥ %@",self.benefitArr[indexPath.section][@"money"]];
        cells.priceLabel.textColor = RedColor;
        cells.timeLabel.text = self.benefitArr[indexPath.section][@"createTime"];
        cells.timeLabel.textColor = SmallTitleColor;
        
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        return cells;
    }
    return cells;
}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.classifyTable) {
        [rightButton setTitle:self.classifyArr[indexPath.section] forState:UIControlStateNormal];
        if(indexPath.section == 0){
            [self setupRefresh:@"1"];
        }else if (indexPath.section == 1){
           [self setupRefresh:@"3"];
        }else if (indexPath.section == 2){
            [self setupRefresh:@"2"];
        }
        
        
        self.className = self.classifyArr[indexPath.section];
        _selectedStr = self.classifyArr[indexPath.section];
        [rightButton setTitle:self.className forState:(UIControlStateNormal)];
        rightButton.selected = NO;
        [_backView removeFromSuperview];
        
    }
}

#pragma mark -- 导航栏右边按钮的点击事件
-(void)barButtonItemPressed:(UIButton *)send{
    if(send.selected == NO){
        send.selected = YES;
        [send setTitle:self.className forState:(UIControlStateSelected)];
        
        //创建背景颜色
        [self createBackView];
        //创建tableView
        [self classifyTableView];
    }else {
        send.selected = NO;
        [self.backView removeFromSuperview];
    }
}
#pragma mark -- 创建全部的详情
-(void)classifyTableView
{
    self.classifyTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDHT - 100, 0, 100, 40*HEIGHTSCALE * 3)];
    self.classifyTable.delegate = self;
    self.classifyTable.dataSource = self;
    self.classifyTable.showsVerticalScrollIndicator = NO;
    self.classifyTable.tableFooterView = [[UIView alloc]init];
    [self.backView addSubview:self.classifyTable];
    
}
//背景颜色
-(void)createBackView{
    //创建背景颜色
    self.backView = [[UIView alloc]init];
    self.backView .backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    self.backView .frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    [self.view addSubview:self.backView];
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
