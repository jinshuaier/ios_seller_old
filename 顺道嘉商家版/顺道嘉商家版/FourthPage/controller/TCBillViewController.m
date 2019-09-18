//
//  TCBillViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCBillViewController.h"
#import "TCBillTableViewCell.h"
#import "TCChooseSlideView.h"
#import "TCFailTableViewCell.h"
@interface TCBillViewController ()<TCChooseSlideProtocol,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *rightButton;
    CGFloat hight;
    NSInteger tagStr;
    UILabel *line;
    UIView *billView;
    UILabel *reasonLabel;
}

@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UIBarButtonItem *right;
@property (nonatomic, strong) UITableView *billTable;
@property (nonatomic, strong) NSMutableArray *billArr;
@property(copy, nonatomic) NSMutableString *currentSectionStr;
@property(strong,nonatomic)TCChooseSlideView *sliderView;
@end

@implementation TCBillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单记录";
    
    _userdefaults = [NSUserDefaults standardUserDefaults];
    _billArr = [[NSMutableArray alloc]init];

    self.view.backgroundColor = backGgray;
    
    [self creatHeaderView];
    

    
    //创建tableView
    [self createBillTabel];
    

    // Do any additional setup after loading the view.
}

-(void)creatHeaderView
{
    
//    //创建并初始化,添加到视图
//    self.sliderView = [[TCChooseSlideView alloc]init];
//    self.sliderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50*HEIGHTSCALE);
//    self.sliderView.backgroundColor = [UIColor whiteColor];
//    self.sliderView.tag = 200 ;
//    [self.view addSubview:self.sliderView];    //设置菜品名数组
//    self.sliderView.sliderDelegate = self;
//    NSArray *menuArray = [NSArray arrayWithObjects:@"提现账单",@"奖金账单",@"充值账单", nil];
//    [self.sliderView  setNameWithArray:menuArray];
    
    
    
}
#pragma mark -- 滚动视图的实现
//实现协议方法;
//-(void)_getTag:(NSInteger)tag
//{
//   
//    //if (tag == 0) {
//       [self setupRefresh:@"2"];
////    }
////        tagStr = 100;
////    }else if (tag == 1) {
////       [self setupRefresh:@"4"];
////        tagStr = 200;
////    }else if (tag == 2) {
////        [self setupRefresh:@"3"];
////        tagStr = 300;
////    }
//}



#pragma mark -- 创建tableView
-(void)createBillTabel
{
    _billTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _billTable.delegate = self;
    _billTable.dataSource = self;
    [self.view addSubview: _billTable];
    
    //添加刷新
    [self setupRefresh];

    
//    [self _getTag:0];
}
//添加刷新控件
- (void)setupRefresh{
   
    __block int  page = 1;
     self.view.userInteractionEnabled = NO;
    //下拉
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
    _billTable.mj_header = header;
    _billTable.mj_footer = footer;
    [header beginRefreshing];
    
}

//下拉请求
- (void)request{
  
    [_billArr removeAllObjects];
    
    NSDictionary *dic = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"pageNum":@"1", @"numPerPage":@"10"};
    NSLog(@"您现在请求：%@",dic);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"710001"] parameters:dic success:^(id responseObject) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if (dic[@"data"]) {
            [_billArr addObjectsFromArray:dic[@"data"][@"orderList"]];
        }
        [_billTable reloadData];
        [_billTable.mj_header endRefreshing];
        self.view.userInteractionEnabled = YES;
        
    } failure:^(NSError *error) {
        nil;
    }];
    [_billTable.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestUp:(int)page{
    NSDictionary *dic = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"pageNum":@(page), @"numPerPage":@"10"};
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"710001"] parameters:dic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       
        if (dic[@"data"]) {
            [_billArr addObjectsFromArray:dic[@"data"][@"orderList"]];
            [_billTable reloadData];
            [_billTable.mj_footer endRefreshing];
        }else{
            [_billTable.mj_footer endRefreshing];
            [_billTable.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
     [_billTable registerNib:[UINib nibWithNibName:@"TCBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    // [_billTable registerNib:[UINib nibWithNibName:@"TCFailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
//    TCFailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    TCBillTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if(tagStr == 100){
//        if(self.billArr.count != 0){
//            if(![_billArr[indexPath.section][@"noReason"] isEqualToString:@""]){
//                cell.titleLabel.text = @"提现";
//                cell.timeLabel.text = _billArr[indexPath.section][@"createTime"];
//                cell.pricelabel.text = [NSString stringWithFormat:@"¥ %@", _billArr[indexPath.section][@"money"]];
//                cell.stateLabel.text =  _billArr[indexPath.section][@"status__name"];
//                cell.resonLabel.text = _billArr[indexPath.section][@"noReason"];
//            
//                CGFloat titleSize = [cell.resonLabel.text boundingRectWithSize:CGSizeMake(WIDHT/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//                cell.resonLabel.frame = CGRectMake(16, 8, WIDHT - 16 - 60 - 12 - 32, titleSize);
//                cell.resonView.frame = CGRectMake(cell.failLabel.frame.origin.x + cell.failLabel.frame.size.width + 8, cell.timeLabel.frame.origin.y + cell.timeLabel.frame.size.height + 25, WIDHT - 16 - 60 - 12, cell.resonLabel.frame.size.height + 16);
//            
//                hight = cell.resonView.frame.origin.y + cell.resonView.frame.size.height + 20;
//                return cell;
//            }else{
                cells.titleLabel.text = _billArr[indexPath.section][@"type_name"];
                cells.timeLabel.text = _billArr[indexPath.section][@"completeTime"];
                cells.titleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
                cells.timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
                cells.priceLabel.text = [NSString stringWithFormat:@"%@", _billArr[indexPath.section][@"money"]];
                cells.priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1.0];
                cells.stateLabel.text =  _billArr[indexPath.section][@"status__name"];
                cells.stateLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//                return cells;
//            }
//        }else{
//            NSLog(@"很抱歉");
//        }
//    }else if (tagStr == 200){
//        cells.titleLabel.text = @"奖金";
//        if(_billArr.count == 0){
//            NSLog(@"jj");
//        }else{
//            cells.timeLabel.text = _billArr[indexPath.section][@"createTime"];
//            cells.titleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//            cells.timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//            cells.priceLabel.text = [NSString stringWithFormat:@"¥ %@", _billArr[indexPath.section][@"money"]];
//            cells.priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1.0];
//            cells.stateLabel.text =  _billArr[indexPath.section][@"status__name"];
//            cells.stateLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//        return cells;
//        }
//    }else if (tagStr == 300){
//        cells.titleLabel.text = @"充值";
//        if(_billArr.count == 0){
//            NSLog(@"jj");
//        }else{
//        cells.timeLabel.text = _billArr[indexPath.section][@"createTime"];
//        cells.titleLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//        cells.timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//        cells.priceLabel.text = [NSString stringWithFormat:@"¥ %@", _billArr[indexPath.section][@"money"]];
//        cells.priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1.0];
//        cells.stateLabel.text =  _billArr[indexPath.section][@"status__name"];
//        cells.stateLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
       // return cells;
//        }
//    }

    

    return  cells;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    }
        
        


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _billArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 12;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tagStr == 100){
    if(_billArr.count != 0){
    if(![_billArr[indexPath.section][@"noReason"] isEqualToString:@""]){
        return hight;
    }
    }else{
        NSLog(@"对不起");
    }
    }
    return 68;
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
