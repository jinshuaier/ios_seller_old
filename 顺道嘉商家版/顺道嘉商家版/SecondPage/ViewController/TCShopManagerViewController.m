//
//  TCShopManagerViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopManagerViewController.h"
#import "TCCreateShopsViewController.h"
#import "TCshopManagerTableViewCell.h"
#import "TCTabBarViewController.h"

@interface TCShopManagerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSMutableArray *mesMuArr;//保存请求店铺信息
@property (nonatomic, assign) NSInteger cellheight;
@end

@implementation TCShopManagerViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.zhuce){
        
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = Color;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         
         @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
           
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        //左边导航栏的按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12*WIDHTSCALE, 20*HEIGHTSCALE)];
        // Add your action to your button
        [leftButton addTarget:self action:@selector(barButtonItemsao:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
        UIBarButtonItem *barleftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = barleftBtn;
        
         //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request) name:@"shuaxin" object:nil];
        
        
    } else {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request) name:@"shuaxin" object:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"店铺管理";
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 *WIDHTSCALE, 28)];
    
    // Add your action to your button
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"添加店铺" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    _userdefault = [NSUserDefaults standardUserDefaults];
    
    [self request];

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];
}

//请求
- (void)request{
    [[SDImageCache sharedImageCache] clearDisk];
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200001"] paramter:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            _mesMuArr = [NSMutableArray array];
            [_mesMuArr addObjectsFromArray:jsonDic[@"data"]];
        }
        [_tableview reloadData];
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
    TCshopManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_mesMuArr.count != 0) {
        NSString *str = [_mesMuArr[indexPath.section][@"address"][@"locaddress"] stringByAppendingString:_mesMuArr[indexPath.section][@"address"][@"address"]];
        cell = [[TCshopManagerTableViewCell alloc]initTableviewCell:@"店铺编号001" andHeadim:_mesMuArr[indexPath.section][@"headPic"] andShopname:_mesMuArr[indexPath.section][@"name"] andAddress:str andisyingy: [NSString stringWithFormat:@"%@", _mesMuArr[indexPath.section][@"status"]] andcontat:_mesMuArr[indexPath.section][@"tel"] andstyle:_mesMuArr[indexPath.section][@"type"] andps:_mesMuArr[indexPath.section][@"distributionPrice"] andqisong:_mesMuArr[indexPath.section][@"startPrice"] andisto: [NSString stringWithFormat:@"%@", _mesMuArr[indexPath.section][@"defaultGoods"]]anddianz:_mesMuArr[indexPath.section][@"shopkeeper"] andphone:@"" anddianyuan:_mesMuArr[indexPath.section][@"employees"] andbounStatus: [NSString stringWithFormat:@"%@", _mesMuArr[indexPath.section][@"bounStatus"]]];
        _cellheight = cell.height;
        cell.bianhao.text = [NSString stringWithFormat:@"店铺编号00%ld", indexPath.section + 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.btn.tag = indexPath.section;
        [cell.btn addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

//编辑店铺
- (void)bianji:(UIButton *)sender{
    if ([[NSString stringWithFormat:@"%@", _mesMuArr[sender.tag][@"status"]] isEqualToString:@"-3"]) {
        [SVProgressHUD showErrorWithStatus:@"审核中无法修改店铺信息"];
    }else{
        TCCreateShopsViewController *c = [[TCCreateShopsViewController alloc]init];
        c.isChange = YES;
        c.shopid = _mesMuArr[sender.tag][@"id"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c animated:YES];
    }
}


#pragma mark -- 左边返回按钮
- (void)barButtonItemsao:(UIButton *)sender
{
    self.view = nil;
    TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
    tab.selectedIndex = 1;
    [self presentViewController:tab animated:YES completion:nil];
    
    //self.tabBarController.selectedIndex = 1;
}

//右侧按钮
- (void)barButtonItemPressed:(UIButton *)sender{
    TCCreateShopsViewController *c = [[TCCreateShopsViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c animated:YES];
}

@end
