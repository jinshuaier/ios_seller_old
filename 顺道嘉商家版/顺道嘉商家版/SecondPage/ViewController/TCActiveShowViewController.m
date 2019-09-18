//
//  TCActiveShowViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActiveShowViewController.h"
#import "TCCreateActiveController.h"
#import "TCPreferentialCell.h"
#import "TCCreateActiveController.h"
@interface TCActiveShowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *preferenTable;
    NSMutableArray *preArr; // 可变数组
    NSString *idStr;//活动的id
    NSString *aid;
    UIImageView *tostimage; //无活动提示图片
    UILabel *tostLabel; //无活动提示文字
    UIButton *activitBtn; //创建活动按钮
    UIButton *rightButton;
}
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *backView;
@end

@implementation TCActiveShowViewController

-(void)viewWillAppear:(BOOL)animated{
    [self createQueste];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建优惠活动";
    self.view.backgroundColor = ViewColor;
    _userdefault = [NSUserDefaults standardUserDefaults];
    preArr = [[NSMutableArray alloc]init];
    //创建提示框以及创建活动的按钮
    [self createActiveView];
    //创建tableView
    [self createTable];
    [self setupRefresh];
   
    //右边导航栏的按钮
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80*WIDHTSCALE, 28*HEIGHTSCALE)];
    [rightButton setTitle:@"添加活动" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*HEIGHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    // Add your action to your button
    rightButton.userInteractionEnabled = YES;
    [rightButton addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"设置"] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    /**
     width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barBtn, nil];
   

    // Do any additional setup after loading the view.
}
//添加刷新控件
- (void)setupRefresh{
    __block int  page = 1;
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        preferenTable.userInteractionEnabled = NO;
        [self createQueste];
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
        [self createup:page];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    preferenTable.mj_header = header;
    preferenTable.mj_footer = footer;
    [header beginRefreshing];
    
}

//下拉请求
- (void)createQueste{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [preArr removeAllObjects];
    NSDictionary *parmer = @{@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"pageNum":@"1",@"numPerPage":@"15"};
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200019"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if(dic[@"data"]){
            preArr = dic[@"data"];
            [self.view addSubview: preferenTable];
            [preferenTable.mj_header endRefreshing];
            preferenTable.userInteractionEnabled = YES;
            tostimage.hidden = YES; //无活动提示图片
            tostLabel.hidden = YES; //无活动提示文字
            activitBtn.hidden = YES;
        }else{
            [preferenTable.mj_header endRefreshing];
            tostimage.hidden = NO; //无活动提示图片
            tostLabel.hidden = NO; //无活动提示文字
            activitBtn.hidden = NO;
        }
        [preferenTable reloadData];
        [SVProgressHUD dismiss];
        NSLog(@"%@",dic[@"retMessage"]);
    } failure:^(NSError *error) {
        nil;
    }];
     [preferenTable.mj_footer resetNoMoreData];

}

//上拉加载
-(void)createup:(int)page{
    NSDictionary *parmer = @{@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"pageNum":@(page),@"numPerPage":@"15"};
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200019"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
      [preferenTable.mj_footer resetNoMoreData];
        if (dic[@"data"]) {
            [preArr addObjectsFromArray: dic[@"data"]];
            [preferenTable.mj_footer endRefreshing];
        }else{
            [preferenTable.mj_footer endRefreshing];
            [preferenTable.mj_footer endRefreshingWithNoMoreData];
        }
        [preferenTable reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
}
#pragma mark -- 创建tableView
-(void)createTable
{
    preferenTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    preferenTable.delegate = self;
    preferenTable.dataSource = self;
    preferenTable.rowHeight = 240;
    preferenTable.tableFooterView = [[UIView alloc]init];
//    [self.view addSubview: preferenTable];
}

#pragma mark -- tableView的代理方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellImageView";
    TCPreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TCPreferentialCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(preArr.count == 0){
        NSLog(@"加大力点刷新");
    }else{
    cell.activeName.text = preArr[indexPath.section][@"content"];
    cell.activeName.numberOfLines = 0;
    cell.activeName.textColor = shopColor;
   // cell.activeTime.text = [NSString stringWithFormat:@"满%@减%@",preArr[indexPath.section][@"man"],preArr[indexPath.section][@"cut"]];
        cell.activeTime.hidden = YES;
    cell.activeTime.textColor = RedColor;
    cell.beginTime.text = [NSString stringWithFormat:@"开始时间:%@", preArr[indexPath.section][@"startTime"]];
    cell.beginTime.textColor = SmallTitleColor;
    cell.finshTime.text = [NSString stringWithFormat:@"结束时间:%@", preArr[indexPath.section][@"endTime"]];
    cell.finshTime.textColor = SmallTitleColor;

    cell.activeBtn.layer.cornerRadius = 2;
    cell.activeBtn.clipsToBounds = YES;
    [cell.activeBtn addTarget:self action:@selector(activeBtn:)
             forControlEvents:(UIControlEventTouchUpInside)];
    if([preArr[indexPath.section][@"inner"] isEqualToString:@"0"]){
        cell.imageHead.image = [UIImage imageNamed:@"活动未开启标签"];
        cell.activeBtn.backgroundColor =ColorLine;
        cell.activeBtn.userInteractionEnabled = NO;
        
    }else{
        cell.activeBtn.backgroundColor =  [UIColor colorWithRed:22/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        cell.activeBtn.userInteractionEnabled = YES;
        cell.imageHead.image = [UIImage imageNamed:@"活动已开启标签"];
    }
    [cell.activeBtn setTitle:@"结束活动" forState:(UIControlStateNormal)];
    cell.activeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.activeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [cell.changBtn addTarget:self action:@selector(changeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.changBtn.tag = indexPath.section;
    if([preArr[indexPath.section][@"inner"] isEqualToString:@"0"]){
        cell.changBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        cell.changBtn.userInteractionEnabled = YES;
        
    }else{
        cell.changBtn.backgroundColor = ColorLine;
        cell.changBtn.userInteractionEnabled = NO;
    }
    [cell.changBtn setTitle:@"修改活动" forState:(UIControlStateNormal)];
    cell.changBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.changBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    cell.changBtn.layer.cornerRadius = 2;
    cell.changBtn.clipsToBounds = YES;
    }
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return preArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.5;
    }else{
        return 8;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 提示语和按钮
-(void)createActiveView
{
    //提示的图片
    tostimage = [[UIImageView alloc]init];
    tostimage.image = [UIImage imageNamed:@"无活动提示图@2x"];
    tostimage.frame = CGRectMake((WIDHT - 256/2*WIDHTSCALE)/2, 40*HEIGHTSCALE, 256/2*WIDHTSCALE, 256/2*WIDHTSCALE);
    [self.view addSubview:tostimage];
    //提示的label
    tostLabel = [[UILabel alloc]init];
    tostLabel.frame = CGRectMake((WIDHT - 672/2 *WIDHTSCALE)/2, tostimage.frame.size.height + tostimage.frame.origin.y + 20*HEIGHTSCALE, 672/2 *WIDHTSCALE, 18*HEIGHTSCALE);
    tostLabel.text = @"您店铺还没创建过活动";
    tostLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
    tostLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    tostLabel.textAlignment = NSTextAlignmentCenter;
   
    [self.view addSubview:tostLabel];

    //创建活动按钮
    activitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    activitBtn.frame = CGRectMake((WIDHT - 280 *WIDHTSCALE)/2, tostLabel.frame.origin.y + tostLabel.frame.size.height + 40*HEIGHTSCALE, 280*WIDHTSCALE, 48*HEIGHTSCALE);
    [activitBtn setTitle:@"创建活动" forState:(UIControlStateNormal)];
    [activitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    activitBtn.titleLabel.font = [UIFont systemFontOfSize:18 *HEIGHTSCALE];
    activitBtn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
    activitBtn.layer.cornerRadius = 5.0;
    [activitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    activitBtn.clipsToBounds = YES;
    [self.view addSubview:activitBtn];
}
#pragma mark -- 创建活动的点击事件
-(void)clickBtn:(UIButton *)sender
{
    TCCreateActiveController *createVC = [[TCCreateActiveController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createVC animated:YES];
}
#pragma mark -- 添加活动按钮
-(void)rightBtn:(UIButton *)sender
{
    TCCreateActiveController *createVC = [[TCCreateActiveController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createVC animated:YES];
}
#pragma mark -- 结束活动
-(void)activeBtn:(UIButton *)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [preferenTable indexPathForCell:cell];
    
    //aid = preArr[path section][@"id"];
    NSLog(@"indexPath:--------%ld",(long)[path section]);
    NSLog(@"inde:%ld",path.section);
    aid = preArr[path.section][@"id"];
    NSLog(@"%@",aid);
    NSLog(@"结束活动");
    
    //背景色
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:_backView];
    //添加一个手势
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    [window addGestureRecognizer:tapgesture];
    //自定义的弹窗
    UIView *shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake((WIDHT - 560/2 *WIDHTSCALE)/2, (_backView.frame.size.height - 140*HEIGHTSCALE)/2, 560/2*WIDHTSCALE, 140*HEIGHTSCALE);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 5;
    shoperView.layer.borderWidth = 0.1;
    [_backView addSubview:shoperView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"确定结束此活动";
    label.frame = CGRectMake(0, 0, 560/2*WIDHTSCALE, (280 - 96)/2*HEIGHTSCALE);
    label.textColor = SmallTitleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    [shoperView addSubview:label];
    
    UIButton *btnCaule = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btnCaule setBackgroundImage:[UIImage imageNamed:@"取消按钮背景"] forState:(UIControlStateNormal)];
    [btnCaule addTarget:self action:@selector(btnCaule:) forControlEvents:(UIControlEventTouchUpInside)];
    [btnCaule setTitle:@"取消" forState:(UIControlStateNormal)];
    [btnCaule setTitleColor:[UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:(UIControlStateNormal)];
    btnCaule.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    btnCaule.frame = CGRectMake(0,(280 - 96)/2*HEIGHTSCALE , 280/2*WIDHTSCALE, 96/2*HEIGHTSCALE);
    [shoperView addSubview:btnCaule];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮背景"] forState:(UIControlStateNormal)];
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(sureBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    sureBtn.frame = CGRectMake(280/2*WIDHTSCALE,(280 - 96)/2*HEIGHTSCALE ,280/2*WIDHTSCALE, 96/2*HEIGHTSCALE);
    [shoperView addSubview:sureBtn];

}
#pragma mark -- changeBtn的点击事件
-(void)changeBtn:(UIButton *)sender
{
    TCCreateActiveController *changVC = [[TCCreateActiveController alloc]init];
    changVC.contentStr = preArr[sender.tag][@"content"];
    changVC.beginTimeStr = preArr[sender.tag][@"startTime"];
    changVC.finshTimeStr = preArr[sender.tag][@"endTime"];
    changVC.manMoneyStr = preArr[sender.tag][@"man"];
    changVC.cutMoneyStr = preArr[sender.tag][@"cut"];
    changVC.activeId = preArr[sender.tag][@"id"];
    changVC.ischange = YES;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 手势的处理时间
-(void)tapgesture
{
    [_backView removeFromSuperview];
}
#pragma mark -- 弹出框两个按钮的点击事件
-(void)btnCaule:(UIButton *)sender
{
    [_backView removeFromSuperview];
}

-(void)sureBtn:(UIButton *)sender
{
    

    [_backView removeFromSuperview];
    //请求数据
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"操作中..."];
    NSDictionary *parmer = @{@"aid":aid, @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]};
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200024"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        NSString *String = [NSString stringWithFormat:@"%@",dic[@"retValue"]];
        if([String isEqualToString:@"5"]){
             [self createQueste];
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
