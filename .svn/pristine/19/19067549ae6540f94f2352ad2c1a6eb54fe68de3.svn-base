//
//  TCOrderViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderViewController.h"
#import "TCNewOrderViewController.h"
#import "TCNoDisViewController.h"
#import "TCDisViewController.h"
#import "TCFinshedViewController.h"
#import "TCIdeaViewController.h"
#import "TCNewOrderTableViewCell.h"
#import "TCDealOrderViewController.h"
#import "TCOrderDetailViewController.h"

#import "TCListCell.h"
#import "OrderObject.h"
#import "TCOrderInfo.h"
#import "TCNewOrderModel.h"
#import "UITableView+HD_NoList.h"
@interface TCOrderViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *typeStr;
    UITableView *listTableView;
    UIView *lineView;
    int typesss; //类型
}

@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UILabel *lb1;
@property (nonatomic, strong) UILabel *lb2;
@property (nonatomic, strong) UILabel *lb3;
//@property (nonatomic, strong) UILabel *lb4;

@property (nonatomic, strong) UILabel *churedDotLabel;
@property (nonatomic, strong) UILabel *faredDotLabel;
@property (nonatomic, strong) UILabel *tuiredDotLabel;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) NSMutableArray *dataMuArr;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) UITextField *searchTextField; //搜索


@end

@implementation TCOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    self.tabBarController.tabBar.hidden= NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestss) name:@"needGetFresh" object:nil];
    
    //去除边框影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ViewColor;
    self.dataMuArr = [NSMutableArray array];
    //初始化导航栏内容
    [self setupNav];
    //设置视图
    [self setMainView];
}

#pragma arguments
- (void)requestss
{
    [self setupRefresh:@"2" andkeyWord:@""];
}

//设置导航栏
- (void)setupNav{

    //设置顶部的搜索框
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(12, 28, WIDHT - 24, 32);
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 2;
    topView.layer.masksToBounds = YES;
    self.navigationItem.titleView = topView;
    
    //搜索的图片
    UIImageView *searchImage = [[UIImageView alloc] init];
    searchImage.image = [UIImage imageNamed:@"搜索放大镜"];
    searchImage.frame = CGRectMake(12, 8, 16, 16);
    [topView addSubview:searchImage];
    
    //搜索
    self.searchTextField = [[UITextField alloc] init];
    self.searchTextField.frame = CGRectMake(CGRectGetMaxX(searchImage.frame) + 15, 0, WIDHT - 24 - 12 - 16 - 15, 32);
    self.searchTextField.placeholder = @"收货人姓名、手机号搜索订单";
    [self.searchTextField setValue:TCUIColorFromRGB(0xCCCCCC) forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    self.searchTextField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    self.searchTextField.delegate = self;
    
    [topView addSubview:self.searchTextField];
    
    self.navigationController.navigationBar.translucent = NO;
}
-(void)barButtonItemPressed:(UIButton *)sender
{
    TCIdeaViewController * benefitVC = [[TCIdeaViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:benefitVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//设置子类视图
- (void)setMainView{
    
    typeStr = @"待处理";
    CGFloat w = WIDHT / 5 ;
    CGFloat h = 72;
    
    NSArray *titleArray = @[@"待处理", @"已发货", @"退款中",@"已完成",@"全部"];
    //创建view
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i *w,  0, WIDHT / 5, h);
        btn.backgroundColor = TCNavColor;
//        btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView.frame.size.height + 5, - btn.bounds.size.width, 0, 0);
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.frame.size.width/2, btn.titleLabel.frame.size.height + 5, - btn.frame.size.width/2);
        if (i == 0){
            self.churedDotLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT / 5 - 10 - 18 , 3, 18, 12)];
            self.churedDotLabel.backgroundColor = TCUIColorFromRGB(0xFF5544);
            self.churedDotLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
            self.churedDotLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
            self.churedDotLabel.textAlignment = NSTextAlignmentCenter;
            self.churedDotLabel.layer.masksToBounds = YES;
            self.churedDotLabel.layer.cornerRadius = 6;
            self.churedDotLabel.hidden = YES;
            [btn addSubview:self.churedDotLabel];
            [btn setImage:[UIImage imageNamed:@"待处理图标（未选）"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"待处理图标（已选）"] forState:UIControlStateSelected];
        } else if (i == 1){
            self.faredDotLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT / 5 - 10 - 18 , 3, 18, 12)];
            self.faredDotLabel.backgroundColor = TCUIColorFromRGB(0xFF5544);
            self.faredDotLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
            self.faredDotLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
            self.faredDotLabel.textAlignment = NSTextAlignmentCenter;
            self.faredDotLabel.layer.masksToBounds = YES;
            self.faredDotLabel.layer.cornerRadius = 6;
            self.faredDotLabel.hidden = YES;
            [btn addSubview:self.faredDotLabel];
            
            [btn setImage:[UIImage imageNamed:@"已发货图标"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"已发货图标（已选）"] forState:UIControlStateSelected];
        } else if (i == 2) {
            self.tuiredDotLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT / 5 - 10 - 18 , 3, 18, 12)];
            self.tuiredDotLabel.backgroundColor = TCUIColorFromRGB(0xFF5544);
            self.tuiredDotLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
            self.tuiredDotLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
            self.tuiredDotLabel.textAlignment = NSTextAlignmentCenter;
            self.tuiredDotLabel.layer.masksToBounds = YES;
            self.tuiredDotLabel.layer.cornerRadius = 6;
            self.tuiredDotLabel.hidden = YES;
            [btn addSubview:self.tuiredDotLabel];

            [btn setImage:[UIImage imageNamed:@"退款中图标（未选）"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"退款中图标（已选）"] forState:UIControlStateSelected];
        } else if (i == 3) {
            [btn setImage:[UIImage imageNamed:@"已完成图标（未选）"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"已完成图标（已选）"] forState:UIControlStateSelected];
        } else if (i == 4){
            [btn setImage:[UIImage imageNamed:@"全部图标（未选）"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"全部图标（已选）"] forState:UIControlStateSelected];
        }
        
        [btn setTitle:titleArray[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6]  forState:(UIControlStateNormal)];
        [btn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateSelected)];
        CGFloat offset = 10.0f;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, -btn.imageView.frame.size.height-offset/2, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height-offset/2, - 8, 0, -btn.titleLabel.intrinsicContentSize.width);
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        btn.tag = 1000 + i;
        if (i == 0) {
            btn.selected = YES;
            _lastButton = btn;
        }
        [btn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        //声明tableView
        listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), WIDHT, HEIGHT - 49 -64 - 60) style:UITableViewStyleGrouped];
        listTableView.backgroundColor = ViewColor;
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.showsVerticalScrollIndicator = NO;
        listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:listTableView];
        
        [listTableView registerClass:[TCListCell class] forCellReuseIdentifier:@"cells"];
        // self.view.backgroundColor = listTableView.backgroundColor;
        
        typesss = 2;
    }
    //默认请求  按下单时间排序
    [self setupRefresh:@"2" andkeyWord:@""];
    
    //加上细线
    lineView = [[UIView alloc] initWithFrame:CGRectMake((WIDHT/titleArray.count - 15)/2, 72 - 6, 15, 4)];
    lineView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    lineView.tag = 2000;
    [self.view addSubview:lineView];
}

//添加刷新控件
- (void)setupRefresh:(NSString *)orderState andkeyWord:(NSString *)keyWord{
    __block int  page = 1;
    listTableView.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    [listTableView dismissNoView];
//    _isCanRefresh = NO;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self request:orderState andkeyWord:keyWord];
    }];
    //设置刷新标题
    [header setTitle:@"下拉刷新顺道嘉订单..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新顺道嘉订单..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新顺道嘉订单..." forState:MJRefreshStateRefreshing];
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
        [self requestUp:page andStatus:orderState andkeyWord:keyWord];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉订单" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉订单..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉订单!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    listTableView.mj_header = header;
    listTableView.mj_footer = footer;
    [header beginRefreshing];
}

//下拉请求
- (void)request:(NSString *)statusx andkeyWord:(NSString *)keyWord{
    
    self.searchTextField.text = @"";
    [self.dataMuArr removeAllObjects];
    [self.arr removeAllObjects];
    listTableView.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"userToken"]];
    NSDictionary *dicc;
    NSDictionary *parameters;
    if ([keyWord isEqualToString:@""]){
         dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx,@"shopId":shopID};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx,@"shopId":shopID,@"sign":singStr};

    } else {
         dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx,@"shopId":shopID,@"keyWord":keyWord};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@"1",@"typeKey":statusx,@"shopId":shopID,@"keyWord":keyWord,@"sign":singStr};
    }

    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202001"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        if (jsonDic[@"data"]){
            NSArray *arr = jsonDic[@"data"][@"orderList"];
            for (NSDictionary *dic in arr) {
                TCNewOrderModel *model = [TCNewOrderModel orderInfoWithDictionary:dic];
                [self.dataMuArr addObject:model];
            }
            [listTableView reloadData];
            self.churedDotLabel.text = jsonDic[@"data"][@"hintNum"][@"untreated"];
            NSLog(@"%@",self.churedDotLabel.text);
            int num = [self.churedDotLabel.text intValue];
            if (num < 1) {
                self.churedDotLabel.hidden = YES;
            }else if (num <= 99 && num > 0){
                self.churedDotLabel.hidden = NO;
            }else if (num > 99){
                self.churedDotLabel.hidden = NO;
                self.churedDotLabel.text = @"99+";
            }
            
            self.faredDotLabel.text = jsonDic[@"data"][@"hintNum"][@"alreadySend"];
            NSLog(@"%@",self.faredDotLabel.text);
            int fanum = [self.faredDotLabel.text intValue];
            if (fanum < 1) {
                self.faredDotLabel.hidden = YES;
            }else if (fanum <= 99 && fanum > 0){
                self.faredDotLabel.hidden = NO;
            }else if (fanum > 99){
                self.faredDotLabel.hidden = NO;
                self.faredDotLabel.text = @"99+";
            }
            
            self.tuiredDotLabel.text = jsonDic[@"data"][@"hintNum"][@"refund"];
            NSLog(@"%@",self.tuiredDotLabel.text);
            int tuinum = [self.tuiredDotLabel.text intValue];
            if (tuinum < 1) {
                self.tuiredDotLabel.hidden = YES;
            }else if (tuinum <= 99 && tuinum > 0){
                self.tuiredDotLabel.hidden = NO;
            }else if (tuinum > 99){
                self.tuiredDotLabel.hidden = NO;
                self.tuiredDotLabel.text = @"99+";
            }
            
        } else {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        //占位图
        [self NeedResetNoView];
        [listTableView reloadData];
        [listTableView.mj_header endRefreshing];
        listTableView.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;

        //_isCanRefresh = YES;
    } failure:^(NSError *error) {
       // _isCanRefresh = YES;
        nil;
    }];
    [listTableView.mj_footer resetNoMoreData];
}
//占位图
- (void)NeedResetNoView{
    if (self.dataMuArr.count >0) {
        [listTableView dismissNoView];
    }else{
        [listTableView showNoView:@"暂无订单" image: [UIImage imageNamed:@"无订单缺省页"] certer:CGPointZero];
    }
}
//上拉加载
- (void)requestUp:(int)page andStatus:(NSString *)statusx andkeyWord:(NSString *)keyWord{
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"userToken"]];
    NSDictionary *dicc;
    NSDictionary *parameters;
    if ([keyWord isEqualToString:@""]){
        dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@(page),@"typeKey":statusx,@"shopId":shopID};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@(page),@"typeKey":statusx,@"shopId":shopID,@"sign":singStr};
        
    } else {
        dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@(page),@"typeKey":statusx,@"shopId":shopID,@"keyWord":keyWord};
        NSString *singStr = [TCServerSecret loginStr:dicc];
        parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"page":@(page),@"typeKey":statusx,@"shopId":shopID,@"keyWord":keyWord,@"sign":singStr};
    }
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202001"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]){
            NSArray *arr = jsonDic[@"data"][@"orderList"];
            for (NSDictionary *dic in arr) {
                TCNewOrderModel *model = [TCNewOrderModel orderInfoWithDictionary:dic];
                [self.dataMuArr addObject:model];
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

- (void)typeSelect:(UIButton *)button {
    _lastButton.selected = NO;
    button.selected = YES;
    _lastButton = button;
    if (lineView){
        [lineView removeFromSuperview];
        [self.view addSubview:lineView];
    }
   
    CGRect frame = lineView.frame;
    if (button.tag == 1000) {
        [listTableView dismissNoView];
        typeStr = @"待处理";
        typesss = 2;
        frame.origin.x = (72 - 15)/2;
        [self setupRefresh:@"2" andkeyWord:@""];
        
    } else if (button.tag == 1001) {
        [listTableView dismissNoView];
        typeStr = @"已收货";
        frame.origin.x = WIDHT / 5 + (72 - 15)/2 ;
        [self setupRefresh:@"3" andkeyWord:@""];
        typesss = 3;
        
    } else if (button.tag == 1002) {
        [listTableView dismissNoView];
        frame.origin.x = WIDHT / 5 * 2 + (72 - 15)/2;
        typeStr = @"退款中";
        [self setupRefresh:@"4" andkeyWord:@""];
        typesss = 4;
    } else if (button.tag == 1003){
        [listTableView dismissNoView];
        frame.origin.x = WIDHT / 5 * 3 + (72 - 15)/2;
        typeStr = @"已完成";
        [self setupRefresh:@"5" andkeyWord:@""];
        typesss = 5;
    } else if (button.tag == 1004){
        [listTableView dismissNoView];
        frame.origin.x = WIDHT / 5 * 4 + (72 - 15)/2;
        typeStr = @"全部";
        [self setupRefresh:@"1" andkeyWord:@""];
        typesss = 1;
    }
    [listTableView reloadData];
    lineView.frame = frame;
}
#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataMuArr.count != 0){
        TCNewOrderModel *model = self.dataMuArr[indexPath.section];
        return model.cellHight;
    }
    
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
    footerView.backgroundColor = TCBgColor;
    return footerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
    footerView.backgroundColor = TCBgColor;
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCListCell *cell = [listTableView dequeueReusableCellWithIdentifier:@"cells"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataMuArr.count != 0){
        TCNewOrderModel *model = self.dataMuArr[indexPath.section];
        cell.model = model;
        
    } else {
       
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TCOrderDetailViewController *detail = [[TCOrderDetailViewController alloc]init];
    TCNewOrderModel *model = self.dataMuArr[indexPath.section];
    detail.typeS = model.typeStr;
    detail.shopId = model.shopid;
    detail.oid = model.orderid;
    detail.statusName = model.statusName;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -- 打电话
- (void)contact:(UIButton *)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [listTableView indexPathForCell:cell];

    NSString *allString = [NSString stringWithFormat:@"tel:%@", self.arr[path.section][@"address"][@"mobile"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString] options:@{} completionHandler:nil];
}

//点击搜索的
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSLog(@"点击了搜索");
    [self setupRefresh:typeStr andkeyWord:textField.text];
    
    return YES;
}


@end
