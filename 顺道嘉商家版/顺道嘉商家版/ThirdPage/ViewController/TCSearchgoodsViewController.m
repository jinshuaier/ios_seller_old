//
//  TCSearchgoodsViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/5/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSearchgoodsViewController.h"
#import "TCSearchGoodsModel.h"
#import "TCSearchgoodsTableViewCell.h"
#import "TCAddGoodsViewController.h"

@interface TCSearchgoodsViewController ()
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView *backSearchView; //搜索框
    UIButton *searchBtn; //搜索的按钮
    UIButton *BackBtn; //返回按钮
    
    UIImageView *placeholderImage; //占位图  。。。。 能runtime
    UILabel *placeholderLabel_one;
    UILabel *placeholderLabel_two;
    
    UIImageView *im1;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UITableView *shopGoodTabelView;
@property (nonatomic, strong) UIButton *lastButton; //最后的btn
@property (nonatomic, strong) UIView *lineView; //线

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *line2; //底部的线
@property (nonatomic, strong) UILabel *numlb;
@property (nonatomic, strong) UIButton *jisuan;
@property (nonatomic, strong) UILabel *allPrice;
@property (nonatomic, strong) NSMutableArray *sqlMuArr;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) NSMutableArray *shopMuArr;
@property (nonatomic, strong) UIView *noMesView;
@property (nonatomic, strong) NSDictionary *dic_mess;
@end

@implementation TCSearchgoodsViewController


//隐藏导航栏
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
   
    _shopMuArr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    //创建navView
    [self createNav];
    
    //占位图
    [self createNoGoods];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
//创建nav
- (void)createNav{
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, WIDHT, StatusBarAndNavigationBarHeight);
    navView.backgroundColor = TCNavColor;
    [self.view addSubview:navView];
    
    //返回按钮
    BackBtn = [[UIButton alloc] init];
    BackBtn.frame = CGRectMake(12, StatusBarHeight + 10, 24, 24);
    [BackBtn setImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
    [BackBtn addTarget:self action:@selector(backBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:BackBtn];
    
    //搜索view
    backSearchView = [[UIView alloc] init];
    backSearchView.frame = CGRectMake(CGRectGetMaxX(BackBtn.frame) + 12, StatusBarHeight + 6, WIDHT - (CGRectGetMaxX(BackBtn.frame) + 12) - 14, 32);
    backSearchView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    [navView addSubview:backSearchView];
    
    //搜索的按钮
    searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    searchBtn.frame = CGRectMake(WIDHT - 15 - 30, StatusBarHeight + 6, 30, 32);
    [searchBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
    [searchBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    searchBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    searchBtn.hidden = YES;
    [searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:searchBtn];
    
    //搜索icon
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"搜索放大镜"];
    searchIcon.frame = CGRectMake(12, 8, 16, 15.5);
    [backSearchView addSubview:searchIcon];
    
    //搜索框
    self.searchField = [[UITextField alloc] init];
    self.searchField.frame = CGRectMake(CGRectGetMaxX(searchIcon.frame) + 8, 6, backSearchView.frame.size.width - 36 - 12 - 30, 21);
    self.searchField.clearButtonMode = UITextFieldViewModeAlways;
    self.searchField.delegate = self;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.placeholder = @"输入您要的商品名称";
    [self.searchField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [self.searchField setValue:TCUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchField setValue:[UIFont fontWithName:@"PingFangSC-Regular" size:13] forKeyPath:@"_placeholderLabel.font"];
    self.searchField.textColor = TCUIColorFromRGB(0x333333);
    self.searchField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [backSearchView addSubview:self.searchField];
    
    //一条细线
    UIView *lineNavcView = [[UIView alloc] init];
    lineNavcView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight - 1, WIDHT, 1);
    lineNavcView.backgroundColor = TCBgColor;
    [navView addSubview:lineNavcView];
    
    //创建tableView
    self.shopGoodTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, WIDHT, HEIGHT - 50 - StatusBarAndNavigationBarHeight - TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
    self.shopGoodTabelView.delegate = self;
    self.shopGoodTabelView.dataSource = self;
    self.shopGoodTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopGoodTabelView.hidden = YES;
    self.shopGoodTabelView.backgroundColor = TCBgColor;
    [self.view addSubview: self.shopGoodTabelView];
}

//占位图
- (void)createNoGoods
{
    //没有搜索商品的图
    placeholderImage = [[UIImageView alloc] init];
    placeholderImage.image = [UIImage imageNamed:@"搜索无果缺省页"];
    placeholderImage.frame = CGRectMake((WIDHT - 120)/2, (HEIGHT - StatusBarAndNavigationBarHeight - 120)/2, 120, 120);
    placeholderImage.hidden = YES;
    [self.view addSubview:placeholderImage];
    
    placeholderLabel_one = [UILabel publicLab:@"没有搜索结果" textColor:TCUIColorFromRGB(0x999999) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:16 numberOfLines:0];
    placeholderLabel_one.frame = CGRectMake(0, CGRectGetMaxY(placeholderImage.frame) + 14, WIDHT, 22);
    placeholderLabel_one.hidden = YES;
    [self.view addSubview:placeholderLabel_one];
    
    placeholderLabel_two = [UILabel publicLab:@"换个关键词试试" textColor:TCUIColorFromRGB(0x999999) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:13 numberOfLines:0];
    placeholderLabel_two.frame = CGRectMake(0, CGRectGetMaxY(placeholderLabel_one.frame) + 4, WIDHT, 18);
    placeholderLabel_two.hidden = YES;
    [self.view addSubview:placeholderLabel_two];
}

#pragma mark -- 加载获取的数据
//添加刷新
- (void)setupRefresh:(NSString *)searchType{
    //下拉
    __block int  page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self requestShops:searchType];
        
    }];
    //设置刷新标题
    [header setTitle:@"下拉刷新顺道嘉商品..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新顺道嘉商品..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新顺道嘉商品..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    
    self.shopGoodTabelView.mj_header = header;
    [header beginRefreshing];
    
    //上拉
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self requestShops:page andType:searchType];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉商品" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉商品..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉商品!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.shopGoodTabelView.mj_footer = footer;
}


//下拉请求
- (void)requestShops:(NSString *)searchType{
    
    [_shopMuArr removeAllObjects];
     NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"name":searchType,@"page":@"1"};
    NSString *singStr = [TCServerSecret loginStr:dic];

    NSDictionary *paramters = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"name":searchType,@"page":@"1",@"sign":singStr};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201038"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@,%@",jsonDic,jsonStr);
        NSArray *arr = jsonDic[@"data"];

        if (arr.count > 0){
            //获取数据
            for (NSDictionary *dic in arr) {
                TCSearchGoodsModel *goodModel = [TCSearchGoodsModel searchInfoWithDictionary:dic];
                [_shopMuArr addObject:goodModel];
            }
            placeholderImage.hidden = YES;
            placeholderLabel_two.hidden = YES;
            placeholderLabel_one.hidden = YES;
            self.shopGoodTabelView.hidden = NO;
        } else {
            placeholderImage.hidden = NO;
            placeholderLabel_two.hidden = NO;
            placeholderLabel_one.hidden = NO;
        }
        [self.shopGoodTabelView.mj_header endRefreshing];
        [self.shopGoodTabelView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
    [self.shopGoodTabelView.mj_footer resetNoMoreData];
}

//上拉加载
- (void)requestShops:(int)page andType:(NSString *)searchType{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"page":pageStr,@"timestamp":Timestr,@"shopid":shopID,@"name":searchType,@"keyword":searchType,@"mid":midStr,@"token":tokenStr};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"page":pageStr,@"timestamp":Timestr,@"shopid":shopID,@"name":searchType,@"keyword":searchType,@"mid":midStr,@"token":tokenStr,@"sign":signStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201038"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@,%@",jsonDic,jsonStr);
        if (jsonDic[@"data"]) {
           
            //获取数据
            NSArray *arr = jsonDic[@"data"];
            for (NSDictionary *dic in arr) {
                TCSearchGoodsModel *goodModel = [TCSearchGoodsModel searchInfoWithDictionary:dic];
                [_shopMuArr addObject:goodModel];
            }
            [_shopGoodTabelView.mj_footer endRefreshing];
            [_shopGoodTabelView reloadData];
        }else{
            [_shopGoodTabelView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
    [self.shopGoodTabelView.mj_footer resetNoMoreData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.shopMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 8;
    } else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCSearchgoodsTableViewCell *cell = [[TCSearchgoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (_shopMuArr.count == 0) {
        NSLog(@"无");
    }else{
        TCSearchGoodsModel *goodsmodel = _shopMuArr[indexPath.section];
        cell.goodsModel = goodsmodel;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCSearchGoodsModel *model = _shopMuArr[indexPath.section];
    NSString *goodsid = model.goodsid;
    [self creatRequestGoodsDetails:goodsid AndModle:model];
}


//请求选中的商品详情
-(void)creatRequestGoodsDetails:(NSString *)goodsId AndModle:(TCSearchGoodsModel *)model{
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"goodsid":goodsId};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"goodsid":goodsId,@"sign":singStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"204002"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            NSString *barcode = jsonDic[@"data"][@"barcode"];
            NSString *description = jsonDic[@"data"][@"description"];
            NSString *goodscateid = jsonDic[@"data"][@"goodscateid"];
            NSString *goodscatename = jsonDic[@"data"][@"goodscatename"];
            NSString *name = jsonDic[@"data"][@"name"];
            NSArray  *images = jsonDic[@"data"][@"images"];
            NSArray  *speclists = jsonDic[@"data"][@"specList"];
            //创建
            NSMutableDictionary *seleDic = [NSMutableDictionary dictionary];
            
            //添加字典
            [seleDic setObject:goodsId forKey:@"goodsid"];
            [seleDic setObject:barcode forKey:@"barcode"];
            [seleDic setObject:description forKey:@"description"];
            [seleDic setObject:goodscateid forKey:@"goodscateid"];
            [seleDic setObject:goodscatename forKey:@"goodscatename"];
            [seleDic setObject:name forKey:@"name"];
            [seleDic setValue:images forKey:@"images"];
            [seleDic setValue:speclists forKey:@"speclists"];
            TCAddGoodsViewController *addgoodsVC = [[TCAddGoodsViewController alloc]init];
            addgoodsVC.seleDic = seleDic;
            addgoodsVC.isSearch = YES;
            addgoodsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addgoodsVC animated:YES];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}



- (void)presentVCFirstBackClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToSearchResultWithSearchStr:(NSString *)str
{
    [self.searchField resignFirstResponder];
    self.searchField.text = str;
    self.shopGoodTabelView.hidden = NO;
    
    [self setupRefresh:str];
}



#pragma mark - UISearchBarDelegate -
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self pushToSearchResultWithSearchStr:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


//监听文本框刚开始的变化
-(void)valueChanged:(UITextField *)textField{
    
    //textfield的协议
    if (textField.text.length != 0) {
        backSearchView.frame = CGRectMake(CGRectGetMaxX(BackBtn.frame) + 12, StatusBarHeight + 6, WIDHT - (CGRectGetMaxX(BackBtn.frame) + 12) - 55 , 32);
        searchBtn.hidden = NO;
        
    } else {
        backSearchView.frame = CGRectMake(CGRectGetMaxX(BackBtn.frame) + 12, StatusBarHeight + 6, WIDHT - (CGRectGetMaxX(BackBtn.frame) + 12) - 14, 32);
        searchBtn.hidden = YES;
        placeholderImage.hidden = YES;
        placeholderLabel_two.hidden = YES;
        placeholderLabel_one.hidden = YES;
        self.shopGoodTabelView.hidden = YES;
    }
}

#pragma mark -- 搜索的点击事件
- (void)searchBtn:(UIButton *)sender
{
    if (self.searchField.text.length != 0){
        [self.searchField resignFirstResponder];
        self.shopGoodTabelView.hidden = NO;
        //请求搜索商品的接口
        [self setupRefresh:self.searchField.text];
        
    } else {
        [TCProgressHUD showMessage:@"输入您要的商品名称"];
    }
}

//点击搜索键盘的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //发送请求
    if (self.searchField.text.length != 0){
        [textField resignFirstResponder];
        self.shopGoodTabelView.hidden = NO;
        [self setupRefresh:textField.text];
    } else {
        [TCProgressHUD showMessage:@"输入您要的商品名称"];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchField resignFirstResponder];
}

#pragma mark -- 点击空白处下落
- (void)shopcarTap
{
    [_backView removeFromSuperview];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"123");
}

- (void)relo{
    [_shopGoodTabelView reloadData];
}

#pragma mark -- 返回按钮
- (void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
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
