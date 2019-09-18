//
//  TCMessageNewsViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMessageNewsViewController.h"
#import "TCMessageNewTableViewCell.h"
#import "UITableView+HD_NoList.h"
#import "TCMessNewModel.h"
#import "TCHtmlViewController.h"
#import "TCOrderDetailViewController.h"
#import "TCMessageDetileViewController.h"

@interface TCMessageNewsViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *listTableView;
    UIButton *lastButton;
    UIView *lineView;
    
    NSString *typeStr;
    NSMutableArray *dataArr;
    NSUserDefaults *userDefaults;
}


@end

@implementation TCMessageNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    dataArr = [NSMutableArray array];
    userDefaults = [NSUserDefaults standardUserDefaults];
    self.title = @"消息";
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80*WIDHTSCALE, 17)];
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"全部已读" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    //创建UI
    [self createUI];
    
    // Do any additional setup after loading the view.
}


//添加刷新控件
- (void)setupRefresh:(NSString *)State{
    __block int  page = 1;
    listTableView.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    //    _isCanRefresh = NO;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self request:State];
    }];
    //设置刷新标题
    [header setTitle:@"下拉刷新顺道嘉消息..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新顺道嘉消息..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新顺道嘉消息..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.backgroundColor = ViewColor;
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    //上拉加载
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self requestUp:page andStatus:State];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉消息" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉消息..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉消息!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    listTableView.mj_header = header;
    listTableView.mj_footer = footer;
    [header beginRefreshing];
}

//下拉请求
- (void)request:(NSString *)statusx{
    [listTableView dismissNoView];
    [dataArr removeAllObjects];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userToken"]];
   
    
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx};
    NSString *singStr = [TCServerSecret loginStr:dicc];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx,@"sign":singStr};
        
   
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202009"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        if (jsonDic[@"data"]){
            NSArray *arr = jsonDic[@"data"];
            
            for (NSDictionary *dic in arr){
                TCMessNewModel *model = [TCMessNewModel messInfoWithDictionary:dic];
                [dataArr addObject:model];
            }
        }
        //占位图
        [self NeedResetNoView];
        [listTableView reloadData];
        [listTableView.mj_header endRefreshing];
        listTableView.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        
        if ([[NSString stringWithFormat:@"%@", jsonDic[@"retValue"]] isEqualToString:@"-104"]) {
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
    [listTableView.mj_footer resetNoMoreData];
}
//占位图
- (void)NeedResetNoView{
    if (dataArr.count >0) {
        [listTableView dismissNoView];
    }else{
        [listTableView showNoView:@"暂无消息" image: [UIImage imageNamed:@"无评价，无消息缺省插图"] certer:CGPointZero];
    }
}
//上拉加载
- (void)requestUp:(int)page andStatus:(NSString *)statusx{
    [listTableView dismissNoView];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userToken"]];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":pageStr,@"typeKey":statusx};
    NSString *singStr = [TCServerSecret loginStr:dicc];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":pageStr,@"typeKey":statusx,@"sign":singStr};

    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202009"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]){
           
            NSArray *arr = jsonDic[@"data"];
            
            for (NSDictionary *dic in arr){
                TCMessNewModel *model = [TCMessNewModel messInfoWithDictionary:dic];
                [dataArr addObject:model];
            }
            
            [listTableView reloadData];
            [listTableView.mj_footer endRefreshing];
        }else{
            [listTableView.mj_footer endRefreshing];
            [listTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}



#pragma mark -- 创建UI
- (void)createUI
{
    NSArray *titleArray = @[@"全部", @"订单消息", @"账单消息",@"活动消息",@"系统消息"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 43)];
    headerView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WIDHT / titleArray.count * i, 0, WIDHT / titleArray.count, 43);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [btn setTitleColor:TCUIColorFromRGB(0X666666) forState:UIControlStateNormal];
        [btn setTitleColor:TCUIColorFromRGB(0x333333) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [headerView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            lastButton = btn;
        }
    }
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake((WIDHT/5 - 20)/2, 43 - 4, 20, 4)];
    lineView.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    lineView.tag = 2000;
    [headerView addSubview:lineView];
    
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), WIDHT, HEIGHT - 64 - CGRectGetMaxY(headerView.frame)) style:UITableViewStyleGrouped];
    listTableView.dataSource = self;
    listTableView.delegate = self;
    listTableView.showsVerticalScrollIndicator = NO;
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTableView];
    [self.view addSubview:headerView];
    
    //默认
    [self setupRefresh:@"1"];
}


- (void)typeSelect:(UIButton *)button {
    lastButton.selected = NO;
    button.selected = YES;
    lastButton = button;
    
    CGRect frame = lineView.frame;
    switch (button.tag) {
        case 1000: {
            frame.origin.x = (WIDHT/5 - 20)/2;
            [self setupRefresh:@"1"];
        }
            break;
        case 1001: {
            frame.origin.x = (WIDHT/5 - 20)/2 + WIDHT/5;
            [self setupRefresh:@"2"];
        }
            break;
        case 1002: {
            frame.origin.x = (WIDHT/5 - 20)/2 + WIDHT/5*2;
           [self setupRefresh:@"3"];
        }
            break;
        case 1003: {
            frame.origin.x = (WIDHT/5 - 20)/2 + WIDHT/5*3;
            [self setupRefresh:@"4"];
        }
            break;
        case 1004: {
            frame.origin.x = (WIDHT/5 - 20)/2 + WIDHT/5*4;
            [self setupRefresh:@"5"];
        }
          break;
        default:
            break;
    }
    
    [listTableView reloadData];
    lineView.frame = frame;
}

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCMessageNewTableViewCell *cell = [[TCMessageNewTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataArr.count == 0){
        
    } else {
        TCMessNewModel *model = dataArr[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TCMessNewModel *model = dataArr[indexPath.row];
    if ([model.type isEqualToString:@"4"]) {
        NSString *shopID = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"shopID"]];
        TCOrderDetailViewController *orderVC = [[TCOrderDetailViewController alloc]init];
        orderVC.shopId = shopID;
        NSString *orderid = [NSString stringWithFormat:@"%@",model.orderid];
        orderVC.oid = orderid;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else{
        TCMessageDetileViewController *messageDVC = [[TCMessageDetileViewController alloc]init];
        messageDVC.titleStr = [NSString stringWithFormat:@"%@",model.title];
        messageDVC.content = [NSString stringWithFormat:@"%@",model.content];
        messageDVC.timeStr = [NSString stringWithFormat:@"%@",model.createTime];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageDVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    //请求已读的接口
    [self messQuest:model.messageid];
}

//标记已读
- (void)messQuest:(NSString *)messageid
{
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"userToken"]];
    NSDictionary *dicc;
    NSDictionary *parameters;
    
    if ([messageid isEqualToString:@"all"]) {
        dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"all":messageid};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"all":messageid,@"sign":singStr};
    } else {
        dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"messageid":messageid};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"messageid":messageid,@"sign":singStr};
    }
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202010"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        [listTableView reloadData];
        [self setupRefresh:@"1"];
        
    } failure:^(NSError *error) {
        nil;
    }];
}


#pragma mark -- barButtonItemPressed
- (void)barButtonItemPressed:(UIButton *)sender
{
    NSLog(@"全部已读");
    [self messQuest:@"all"];
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
