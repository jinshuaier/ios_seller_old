//
//  TCShopAssistantController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopAssistantController.h"
#import "TCShopManageCell.h"
#import "TCAddAssistantController.h"
@interface TCShopAssistantController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *rightButton;
    UIImageView *image;
}
@property (nonatomic, strong) UITableView *classifyTable; //导航栏后面的tableView
@property (nonatomic, strong) NSArray *classifyArr; //后面的数组
@property (nonatomic, strong) NSString *className; //文字
@property (nonatomic, strong) UIView *backView;//添加背景颜色
@property (nonatomic, strong) NSString *selectedStr;//记录选中的按钮
@property (nonatomic, strong) UITableView *messageTable; //店铺管理tableview
@property (nonatomic, strong) NSMutableArray *messageArr; // 店铺管理的数组
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCShopAssistantController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shuaxin) name:@"shuaxin" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageArr = [[NSMutableArray alloc]init];
    //初始化保存
    _userdefault = [NSUserDefaults standardUserDefaults];
    //去除边框影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"店员管理";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = ViewColor;
    
    if([[_userdefault valueForKey:@"userRole"] isEqualToString:@"商家"]){
        
    //右边导航栏的按钮
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 24)];
    
    // Add your action to your button
    self.className = @"全部"; // 这个是默认的值
    rightButton.selected = NO;
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTitle:self.className forState:(UIControlStateNormal)];
    rightButton.layer.cornerRadius = 3;
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor=[UIColor whiteColor].CGColor;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15*WIDHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    //数组里的数据
    self.classifyArr = @[@"全部",@"店长",@"店员"];
        //创建店铺管理tableView
        [self createMessageTableview];
        //下拉刷新
        [self setupRefresh:@"0"];
    }else{
        //创建店铺管理tableView
        [self createMessageTableview];
        //下拉刷新
        [self setupRefresh:@"2"];
    }
    
    //创建底部的button
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addBtn setTitle:@"添加店员" forState:(UIControlStateNormal)];
    addBtn.frame = CGRectMake(0, HEIGHT - 48 * HEIGHTSCALE - 64, WIDHT, 48*HEIGHTSCALE);
    [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18 *HEIGHTSCALE];
    addBtn.backgroundColor = [UIColor colorWithRed:0 green:183/255.0 blue:183/255.0 alpha:1.0];
    [addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    addBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:addBtn];
    
}

- (void)shuaxin{
    [self setupRefresh:@"0"];
}

//添加刷新控件
- (void)setupRefresh:(NSString *)type{
    __block int  page = 1;
    self.messageTable.userInteractionEnabled = NO;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self requests:type andpages:page];
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
        [self request:page andtype:type];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    self.messageTable.mj_header = header;
    self.messageTable.mj_footer = footer;
    [header beginRefreshing];
    
}
//下拉请求服务器
- (void)requests: (NSString *)type  andpages:(int)page{

    [_messageArr removeAllObjects];
    
    page = 1;
    
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"page":@(page), @"type":type,@"limit":@"10"};
    
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100110"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if(dic[@"data"]){
            [image removeFromSuperview];
            [self.messageArr addObjectsFromArray:dic[@"data"]];
            [SVProgressHUD showSuccessWithStatus:@"加载成功!"];
            [self.messageTable reloadData];
            [self.messageTable.mj_header endRefreshing];
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"暂时还没有店员"];
            [self.messageTable reloadData];
            [self.messageTable.mj_header endRefreshing];
            //创建无店员的图标
            [self createNotShoper];
        }
        self.messageTable.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        nil;
    }];
}

//上拉请求服务器
- (void)request:(int)page andtype: (NSString *)type{
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"page":@(page), @"type":type,@"limit":@"10"};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100110"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"  %@,%@",paramter, dic);
     
        if (dic[@"data"]) {
            [self.messageArr addObjectsFromArray:dic[@"data"]];
            [self.messageTable reloadData];
            [self.messageTable.mj_footer endRefreshing];
        }else{
            [self.messageTable.mj_footer endRefreshing];
            [self.messageTable.mj_footer endRefreshingWithNoMoreData];
        }

        
        self.messageTable.userInteractionEnabled = YES;
    }  failure:^(NSError *error) {
        nil;
    }];
}
#pragma mark -- 创建全部的详情
-(void)classifyTableView
{
    self.classifyTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDHT - 100, 0, 100, 32*HEIGHTSCALE * 3) style:UITableViewStyleGrouped];
    self.classifyTable.delegate = self;
    self.classifyTable.dataSource = self;
    self.classifyTable.showsVerticalScrollIndicator = NO;
    self.classifyTable.tableFooterView = [[UIView alloc]init];
    [self.backView addSubview:self.classifyTable];
}
-(void)createMessageTableview{
    
    self.messageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 48*HEIGHTSCALE - 64) style:UITableViewStyleGrouped];
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.messageTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview: self.messageTable];
    
}
#pragma mark -- 无商品的图标
-(void)createNotShoper
{
    image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"暂未添加店员提示"];
    image.frame = CGRectMake((WIDHT - 88*WIDHTSCALE)/2, (HEIGHT - 88*WIDHTSCALE )/2 - 64, 88*WIDHTSCALE, 88*WIDHTSCALE);
    [self.view addSubview:image];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.classifyTable) {
        return 0.1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(tableView == self.classifyTable){
        return 0.1;
    }else{
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classifyTable) {
        return 32 *HEIGHTSCALE;
    }else{
        return 149  ;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.classifyTable) {
        return self.classifyArr.count;
    }else{
        return _messageArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classifyTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
            cell.textLabel.text = self.classifyArr[indexPath.section];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if ([self.classifyArr[indexPath.section] isEqualToString:_selectedStr]) {
                cell.textLabel.textColor = [UIColor redColor];
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }else{
        [self.messageTable registerNib:[UINib nibWithNibName:@"TCShopManageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        TCShopManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //启用和未启用
        if(_messageArr.count > 0){
            if([_messageArr[indexPath.section][@"enabled"] isEqualToString:@"-1"])
            {
                cell.backgroundColor = ColorLine;
            }else{
                cell.backgroundColor = [UIColor whiteColor];
            }
            cell.nameLabel.text = _messageArr[indexPath.section][@"name"];
            
            if([_messageArr[indexPath.section][@"shopname"] isKindOfClass:[NSNull class]])
            {
                cell.companyLabel.text = @"未关联任何店铺";
            }else{
                cell.companyLabel.text = _messageArr[indexPath.section][@"shopname"];
            }
            
            cell.phoneLabel.text = [NSString stringWithFormat:@"电话：%@", _messageArr[indexPath.section][@"mobile"]];
            
            NSString *dataString = _messageArr[indexPath.section][@"created_at"];
            NSString *dataStr = [dataString substringToIndex:10];//截取掉下标10之后的字符串
            cell.dateLabel.text = dataStr;
            
            NSString *timeStr = [dataString substringFromIndex:11];//截取掉下标11之前的字符串
            cell.timeLabel.text = timeStr;
            cell.sortLabel.text = _messageArr[indexPath.section][@"item_name"];
            [cell.reviseBtn addTarget:self action:@selector(cilkReviBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.reviseBtn.tag = indexPath.section;
        }else{
            NSLog(@"没数据了哈");
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.classifyTable) {
        [rightButton setTitle:self.classifyArr[indexPath.section] forState:UIControlStateNormal];
        if(indexPath.section == 0){
            [self setupRefresh:@"0"];
        }else if (indexPath.section == 1){
            [self setupRefresh:@"1"];
        }else if (indexPath.section == 2){
            [self setupRefresh:@"2"];
        }
        self.className = self.classifyArr[indexPath.section];
        _selectedStr = self.classifyArr[indexPath.section];
        [rightButton setTitle:self.className forState:(UIControlStateNormal)];
        rightButton.selected = NO;
        [_backView removeFromSuperview];
        
    }
}
#pragma mark -- 导航栏右边按钮的点击事件
-(void)barButtonItemPressed:(UIButton *)send{
    if(send.selected == NO){
        send.selected = YES;
        [send setTitle:self.className forState:(UIControlStateSelected)];
        
        //创建背景颜色
        [self createBackView];
        //创建tableView
        [self classifyTableView];
    }else {
        send.selected = NO;
        [self.backView removeFromSuperview];
    }
}
//背景颜色
-(void)createBackView{
    //创建背景颜色
    self.backView = [[UIView alloc]init];
    self.backView .backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    self.backView .frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    [self.view addSubview:self.backView];
}
//[send setImage:[UIImage imageNamed:@"xialatubiaoup"] forState:(UIControlStateNormal)];
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击空白处键盘下滑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    rightButton.selected = NO;
    [self.backView removeFromSuperview];
}
#pragma mark -- 底部按钮的点击事件
-(void)clickAddBtn:(UIButton *)sender
{
    NSLog(@"添加店员");
    
    TCAddAssistantController *addVC = [[TCAddAssistantController alloc]init];
    addVC.shopName = self.shopName;
    addVC.shopID = self.shopID;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark -- 点击了编辑的按钮
-(void)cilkReviBtn:(UIButton *)sender
{
//店铺id
   
    
    TCAddAssistantController *addVC = [[TCAddAssistantController alloc]init];
    addVC.isChange = YES;
    addVC.idStr = _messageArr[sender.tag][@"id"];
    addVC.name = _messageArr[sender.tag][@"name"];
    addVC.shopName = _messageArr[sender.tag][@"shopname"];
    addVC.phoneNum = _messageArr[sender.tag][@"mobile"];
    addVC.passWord = _messageArr[sender.tag][@"name"];
    addVC.role = _messageArr[sender.tag][@"item_name"];
    addVC.endle = _messageArr[sender.tag][@"enabled"];
    addVC.shopID = _messageArr[sender.tag][@"shopid"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
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
