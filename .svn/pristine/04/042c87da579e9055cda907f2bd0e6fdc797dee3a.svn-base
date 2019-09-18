//
//  TCMesZdViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMesZdViewController.h"
#import "TCZangdTableViewCell.h"

@interface TCMesZdViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *messageArr;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) NSMutableArray *whiteArr;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation TCMesZdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    _messageArr = [NSMutableArray array];
    _cellArr = [NSMutableArray array];
    _whiteArr = [NSMutableArray array];
    self.title = @"账单消息";

    //右边导航栏的按钮
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70 * WIDHTSCALE, 16*HEIGHTSCALE)];
    // Add your action to your button
    [self.rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitle:@"全部已读" forState:(UIControlStateNormal)];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16*HEIGHTSCALE];
    //[rightButton setTitleColor:shopColor forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [self.view addSubview:_tableview];

    //请求
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
    NSDictionary *paramter = @{@"id":[self.userdefaults valueForKey:@"userID"], @"token":[self.userdefaults valueForKey:@"userToken"], @"pageNum":@"1"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"600005"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"账单%@", str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"data"][@"list"];
        if (arr.count != 0) {
            [_messageArr addObjectsFromArray:dic[@"data"][@"list"]];
        }else{
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64)];
            lb.text = @"暂无数据!";
            lb.textAlignment = NSTextAlignmentCenter;
            lb.textColor = [UIColor lightGrayColor];
            [self.view addSubview:lb];
        }
        self.rightButton.userInteractionEnabled = YES;
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
        self.rightButton.userInteractionEnabled = YES;
    }];
    [self.tableview.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestS:(int) page{
    NSDictionary *paramter = @{@"id":[self.userdefaults valueForKey:@"userID"],@"token":[self.userdefaults valueForKey:@"userToken"], @"pageNum":@(page)};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"600005"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"str  %@", str);
        NSArray *arr = dic[@"data"][@"list"];
        if (arr.count == 0) {
            [self.tableview.mj_footer endRefreshing];
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_messageArr addObjectsFromArray:dic[@"data"][@"list"]];
            [self.tableview reloadData];
            [self.tableview.mj_footer endRefreshing];
        }
        self.rightButton.userInteractionEnabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
        self.rightButton.userInteractionEnabled = YES;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"mid":_messageArr[indexPath.section][@"id"], @"type":@"3"};
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"600010"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"修改单条消息为已读 %@", str);
        if (![_cellArr containsObject: _messageArr[indexPath.section][@"content"]]) {
            [_cellArr addObject: _messageArr[indexPath.section][@"content"]];

        }
        [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCZangdTableViewCell" bundle:nil]
     forCellReuseIdentifier:@"cellorder"];
    TCZangdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellorder"];
    if (_messageArr.count != 0) {
        cell.date.text = _messageArr[indexPath.section][@"createTime"];
        cell.title.text = _messageArr[indexPath.section][@"title"];
        cell.content.text = _messageArr[indexPath.section][@"content"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([_messageArr[indexPath.section][@"status"] isEqualToString:@"0"]) {
            if ([_cellArr containsObject: _messageArr[indexPath.section][@"content"]]) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            }
        }else{
            //如果是已读 加入数组
            [_cellArr addObject: _messageArr[indexPath.section][@"content"]];
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cellArr containsObject: _messageArr[indexPath.section][@"content"]]) {
        return 150;
    }else{
        return 78;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)barButtonItemPressed:(UIButton *)sender{
    self.rightButton.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"全部已读中..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"600009"] parameters:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"menu":@"3"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"retValue"] intValue] == 2) {
            [SVProgressHUD dismiss];
            [self setupRefresh];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}


@end
