//
//  TCPreferentialController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCPreferentialController.h"
#import "TCPreferentialCell.h"
@interface TCPreferentialController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *preferenTable;
    NSMutableArray *preArr; // 可变数组
    NSString *idStr;//活动的id
    NSArray *disTitle;
    NSString *aid;
    NSString *timeStr;
    NSString *contentStr;
    UIImageView *tostimage; //提示的图片
    UILabel *tostLabel; //提示的文字
}
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCPreferentialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠活动";
     _userdefault = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = ViewColor;
    preArr = [[NSMutableArray alloc]init];
    [self createActiveView];
    //创建tableView
     [self createTable];
    
     [self setupRefresh];
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
    [preArr removeAllObjects];
    NSDictionary *parmer = @{@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"pageNum":@"1",@"numPerPage":@"15"};
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200022"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if(dic[@"data"]){
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            [preArr addObjectsFromArray: dic[@"data"]];
            [preferenTable reloadData];
            [preferenTable.mj_header endRefreshing];
             preferenTable.userInteractionEnabled = YES;
            
        }else{
             [preferenTable.mj_header endRefreshing];
            
        }
        
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
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200022"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        [preferenTable.mj_footer resetNoMoreData];
        if (dic[@"data"]) {
            tostimage.hidden = YES;
            tostLabel.hidden = YES;
            preArr = dic[@"data"];
            [preferenTable.mj_footer endRefreshing];
        }else{
            tostimage.hidden = NO;
            tostLabel.hidden = NO;
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
    [self.view addSubview: preferenTable];
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
    tostLabel.text = @"还没有优惠活动";
    tostLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
    tostLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    tostLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:tostLabel];
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
        NSLog(@"不知道干嘛啊");
    }else{
    cell.imageHead.hidden = YES;
    cell.activeName.text = preArr[indexPath.section][@"content"];
    cell.activeName.textColor = shopColor;
    cell.activeTime.text = [NSString stringWithFormat:@"时间:%@天",preArr[indexPath.section][@"lifetime"]];
    cell.activeTime.textColor = RedColor;
    if(!preArr[indexPath.section][@"startTime"]){
       cell.beginTime.text = [NSString stringWithFormat:@"开始时间:%@", @"00:00:00"];
    }else{
    cell.beginTime.text = [NSString stringWithFormat:@"结束时间:%@", preArr[indexPath.section][@"startTime"]];
    }
    cell.beginTime.textColor = SmallTitleColor;
    
    if(!preArr[indexPath.section][@"endTime"]){
       cell.finshTime.text = [NSString stringWithFormat:@"开始时间:%@", @"00:00:00"];
    }else{
    cell.finshTime.text = [NSString stringWithFormat:@"结束时间:%@", preArr[indexPath.section][@"endTime"]];
    }
    cell.finshTime.textColor = SmallTitleColor;
    
    //判断是否参加活动
    /**** 0代表未参加活动   1代表参加活动 *****/
    
    cell.activeBtn.layer.cornerRadius = 2;
    cell.activeBtn.clipsToBounds = YES;
    [cell.activeBtn addTarget:self action:@selector(activeBtn:)
             forControlEvents:(UIControlEventTouchUpInside)];
    if([preArr[indexPath.section][@"inner"] isEqualToString:@"0"]){
        cell.activeBtn.backgroundColor = ColorLine;
        cell.activeBtn.userInteractionEnabled = NO;
    }else{
        cell.activeBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        cell.activeBtn.userInteractionEnabled = YES;
    }
    [cell.activeBtn setTitle:@"结束活动" forState:(UIControlStateNormal)];
    cell.activeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.activeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
   
    
    [cell.changBtn addTarget:self action:@selector(changeBtn:) forControlEvents:(UIControlEventTouchUpInside)];

    if([preArr[indexPath.section][@"inner"] isEqualToString:@"0"]){
        cell.changBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        cell.changBtn.userInteractionEnabled = YES;
        [cell.changBtn setTitle:@"立即参与" forState:(UIControlStateNormal)];
    }else{
        cell.changBtn.backgroundColor = ColorLine;
        [cell.changBtn setTitle:@"正在参与" forState:(UIControlStateNormal)];
        cell.changBtn.userInteractionEnabled = NO;
    }
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
#pragma mark -- 立即参与的按钮点击事件
-(void)changeBtn:(UIButton *)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [preferenTable indexPathForCell:cell];
    
    NSLog(@"indexPath:--------%ld",(long)[path section]);
    NSLog(@"inde:%ld",path.section);
    idStr = preArr[path.section][@"id"];
    timeStr = [NSString stringWithFormat:@"%@天", preArr[path.section][@"lifetime"]];
    contentStr = preArr[path.section][@"content"];
    
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
    shoperView.frame = CGRectMake((WIDHT - 672/2 *WIDHTSCALE)/2, (_backView.frame.size.height - 142*HEIGHTSCALE)/2, 672/2*WIDHTSCALE, 142*HEIGHTSCALE);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 5;
    shoperView.layer.borderWidth = 0.1;
    [_backView addSubview:shoperView];
    
    
    //创建弹窗里面的内容
    NSArray *activeTitle = @[@"活动名称:",@"活动时长:"];
    disTitle = @[contentStr,timeStr];
    
    for (int i = 0; i < 2; i ++) {
        UILabel *activeTitleLabel = [[UILabel alloc]init];
        activeTitleLabel.frame = CGRectMake(0,  24*HEIGHTSCALE + 31*HEIGHTSCALE *i , 140*WIDHTSCALE, 15*HEIGHTSCALE);
        activeTitleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
        activeTitleLabel.tag = 100 + i;
        activeTitleLabel.text = activeTitle[i];
        activeTitleLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
        activeTitleLabel.textAlignment = NSTextAlignmentRight;
        [shoperView addSubview:activeTitleLabel];
        
        UILabel *disTitleLabel = [[UILabel alloc]init];
        disTitleLabel.frame = CGRectMake(activeTitleLabel.frame.origin.x + activeTitleLabel.frame.size.width + 10*WIDHTSCALE, 24 *HEIGHTSCALE + 31*HEIGHTSCALE *i , WIDHT - 140*WIDHTSCALE, 15*HEIGHTSCALE);
        
        disTitleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
        disTitleLabel.text = disTitle[i];
        disTitleLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
        disTitleLabel.textAlignment = NSTextAlignmentLeft;
        [shoperView addSubview:disTitleLabel];
        
        if(i == 1){
            
            //添加button
            UIButton *notPartakeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            notPartakeBtn.frame = CGRectMake(0, disTitleLabel.frame.origin.y + disTitleLabel.frame.size.height + 24*HEIGHTSCALE, 672/2/2*WIDHTSCALE, 48*HEIGHTSCALE);
            [notPartakeBtn setBackgroundImage:[UIImage imageNamed:@"不参与"] forState:(UIControlStateNormal)];
            [notPartakeBtn addTarget:self action:@selector(notBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [notPartakeBtn setBackgroundImage:[UIImage imageNamed:@"不参与（点击)"] forState:UIControlStateHighlighted];
            [shoperView addSubview:notPartakeBtn];
        
            //添加button
            UIButton *partakeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            partakeBtn.frame = CGRectMake(672/2/2*WIDHTSCALE, disTitleLabel.frame.origin.y + disTitleLabel.frame.size.height + 24*HEIGHTSCALE, 672/2/2*WIDHTSCALE, 48*HEIGHTSCALE);
            [partakeBtn setBackgroundImage:[UIImage imageNamed:@"确定(未点)"] forState:(UIControlStateNormal)];
            [partakeBtn addTarget:self action:@selector(partakeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [partakeBtn setBackgroundImage:[UIImage imageNamed:@"确定（点击)"] forState:UIControlStateHighlighted];
            [shoperView addSubview:partakeBtn];
            
        }
    }
    
    
}

#pragma mark -- 结束活动
-(void)activeBtn:(UIButton *)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [preferenTable indexPathForCell:cell];
    
    //aid = preArr[path section][@"id"];
    NSLog(@"indexPath:--------%ld",(long)[path section]);
    NSLog(@"inde:%ld",path.section);
    aid = preArr[path.section][@"aid"];
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
            
            [self setupRefresh];
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];

        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}
-(void)btnCaule:(UIButton *)sender
{
    [_backView removeFromSuperview];
}
#pragma mark -- 按钮的点击事件
-(void)notBtn:(UIButton *)sender
{
    NSLog(@"不参与");
    [_backView removeFromSuperview];
}
-(void)partakeBtn:(UIButton *)sender
{
    
    NSLog(@"参与的%@",idStr);
    [_backView removeFromSuperview];
    //正在参与的接口
    [self createJoinquest];
}
#pragma mark -- 正在参与的接口
-(void)createJoinquest
{
    //请求数据
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"操作中..."];
    NSDictionary *parmer = @{@"said":idStr,@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]};
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200020"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        NSString *String = [NSString stringWithFormat:@"%@",dic[@"retValue"]];
        if([String isEqualToString:@"1"]){
            
            [self setupRefresh];
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
      
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}


#pragma mark -- 手势的处理时间
-(void)tapgesture
{
    [_backView removeFromSuperview];
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
