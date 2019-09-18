//
//  TCDisViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/2.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCDisViewController.h"
#import "TCUnfinishedOrderTableViewCell.h"
#import "TCOrderDetailViewController.h"
#import "MJRefresh.h"
#import "TCNewOrderTableViewCell.h"
#import "TCDealOrderViewController.h"
@interface TCDisViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backView;
}
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UITableView *distributionTableView;
@property (nonatomic, strong) NSMutableArray *dataMuArr;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, assign) BOOL isCanrefresh;
@end

@implementation TCDisViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(needRefresh) name:@"needRefresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getnot:) name:@"chickViewAndRefreshOrder" object:nil];
    if (_isCanrefresh) {
        [self setupRefresh];
    }
}

- (void)getnot:(NSNotification *)not{
    if ([not.userInfo[@"tag"] isEqualToString:@"2"]) {
        if (_isCanrefresh) {
            [self setupRefresh];
        }
    }
}

- (void)needRefresh{
    if (_isCanrefresh) {
        //默认请求  按下单时间排序
        [self setupRefresh];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _userdefault = [NSUserDefaults standardUserDefaults];
    _dataMuArr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = YES;

    //创建 配送中tableView
    [self createDistributionTable];

    _lb = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT / 2  - 20 - 64 - 60 * HEIGHTSCALE, WIDHT, 40)];
    _lb.textColor = [UIColor colorWithRed:187 / 255.0 green:187 / 255.0 blue:187 / 255.0 alpha:1];
    _lb.font = [UIFont systemFontOfSize:18];
    _lb.text = @"暂无配送中订单!";
    _lb.hidden = YES;
    _lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _lb];

    [self setupRefresh];

}

//添加刷新控件
- (void)setupRefresh{
    __block int  page = 1;
    self.distributionTableView.userInteractionEnabled = NO;
    //下拉
    _isCanrefresh = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"needGetFresh" object:nil];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self request];
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
        [self requestUp:page];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉订单" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉订单..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉订单!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];

    //加入tableview中
    self.distributionTableView.mj_header = header;
    self.distributionTableView.mj_footer = footer;
    [header beginRefreshing];

}

//下拉请求
- (void)request{
    _isCanrefresh = NO;
    [_dataMuArr removeAllObjects];
    NSDictionary *dic = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"pageNum":@"1", @"status":@"7", @"m":@"0"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200005"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            _lb.hidden = YES;
            [_dataMuArr addObjectsFromArray:jsonDic[@"data"]];
        }else{
            _lb.hidden = NO;
        }
        [_distributionTableView reloadData];
        [_distributionTableView.mj_header endRefreshing];
        _distributionTableView.userInteractionEnabled = YES;
        if ([[NSString stringWithFormat:@"%@", jsonDic[@"retValue"]] isEqualToString:@"-104"]) {
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
        _isCanrefresh = YES;
    } failure:^(NSError *error) {
        nil;
    }];
    [_distributionTableView.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestUp:(int)page{
    NSDictionary *dic = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"pageNum":@(page), @"status":@"3", @"m":@"0"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200005"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            [_dataMuArr addObjectsFromArray:jsonDic[@"data"]];
            [_distributionTableView reloadData];
            [_distributionTableView.mj_footer endRefreshing];
        }else{
            [_distributionTableView.mj_footer endRefreshing];
            [_distributionTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark -- 创建配送中的tableView
-(void)createDistributionTable{
    _distributionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 48  - 60 *HEIGHTSCALE - 64) style:UITableViewStyleGrouped];
    _distributionTableView.delegate = self;
    _distributionTableView.dataSource = self;
    [self.view addSubview: _distributionTableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_distributionTableView registerNib:[UINib nibWithNibName:@"TCUnfinishedOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCUnfinishedOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [_distributionTableView registerNib:[UINib nibWithNibName:@"TCNewOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells"];
    TCNewOrderTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (_dataMuArr.count != 0) {
        NSString *type = _dataMuArr[indexPath.section][@"deliverType"];
        if([type isEqualToString:@"1"]){
            cell.typeImage.image = [UIImage imageNamed:@"susong"];//快速送达
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.barcodeBtn.tag = indexPath.section;
            cell.contactBtn.tag = indexPath.section;
            [cell.barcodeBtn addTarget:self action:@selector(barcodeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.address.text = _dataMuArr[indexPath.section][@"address"][@"address"];
            [cell.contactBtn addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contactBtn setTitle:_dataMuArr[indexPath.section][@"address"][@"name"] forState:UIControlStateNormal];
            cell.price.text = [NSString stringWithFormat:@"¥%@", _dataMuArr[indexPath.section][@"price"]];
            cell.till.text = [NSString stringWithFormat:@"预计送达:%@", _dataMuArr[indexPath.section][@"till"]];
            cell.till.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
            cell.creattime.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
            cell.creattime.text = _dataMuArr[indexPath.section][@"createTime"];
            if ([_dataMuArr[indexPath.section][@"status"] isEqualToString:@"3"]) {
                //配送中
                [cell.barcodeBtn setTitle:@"配送中" forState:UIControlStateNormal];
                [cell.barcodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                cell.barcodeBtn.userInteractionEnabled = NO;
            }else{
                [cell.barcodeBtn setTitle:@"二维码" forState:UIControlStateNormal];
                [cell.barcodeBtn setTitleColor:btnColors forState:UIControlStateNormal];
                cell.barcodeBtn.userInteractionEnabled = YES;
            }
            return  cell;
        }else if ([type isEqualToString:@"2"]){
            cells.imageType.image = [UIImage imageNamed:@"ziqu"]; //自取
            cells.selectionStyle = UITableViewCellSelectionStyleNone;
            cells.contactBtn.tag = indexPath.section;
            cells.address.text = _dataMuArr[indexPath.section][@"address"][@"address"];
            [cells.contactBtn addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
            [cells.contactBtn setTitle:_dataMuArr[indexPath.section][@"address"][@"name"] forState:UIControlStateNormal];
            cells.price.text = [NSString stringWithFormat:@"¥%@", _dataMuArr[indexPath.section][@"price"]];
            cells.till.text = [NSString stringWithFormat:@"预计送达:%@", _dataMuArr[indexPath.section][@"till"]];
            cells.till.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
            cells.createTime.font = [UIFont systemFontOfSize:11 * HEIGHTSCALE];
            cells.createTime.text = _dataMuArr[indexPath.section][@"createTime"];
            return  cells;
        }else{
            return cell;
        }
    }else{
        return cell;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

//二维码事件
- (void)barcodeBtn:(UIButton *)sender{
    if(backView){
        [backView removeFromSuperview];
    }
    //创建背景颜色
    backView = [[UIView alloc]init];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    backView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);

    UIImageView * barcodeImage= [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - (WIDHT - 40 * WIDHTSCALE) / 2, WIDHT - 40 * WIDHTSCALE, WIDHT - 40 * WIDHTSCALE)];
    if (_dataMuArr.count != 0) {
        [barcodeImage sd_setImageWithURL:[NSURL URLWithString:_dataMuArr[sender.tag][@"qrcode"]] placeholderImage:[UIImage imageNamed:@"shundaojia.png"]];
    }
    barcodeImage.userInteractionEnabled = YES;

    //添加一个手势
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    [backView addGestureRecognizer:tapgesture];
    [backView addSubview:barcodeImage];
    [[UIApplication sharedApplication].keyWindow addSubview: backView];


}

#pragma mark -- 手势的处理时间
-(void)tapgesture
{
    [backView removeFromSuperview];
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

@end



