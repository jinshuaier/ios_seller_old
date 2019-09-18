//
//  TCTXjluViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTXjluViewController.h"
#import "TCtixianlikTableViewCell.h"

@interface TCTXjluViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *messageArr;
@end

@implementation TCTXjluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewColor;
    self.title = @"提现记录";
    _messageArr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview: _tableview];
    [self setupRefresh];
}

//添加刷新控件
- (void)setupRefresh{
    __block int  page = 1;
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
        [self requestS:page];
        NSLog(@"page  %d", page);
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];

    //加入tableview中
    self.tableview.mj_header = header;
    self.tableview.mj_footer = footer;
    [header beginRefreshing];

}

//下拉刷新
- (void)request{
    [_messageArr removeAllObjects];
    NSDictionary *paramter = @{@"id":[self.userdefaults valueForKey:@"userID"], @"token":[self.userdefaults valueForKey:@"userToken"], @"list":@"1", @"type":@"2", @"numPerPage":@"20"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"700001"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"账单%@", str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"data"][@"orderList"];
        if (arr.count != 0) {
            [_messageArr addObjectsFromArray:dic[@"data"][@"orderList"]];
        }else{
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64)];
            lb.text = @"暂无数据!";
            lb.textAlignment = NSTextAlignmentCenter;
            lb.textColor = [UIColor lightGrayColor];
            [self.view addSubview:lb];
        }
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    [self.tableview.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestS:(int) page{
    NSDictionary *paramter = @{@"id":[self.userdefaults valueForKey:@"userID"], @"token":[self.userdefaults valueForKey:@"userToken"], @"list":@"1", @"type":@"2", @"numPerPage":@"20", @"pageNum":@(page)};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"700001"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                NSLog(@"str  %@", str);
        NSArray *arr = dic[@"data"][@"orderList"];
        if (arr.count == 0) {
            [self.tableview.mj_footer endRefreshing];
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_messageArr addObjectsFromArray:dic[@"data"][@"orderList"]];
            [self.tableview reloadData];
            [self.tableview.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCtixianlikTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCtixianlikTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_messageArr.count != 0) {
        cell.tixian.text = [NSString stringWithFormat:@"提现:¥%@", _messageArr[indexPath.row][@"money"]];
        cell.time.text = _messageArr[indexPath.row][@"createTime"];
        cell.status.text = _messageArr[indexPath.row][@"status__name"];
        if ([_messageArr[indexPath.row][@"status"] isEqualToString:@"1"]) {
            cell.status.textColor = Color;
        }else if ([_messageArr[indexPath.row][@"status"] isEqualToString:@"-1"]){
            cell.status.textColor = [UIColor redColor];
        }else{
            cell.status.textColor = [UIColor orangeColor];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}






@end
