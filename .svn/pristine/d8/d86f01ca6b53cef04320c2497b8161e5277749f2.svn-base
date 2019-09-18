//
//  TCNewOrderViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/2.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNewOrderViewController.h"
#import "TCNewOrderTableViewCell.h"
#import "TCOrderDetailViewController.h"
#import "MJRefresh.h"
#import "TCDealOrderViewController.h"
#import "TCNOrderTableViewCell.h"
@interface TCNewOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) UIImageView *line2;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSMutableArray *dataMuArr;
@property (nonatomic, assign) BOOL isCanRefresh;
@end

@implementation TCNewOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_isCanRefresh) {
        [self setupRefresh:@"-1"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _userdefault = [NSUserDefaults standardUserDefaults];
    _dataMuArr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getnot:) name:@"chickViewAndRefreshOrder" object:nil];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, _line2.frame.origin.y + _line2.frame.size.height, WIDHT, HEIGHT - 48 - _line2.frame.size.height - _line2.frame.origin.y - 60 *HEIGHTSCALE - 64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];
    [_tableview registerClass:[TCNOrderTableViewCell class] forCellReuseIdentifier:@"cell"];

    _lb = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT / 2  - 20 - 64 - 60 * HEIGHTSCALE, WIDHT - 20, 40)];
    _lb.textColor = [UIColor colorWithRed:187 / 255.0 green:187 / 255.0 blue:187 / 255.0 alpha:1];
    _lb.font = [UIFont systemFontOfSize:18];
//    _lb.backgroundColor = [UIColor redColor];
    _lb.text = @"暂无订单!";
    _lb.hidden = YES;
    _lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _lb];

    //默认请求  按下单时间排序
    [self setupRefresh:@"-1"];
}

- (void)getnot:(NSNotification *)not{
    if ([not.userInfo[@"tag"] isEqualToString:@"0"]) {
        if (_isCanRefresh) {
            [self setupRefresh:@"-1"];
        }
    }
}


//添加刷新控件
- (void)setupRefresh:(NSString *)orderState{
    __block int  page = 1;
    self.tableview.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    _isCanRefresh = NO;
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
    self.tableview.mj_header = header;
    self.tableview.mj_footer = footer;
    [header beginRefreshing];
    
}

//下拉请求
- (void)request:(NSString *)statusx{
    self.tableview.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    _isCanRefresh = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"needGetFresh" object:nil];
    [_dataMuArr removeAllObjects];
    NSDictionary *dic = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"pageNum":@"1", @"x":statusx, @"status":@"6"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200005"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            _lb.hidden = YES;
            [_dataMuArr addObjectsFromArray:jsonDic[@"data"]];
        }else{
            _lb.hidden = NO;
        }
        [_tableview reloadData];
        [_tableview.mj_header endRefreshing];
        _tableview.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        _btn1.userInteractionEnabled = YES;
        _btn2.userInteractionEnabled = YES;
        if ([[NSString stringWithFormat:@"%@", jsonDic[@"retValue"]] isEqualToString:@"-104"]) {
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
        _isCanRefresh = YES;
    } failure:^(NSError *error) {
        _isCanRefresh = YES;
        nil;
    }];
    [_tableview.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestUp:(int)page andStatus:(NSString *)statusx{
    NSDictionary *dic = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"pageNum":@(page), @"x":statusx, @"status":@"1"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200005"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            NSLog(@"%@",jsonDic);
            [_dataMuArr addObjectsFromArray:jsonDic[@"data"]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [_tableview registerNib:[UINib nibWithNibName:@"TCNewOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

//    TCNewOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    [_tableview registerNib:[UINib nibWithNibName:@"TCNOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCNOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataMuArr.count != 0) {
        cell.Address.text = _dataMuArr[indexPath.section][@"address"][@"address"];
        cell.phoneBtn.tag = indexPath.section;
        [cell.phoneBtn addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
        [cell.phoneBtn setTitle:_dataMuArr[indexPath.section][@"address"][@"name"] forState:UIControlStateNormal];
        cell.perple = _dataMuArr[indexPath.section][@"address"][@"name"];
        cell.price.text = [NSString stringWithFormat:@"¥%@",_dataMuArr[indexPath.section][@"price"]];
        cell.deliverytime.text = [NSString stringWithFormat:@"预计送达:%@", _dataMuArr[indexPath.section][@"till"]];
        cell.deliverytime.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
        cell.orderTime.text = _dataMuArr[indexPath.section][@"createTime"];
        cell.orderTime.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
        NSString *type = _dataMuArr[indexPath.section][@"deliverType"];
        if([type isEqualToString:@"1"]){
          cell.type.text = @"速送订单";//快速送达
            cell.type.backgroundColor = TCUIColorFromRGB(0x0088CC);
        }else if ([type isEqualToString:@"2"]){
            cell.type.text = @"自取订单"; //自取
            cell.type.backgroundColor = TCUIColorFromRGB(0xCCCCCC);

        }else if ([type isEqualToString:@"3"]){
            cell.type.text = @"预定订单";//预定
            cell.type.backgroundColor = TCUIColorFromRGB(0x00CCCC);
        }else if ([type isEqualToString:@"4"]){
            cell.type.text = @"线下标签";//预定
            cell.type.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
        }
    }
    return  cell;
}

//打电话
- (void)contact:(UIButton *)sender{
    if (_dataMuArr.count != 0) {
        NSString *str = [NSString stringWithFormat:@"拨打电话  %@", _dataMuArr[sender.tag][@"address"][@"mobile"]];
        NSString *allString = [NSString stringWithFormat:@"tel:%@", _dataMuArr[sender.tag][@"address"][@"mobile"]];
        if ([_dataMuArr[sender.tag][@"address"][@"mobile"] isEqualToString:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无联系方式" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //拨打电话
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataMuArr.count != 0) {
        NSString *deliverTypeStr = [NSString stringWithFormat:@"%@", _dataMuArr[indexPath.section][@"deliverType"]];
        if([deliverTypeStr isEqualToString:@"4"]){
            TCDealOrderViewController *dealVC = [[TCDealOrderViewController alloc] init];
            dealVC.oidStr = _dataMuArr[indexPath.section][@"id"];
            [self presentViewController:dealVC animated:YES completion:nil];
        }else{
            TCOrderDetailViewController *detail = [[TCOrderDetailViewController alloc]init];
            detail.oid = _dataMuArr[indexPath.section][@"id"];
            detail.type = deliverTypeStr;
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}



@end
