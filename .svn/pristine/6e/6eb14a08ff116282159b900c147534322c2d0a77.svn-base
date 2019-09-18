//
//  TCLookDepositViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLookDepositViewController.h"
#import "TCLookDepositCell.h"
#import "TCHtmlViewController.h"
#import "TCLookDeposit.h"
#import "TCZCBZJView.h"
#import "TCTopHubView.h"
#import "TCChongZhiBZJViewController.h"
@interface TCLookDepositViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *depositTableView;
@property (nonatomic, strong) UIView *headview;//头部图片
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSMutableArray *dataArray; //数据
@property (nonatomic, strong) UIButton *outButton; //转出
@property (nonatomic, strong) UIButton *continuedButton;  //充值
@property (nonatomic, strong) TCTopHubView *topView; //头部视图
@property (nonatomic, strong) NSString *maxmoney;//最大充值数
@end

@implementation TCLookDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看保证金";
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.dataArray = [[NSMutableArray alloc]init];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //创建tableView
    [self createTabelView];
    //加刷新
    [self setupRefresh];
}
//添加刷新控件
- (void)setupRefresh{
    __block int  page = 1;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self createQuest];
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
    self.depositTableView.mj_header = header;
    [header beginRefreshing];
}

//请求接口
-(void)createQuest{
    [self.dataArray removeAllObjects];
    NSDictionary *paramter = @{@"id":[_defaults valueForKey:@"userID"], @"token":[_defaults valueForKey:@"userToken"], @"shopid":self.shopID};
    NSLog(@"%@",paramter);
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900041"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if(jsonDic[@"data"]){
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            arr = jsonDic[@"data"][@"list"];
            for (int i = 0; i < arr.count; i++) {
                [self.dataArray addObject: [TCLookDeposit ModelWithDictionary:arr[i]]];
           }
            _maxmoney = [NSString stringWithFormat:@"%@", jsonDic[@"data"][@"bondMax"]];
            NSString *bounStatus = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"bounStatus"]];
            NSString *bondOutStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"bondOut"]];
            if([bounStatus isEqualToString:@"1"]){
                self.outButton.hidden = NO;
                self.outButton.frame = CGRectMake(0, HEIGHT - 48 - 64, WIDHT, 48);
                
                if([bondOutStr isEqualToString:@"1"]){
                    self.outButton.backgroundColor = TCUIColorFromRGB(0x22D982);
                    self.outButton.userInteractionEnabled = YES;
                }else if ([bondOutStr isEqualToString:@"0"]){
                    self.outButton.backgroundColor = TCUIColorFromRGB(0xDEDEDE);
                    self.outButton.userInteractionEnabled = NO;
                }
            }else if ([bounStatus isEqualToString:@"0"] || [bounStatus isEqualToString:@"2"]){
                self.continuedButton.frame = CGRectMake(0, HEIGHT - 48 - 64, WIDHT, 48);
                self.outButton.hidden = YES;
                self.continuedButton.hidden = NO;
                self.continuedButton.backgroundColor = TCUIColorFromRGB(0x24A7F2);
                self.continuedButton.userInteractionEnabled = YES;
            }else if ([bounStatus isEqualToString:@"3"]){
                self.continuedButton.hidden = NO;
                self.outButton.hidden = NO;
                if([bondOutStr isEqualToString:@"1"]){
                    self.outButton.backgroundColor = TCUIColorFromRGB(0x22D982);
                    self.continuedButton.backgroundColor = TCUIColorFromRGB(0x24A7F2);
                    self.outButton.userInteractionEnabled = YES;
                    self.continuedButton.userInteractionEnabled = YES;
                }else if ([bondOutStr isEqualToString:@"0"]){
                    self.outButton.backgroundColor = TCUIColorFromRGB(0xDEDEDE);
                    self.continuedButton.backgroundColor = TCUIColorFromRGB(0x24A7F2);
                    self.outButton.userInteractionEnabled = NO;
                    self.continuedButton.userInteractionEnabled = YES;
                }
            }else if ([bounStatus isEqualToString:@"4"] || [bounStatus isEqualToString:@"-1"]){
                self.outButton.hidden = YES;
                self.continuedButton.hidden = YES;
            }
            [self.depositTableView reloadData];
            _status = bounStatus;
            [self performSelector:@selector(show) withObject:self afterDelay:0.5];
            [self.depositTableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//创建tableView
-(void)createTabelView
{
    //头部视图
    UIImageView *imview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 100)];
    imview.image = [UIImage imageNamed:@"查看保证金图片"];
    [self.view addSubview: imview];
    //视图上的文字
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.frame = CGRectMake(71, 30, WIDHT - 71*2, 41);
    headLabel.text = @"因为有保证，所以更有保障";
    headLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    headLabel.font = [UIFont systemFontOfSize:16];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.layer.borderWidth = 2;
    headLabel.layer.borderColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.3].CGColor;
    [imview addSubview:headLabel];
    
    self.topView = [[TCTopHubView alloc] init];
    [imview addSubview:self.topView];
    
    if ([_status isEqualToString:@"4"] || [_status isEqualToString:@"-1"]){
        self.depositTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imview.frame), WIDHT, HEIGHT - 64 - 100) style:(UITableViewStylePlain)];
    }else{
         self.depositTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imview.frame), WIDHT, HEIGHT - 48 - 64 - 100) style:(UITableViewStylePlain)];
    }
    self.depositTableView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.depositTableView.delegate = self;
    self.depositTableView.dataSource = self;
    self.depositTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.depositTableView];
    [self.depositTableView registerClass:[TCLookDepositCell class] forCellReuseIdentifier:@"cells"];
    
    //下面的两个按钮
    //申请转出
    self.outButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.outButton.frame = CGRectMake(0, HEIGHT - 48 - 64, 120, 48);
    [self.outButton setTitle:@"申请转出" forState:(UIControlStateNormal)];
    [self.outButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.outButton.hidden = YES;
    self.outButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.outButton.backgroundColor = TCUIColorFromRGB(0xDEDEDE);
    [self.outButton addTarget:self action:@selector(outButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.outButton];
    //续交
    self.continuedButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.continuedButton.frame = CGRectMake(CGRectGetMaxX(self.outButton.frame), HEIGHT - 48 - 64, WIDHT - 120, 48);
    [self.continuedButton setTitle:@"充值保证金" forState:(UIControlStateNormal)];
    [self.continuedButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.continuedButton.hidden = YES;
    self.continuedButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.continuedButton.backgroundColor = TCUIColorFromRGB(0xDEDEDE);
    [self.continuedButton addTarget:self action:@selector(continuedButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.continuedButton];
}

- (void)show{
    if ([_status isEqualToString:@"4"]) {
        [self.topView ShowHubWithTitle:@"保证金正在审核中，请您耐心等待..." andColor:[TCUIColorFromRGB(0x24a7f2) colorWithAlphaComponent:0.8]];
    }else if ([_status isEqualToString:@"-1"]){
        [self.topView ShowHubWithTitle:@"申请保证金转出中....\n稍后会有服务人员和您联系，并了解终端机情况" andColor:[TCUIColorFromRGB(0xFF2850) colorWithAlphaComponent:0.8]];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCLookDepositCell *cell = [self.depositTableView dequeueReusableCellWithIdentifier:@"cells"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count != 0) {
        [cell loadData: self.dataArray[indexPath.section]];
    }
    if(indexPath.section == self.dataArray.count - 1){
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 42 + 25)];
        [self.depositTableView setTableFooterView:footerView];
        
        UILabel *footLabel = [[UILabel alloc] init];
        footLabel.frame = CGRectMake(9, 8, WIDHT - 9 - 15, 34);
        footLabel.text = @"注意：冻结期内保证金无法提现，申请转出保证金通过后保证金转出到余额中进行提现";
        footLabel.numberOfLines = 0;
        footLabel.textColor = TCUIColorFromRGB(0x99734C);
        footLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [footerView addSubview:footLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
   }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark -- 申请转出
- (void)outButton:(UIButton *)sender{
    [TCZCBZJView ShowViewShopid:self.shopID andcommit:^{
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ToppedUpSuccessNeedRefresh" object:nil];
    }];
}
//转出保证金的接口
-(void)createOutQuest
{
    [SVProgressHUD showWithStatus:@"转出中..."];
    NSDictionary *paramter = @{@"id":[_defaults valueForKey:@"userID"], @"token":[_defaults valueForKey:@"userToken"], @"shopid":self.shopID};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900042"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
       
        if([jsonDic[@"retValue"] integerValue] > 0){
           [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
        }else{
           [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
        
        [self.depositTableView reloadData];
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD showErrorWithStatus:@"检查网络"];
    }];
}
#pragma mark -- 续交保证金
- (void)continuedButton:(UIButton *)sender
{
    TCChongZhiBZJViewController *zbzjVC = [[TCChongZhiBZJViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    zbzjVC.shopid = _shopID;
    zbzjVC.isChongzhi = NO;
    zbzjVC.again = ^{
        [self setupRefresh];
    };
    zbzjVC.maxmoney = _maxmoney;
    [self.navigationController pushViewController:zbzjVC animated:YES];
}
#pragma mark -- 说明
- (void)rightButton
{
    NSLog(@"说明");
    TCHtmlViewController *html = [[TCHtmlViewController alloc]init];
    html.html = @"https://sellerapi.moumou001.com/h5/bond-view";
    html.title = @"保证金说明";
    [self.navigationController pushViewController:html animated:YES];
    
}


@end
