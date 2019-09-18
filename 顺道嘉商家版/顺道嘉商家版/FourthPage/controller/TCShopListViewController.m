//
//  TCShopListViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/3/2.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopListViewController.h"
#import "TCShopListTableViewCell.h"
#import "TCHtmlViewController.h"
#import "TCLookDepositViewController.h"
#import "TCChongZhiBZJViewController.h"

@interface TCShopListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSMutableArray *mesMuArr;
@property (nonatomic, assign) CGFloat cellheight;
@end

@implementation TCShopListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"保证金";
    _userdefault = [NSUserDefaults standardUserDefaults];
    //充值成功或者提现成功后  要求刷新列表页面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request) name:@"ToppedUpSuccessNeedRefresh" object:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStyleDone target:self action:@selector(explain)];
    self.navigationItem.rightBarButtonItem = right;
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview: _tableview];
    
    [self request];
}

//请求
- (void)request{
    _tableview.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"获取中..."];
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200001"] paramter:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            _mesMuArr = [NSMutableArray array];
            [_mesMuArr addObjectsFromArray:jsonDic[@"data"]];
        }
        [SVProgressHUD dismiss];
        [_tableview reloadData];
        _tableview.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        nil;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mesMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCShopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_mesMuArr.count != 0) {
        NSString *str = [_mesMuArr[indexPath.section][@"address"][@"locaddress"] stringByAppendingString:_mesMuArr[indexPath.section][@"address"][@"address"]];
        cell = [[TCShopListTableViewCell alloc]initTableviewCell:@"店铺编号001" andHeadim:_mesMuArr[indexPath.section][@"headPic"] andShopname:_mesMuArr[indexPath.section][@"name"] andAddress:str anddianz:_mesMuArr[indexPath.section][@"shopkeeper"] andbounStatus:[NSString stringWithFormat:@"%@", _mesMuArr[indexPath.section][@"bounStatus"]] andRcode:_mesMuArr[indexPath.section][@"memberCode"]andmesinfo:_mesMuArr[indexPath.section]];
        _cellheight = cell.height;
        cell.bianhao.text = [NSString stringWithFormat:@"00%ld", indexPath.section + 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.baozhengjinBtn.tag = indexPath.section;
        [cell.baozhengjinBtn addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)bianji:(UIButton *)sender{
    if ([_mesMuArr[sender.tag][@"bounStatus"] intValue] == 0 || [_mesMuArr[sender.tag][@"bounStatus"] intValue] == 2) {
        TCChongZhiBZJViewController *chognzhi = [[TCChongZhiBZJViewController alloc]init];
        chognzhi.shopid = _mesMuArr[sender.tag][@"id"];
        chognzhi.isChongzhi = YES;
        [self.navigationController pushViewController: chognzhi animated:YES];
    }else{
        //查看保证金
        TCLookDepositViewController *lookDepositVC = [[TCLookDepositViewController alloc] init];
        lookDepositVC.shopID = _mesMuArr[sender.tag][@"id"];
        lookDepositVC.status = [NSString stringWithFormat:@"%@", _mesMuArr[sender.tag][@"bounStatus"]];
        [self.navigationController pushViewController:lookDepositVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 6;
}

- (void)explain{
    TCHtmlViewController *html = [[TCHtmlViewController alloc]init];
    html.html = @"https://sellerapi.moumou001.com/h5/bond-view";
    html.title = @"保证金说明";
    [self.navigationController pushViewController:html animated:YES];
}

@end
