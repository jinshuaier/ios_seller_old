//
//  TCOrderEvaluateViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderEvaluateViewController.h"
#import "TCChooseSlideView.h"
#import "TCOrderEvaTableViewCell.h"
#import "TCOrderEvlModel.h"
#import "TCOrderEvaDisViewController.h"
@interface TCOrderEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,TCChooseSlideProtocol>
@property (nonatomic, strong) TCChooseSlideView *sliderView;
@property (nonatomic, strong) UITableView *maintableView;
@property (nonatomic, strong) NSMutableArray *dataArr; //数据源
@property (nonatomic, strong) UILabel *evaLabel;
@property (nonatomic, assign) BOOL isCanRefresh;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSDictionary *messDic;
@property (nonatomic, strong) NSArray *titlemesArr;
@end

@implementation TCOrderEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TCBgColor;
    self.title = @"评价管理";
    self.dataArr = [NSMutableArray array];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    
    //进来请求接口
    [self createQuest];
    
    // Do any additional setup after loading the view.
}

//接口
- (void)createQuest
{
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"page":@"1",@"typeKey":@"1",@"shopId":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"page":@"1",@"typeKey":@"1",@"shopId":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202004"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        if (jsonDic[@"data"]) {
            self.messDic = jsonDic[@"data"];
        }
        [self createUI];
  } failure:^(NSError *error) {
        nil;
    }];
}

//创建view
- (void)createUI
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = TCNavColor;
    headView.frame = CGRectMake(0, 0, WIDHT, 79);
    [self.view addSubview:headView];
    
    NSArray *titleArr;
    if (self.messDic == nil){
        titleArr = @[@"0",@"0",@"0"];
    } else {
        NSString *str1 = [NSString stringWithFormat:@"%@",self.messDic[@"commentNum"][@"fine"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.messDic[@"commentNum"][@"centre"]];
        NSString *str3 = [NSString stringWithFormat:@"%@",self.messDic[@"commentNum"][@"negative"]];
        
        titleArr = @[str1,str2,str3];
    }

    for (int i = 0; i < titleArr.count; i++ ) {
        self.evaLabel = [UILabel publicLab:titleArr[i] textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:20 numberOfLines:0];
        self.evaLabel.frame = CGRectMake(WIDHT/3 * i, 15, WIDHT/3, 20);
        [headView addSubview:self.evaLabel];
    }

    self.sliderView = [[TCChooseSlideView alloc]init];
    self.sliderView.frame = CGRectMake(0, CGRectGetMaxY(self.evaLabel.frame), WIDHT, 44);
    self.sliderView.backgroundColor = [UIColor clearColor];
    [headView addSubview:self.sliderView];
    self.sliderView.sliderDelegate = self;
    NSArray *menuArray = [NSArray arrayWithObjects:@"好评",@"中评", @"差评",nil];
    [self.sliderView  setNameWithArray:menuArray];
    [self _getTag:0];
    
    //创建tableView
    self.maintableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sliderView.frame), WIDHT, HEIGHT - 79 - 64) style:(UITableViewStyleGrouped)];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    self.maintableView.showsVerticalScrollIndicator = NO;
    self.maintableView.backgroundColor = TCBgColor;
    self.maintableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.maintableView];
    
    //默认请求
    [self setupRefresh:@"1"];
}

//添加刷新控件
- (void)setupRefresh:(NSString *)orderState{
    __block int  page = 1;
    self.maintableView.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self request:orderState];
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
        [self requestUp:page andStatus:orderState];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉订单" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉订单..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉订单!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    self.maintableView.mj_header = header;
    self.maintableView.mj_footer = footer;
    [header beginRefreshing];
}

//下拉请求
- (void)request:(NSString *)statusx{
    self.maintableView.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    _isCanRefresh = NO;
    [self.dataArr removeAllObjects];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"page":@"1",@"typeKey":statusx,@"shopId":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"page":@"1",@"typeKey":statusx,@"shopId":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202004"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        if (jsonDic[@"data"]) {
            NSArray *arr = jsonDic[@"data"][@"commentList"];
            for (NSDictionary *dic in arr) {
                TCOrderEvlModel *model = [TCOrderEvlModel orderEvlInfoWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            self.messDic = jsonDic[@"data"];
        } else {
            
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        [_maintableView reloadData];
        [_maintableView.mj_header endRefreshing];
        _maintableView.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        
        _isCanRefresh = YES;
    } failure:^(NSError *error) {
        _isCanRefresh = YES;
        nil;
    }];
    [_maintableView.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestUp:(int)page andStatus:(NSString *)statusx{
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];

    NSDictionary *dic = @{@"page":pageStr,@"typeKey":statusx,@"shopId":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"page":pageStr,@"typeKey":statusx,@"shopId":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202004"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            NSLog(@"%@",jsonDic);
            
            NSArray *arr = jsonDic[@"data"][@"commentList"];
            for (NSDictionary *dic in arr) {
                TCOrderEvlModel *model = [TCOrderEvlModel orderEvlInfoWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            [_maintableView reloadData];
            [_maintableView.mj_footer endRefreshing];
        }else{
            [_maintableView.mj_footer endRefreshing];
            [_maintableView.mj_footer endRefreshingWithNoMoreData];
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 54)];
        headerView.backgroundColor = TCBgColor;
        
        NSArray *titleArr = @[@"用户名",@"评价时间",@"综合评分"];
        UIView *titleView = [[UIView alloc] init];
        titleView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        titleView.frame = CGRectMake(0, 10, WIDHT, 44);
        [headerView addSubview:titleView];
        
        for (int i = 0 ; i < titleArr.count; i ++) {
            //创建title
            UILabel *titleLabel = [UILabel publicLab:titleArr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            titleLabel.frame = CGRectMake(WIDHT/3 * i, 0, WIDHT/3, 44);
            [titleView addSubview:titleLabel];
            
            //线
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = TCLineColor;
            lineView.frame = CGRectMake(0, 54, WIDHT, 1);
            [headerView addSubview:lineView];
        }
        
        return headerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 54;
    }else{
        return 0.1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCOrderEvaTableViewCell *cell = [[TCOrderEvaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (self.dataArr.count == 0){
        NSLog(@"无");
    } else {
        TCOrderEvlModel *model = self.dataArr[indexPath.row];
        cell.model = model;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCOrderEvlModel *model = self.dataArr[indexPath.row];
    
    TCOrderEvaDisViewController *evaDisVC = [[TCOrderEvaDisViewController alloc] init];
    evaDisVC.idStr = model.idStr;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:evaDisVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -- 实现
//实现协议方法;
-(void)_getTag:(NSInteger)tag
{
    if (tag == 0){
       [self setupRefresh:@"1"];
        
    }else if (tag == 1){
        [self setupRefresh:@"2"];

    } else {
        [self setupRefresh:@"3"];

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
