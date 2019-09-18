//
//  TCCMxViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCMxViewController.h"
#import "TCBillTableViewCell.h"

@interface TCCMxViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@end

@implementation TCCMxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    _arr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];

    [self setupRefresh];
}

//添加刷新控件
- (void)setupRefresh{

    __block int  page = 1;
    self.view.userInteractionEnabled = NO;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self request];

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
    //上拉加载
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self requestUp:page];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];

    //加入tableview中
    _tableview.mj_header = header;
    _tableview.mj_footer = footer;
    [header beginRefreshing];

}

//下拉请求
- (void)request{
    [_arr removeAllObjects];
    NSDictionary *dic = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"pageNum":@"1", @"list":@"1", @"type":@"3", @"numPerPage":@"20"};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"700001"] parameters:dic success:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" 下拉%@", str);
        if (dic[@"data"]) {
            [_arr addObjectsFromArray:dic[@"data"][@"orderList"]];
        }
        [_tableview reloadData];
        [_tableview.mj_header endRefreshing];
        self.view.userInteractionEnabled = YES;

    } failure:^(NSError *error) {
        nil;
    }];
    [_tableview.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestUp:(int)page{
    NSDictionary *dic = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"pageNum":@(page), @"list":@"1", @"type":@"3", @"numPerPage":@"20"};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"700001"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"]) {
            [_arr addObjectsFromArray:dic[@"data"][@"orderList"]];
            [_tableview reloadData];
            [_tableview.mj_footer endRefreshing];
        }else{
            [_tableview.mj_footer endRefreshing];
            [_tableview.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_arr.count != 0) {
        cell.titleLabel.text = @"充值";
        cell.timeLabel.text = _arr[indexPath.section][@"createTime"];
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", _arr[indexPath.section][@"money"]];
        cell.stateLabel.text = _arr[indexPath.section][@"status__name"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
@end
