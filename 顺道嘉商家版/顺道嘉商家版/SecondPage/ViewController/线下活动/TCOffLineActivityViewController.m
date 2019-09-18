//
//  TCOffLineActivityViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/23.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOffLineActivityViewController.h"
#import "TCCreateOffActityViewController.h"
#import "TCOffLineTableViewCell.h"
#import "TCActityExplainView.h"
#import "TCCheckActityView.h"
#import "TCOffLine.h"
@interface TCOffLineActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *offLineTableView;
@property (nonatomic, strong) UIButton *rightButton;//导航栏右边的按钮
@property (nonatomic, strong) UIImageView *noActityImage; //没有活动的图片
@property (nonatomic, strong) UILabel *noActityLabel; //没有活动的文字
@property (nonatomic, strong) UIButton *setActityBtn; //创建活动的按钮
@property (nonatomic, strong) UILabel *haveActityLabel; //有活动的文字
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic , strong) NSMutableArray *dataArry;
@property (nonatomic , assign) CGFloat cellHeight;
@property (nonatomic ,strong) CAGradientLayer *gradientLayer;
@end

@implementation TCOffLineActivityViewController

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.dataArry = [NSMutableArray array];
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    //创建导航栏的View
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, WIDHT, 64);
    navView.backgroundColor = mainColor;
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, 22, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backBtn];
    //店铺的标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 33, WIDHT, 18);
    titleLabel.text = @"店铺活动";
    titleLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    //活动说明
    UIButton *actityExBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    actityExBtn.frame = CGRectMake(WIDHT - 12 - 60, 35, 60, 15);
    [actityExBtn setTitle:@"活动说明" forState:(UIControlStateNormal)];
    [actityExBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    actityExBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [actityExBtn addTarget:self action:@selector(actityExBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:actityExBtn];
    //刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offLine) name:@"offLineShuaxin" object:nil];
    //修改活动的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeActity:) name:@"changeActity" object:nil];
       //创建有活动的页面
    [self createTable];
    //加刷新
    [self setupRefresh];

    // Do any additional setup after loading the view.
}
//刷新
-(void)offLine
{
   [self setupRefresh]; 
}
//添加刷新控件
- (void)setupRefresh{
    __block int  page = 1;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self createQueste];
    }];
    //设置刷新标题
    [header setTitle:@"下拉刷新顺道嘉..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新顺道嘉..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新顺道嘉..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    //加入tableview中
    self.offLineTableView.mj_header = header;
    [header beginRefreshing];
}

#pragma mark -- 请求接口
-(void)createQueste
{
    [self.dataArry removeAllObjects];
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"shopid":[_userdefault valueForKey:@"shopID"]};
    NSLog(@"%@",paramter);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200030"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if (dic[@"data"]) {

            [self.dataArry addObject: [TCOffLine ModelWithDictionary:dic[@"data"]]];
            self.noActityImage.hidden = YES; //没有活动的图片
            self.noActityLabel.hidden = YES; //没有活动的文字
            self.setActityBtn.hidden = YES; //创建活动的按钮
            self.haveActityLabel.hidden = NO; //有活动的文字
            self.gradientLayer.hidden = YES;
        }else{
           
            //创建没有活动的页面
            [self createNoActive];
        }
        [self.offLineTableView reloadData];
        [self.offLineTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        nil;
    }];
}
//没有活动的页面
-(void)createNoActive
{
    //没有活动的提示图
    self.noActityImage = [[UIImageView alloc] init];
    self.noActityImage.image = [UIImage imageNamed:@"暂无活动缺醒图"];
    self.noActityImage.frame = CGRectMake((WIDHT - 156)/2, 102, 156, 156);
    [self.view addSubview:self.noActityImage];
    //没有活动的提示文字
    self.noActityLabel = [[UILabel alloc] init];
    self.noActityLabel.frame = CGRectMake(0, self.noActityImage.frame.size.height + self.noActityImage.frame.origin.y + 13, WIDHT, 20);
    self.noActityLabel.text = @"您还没有创建的活动";
    self.noActityLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    self.noActityLabel.textColor = TCUIColorFromRGB(0xAEAEAE);
    self.noActityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.noActityLabel];
    
    //创建活动的按钮
    self.setActityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.setActityBtn.frame = CGRectMake(12, HEIGHT - 40 - 48 - 64, WIDHT - 24, 48);
    [self.setActityBtn addTarget:self action:@selector(setActity:) forControlEvents:(UIControlEventTouchUpInside)];

    self.setActityBtn.layer.shadowColor=[TCUIColorFromRGB(0x24A7F2) colorWithAlphaComponent:0.7].CGColor;
    self.setActityBtn.layer.shadowOffset=CGSizeMake(4, 4);
    self.setActityBtn.layer.shadowOpacity=0.5;
    self.setActityBtn.layer.shadowRadius= 5;
    [self.view addSubview:self.setActityBtn];
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x5FCAFF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, WIDHT - 24, 48);
    gradientLayer.cornerRadius = 48/2;
    [self.setActityBtn.layer addSublayer:gradientLayer];
    
    UILabel *btnLabel = [[UILabel alloc] init];
    btnLabel.frame = CGRectMake(0, 15, self.setActityBtn.frame.size.width, 18);
    btnLabel.text = @"创建活动";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [self.setActityBtn addSubview:btnLabel];
}
//创建有活动的页面
-(void)createTable
{
   //有活动的底部文字说明
    self.haveActityLabel = [[UILabel alloc] init];
    self.haveActityLabel.textColor = TCUIColorFromRGB(0x999999);
    self.haveActityLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    
    self.haveActityLabel.hidden = YES;
    self.haveActityLabel.textAlignment = NSTextAlignmentLeft;
    self.haveActityLabel.numberOfLines = 0;
    NSString *message = @"活动期限为7天，活动期间无法结束活动，如有疑问，请拨打客服热线：4000-111-228";
    self.haveActityLabel.text = message;
    CGSize stringSize = [message boundingRectWithSize:CGSizeMake(WIDHT - 80, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.haveActityLabel.font} context:nil].size;
    self.haveActityLabel.frame = CGRectMake(40, HEIGHT - 36 - 15 - 10, WIDHT - 80, stringSize.height);
    [self.view addSubview:self.haveActityLabel];
    
    //创建tableView
    self.offLineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDHT, HEIGHT - 30 - stringSize.height - 64) style:(UITableViewStyleGrouped)];
    self.offLineTableView.delegate = self;
    self.offLineTableView.dataSource = self;
    self.offLineTableView.tableFooterView = [[UIView alloc] init];
    self.offLineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.offLineTableView.backgroundColor = NEWMAINCOLOR;
    self.offLineTableView.scrollEnabled = NO;
    [self.view addSubview:self.offLineTableView];
    [self.offLineTableView registerClass:[TCOffLineTableViewCell class] forCellReuseIdentifier:@"cells"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCOffLineTableViewCell *cell = [self.offLineTableView dequeueReusableCellWithIdentifier:@"cells"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArry.count != 0) {
        [cell loadData: self.dataArry[indexPath.section]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCOffLine *model = self.dataArry[indexPath.section];
    return model.cellHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 16;
    }else{
        return 16 - 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
    [self.offLineTableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- 活动说明
-(void)actityExBtn:(UIButton *)sender
{
    TCActityExplainView *ActityExplain= [[TCActityExplainView alloc] init];
    [self.view addSubview:ActityExplain];
}
#pragma mark -- 创建活动的点击事件
-(void)setActity:(UIButton *)sender
{
    TCCreateOffActityViewController *offVC = [[TCCreateOffActityViewController alloc] init];
    offVC.isPush = NO;
    offVC.isChange = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:offVC animated:YES];
}

-(void)changeActity:(NSNotification *)userInfo
{
    TCCreateOffActityViewController *offVC = [[TCCreateOffActityViewController alloc] init];
    offVC.isChange = YES;
    offVC.isPush = NO;
    offVC.content = userInfo.userInfo[@"content"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:offVC animated:YES];
}
#pragma mark -- 返回按钮
-(void)backBtn{
    if(self.isPush == NO){
       [self.navigationController popViewControllerAnimated:YES];
    }else{
       [self dismissViewControllerAnimated:YES completion:nil];
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
