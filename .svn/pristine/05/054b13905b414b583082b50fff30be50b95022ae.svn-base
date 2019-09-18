//
//  TCSeachShopViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSeachShopViewController.h"
#import "TCChooseSlideView.h"
#import "TCQrcodeViewController.h"
#import "TCShopEditViewController.h"
#import "TCShopsTableViewCell.h"

#import "TCProgressHUD.h"
#define DefineWeakSelf __weak __typeof(self) weakSelf = self
@interface TCSeachShopViewController ()<TCChooseSlideProtocol,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIImageView *seacrchImage; // 放大镜的图片
    UILabel *inquireLabel; //查询订单的文字
    UIView *backView; // 背景颜色
    NSMutableArray *addArr;
    UITableView *shopNameTableView;
    NSMutableArray *shopNameArr; //此处为装电话号码的数组  默认为5个
    NSString *shopNameStr; // 记录查询号码的值
    NSUserDefaults *userdefault;
    UITableView *searchTableview; //搜索订单的tableView
    NSMutableArray *searchArr; //搜索结果的数组
    NSInteger tagStr;
    NSMutableAttributedString *noteStr;
    UIButton *codeBtn ;
    UIButton *addBtn ;
    UIButton *addShop;
    UIImageView *seacrImage;
    UILabel *inquLabel;
    UILabel *disLabel;
}
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *titleView;//标题和分类按钮的底部view
@property (nonatomic, strong) UIView *titleView2;//标题按钮view
@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) UIImageView *line2;
@property (nonatomic, strong) UIImageView *line3;

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIButton *selectBtn;//标题用
@property (nonatomic, strong) UIButton *selectBtn2;//分类用
@property(strong,nonatomic)TCChooseSlideView *sliderView;
@property (nonatomic, strong) NSMutableArray *xiajiaMuArr;//用来保存下架勾选的商品

@property (nonatomic, strong) NSString *textfield; //刷新的textfiled
@end

@implementation TCSeachShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏的左边箭头为白色
    [self.navigationItem setHidesBackButton:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    userdefault = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = ViewColor;
    shopNameArr = [[NSMutableArray alloc]init]; //初始化电话数组
    searchArr = [[NSMutableArray alloc]init]; //初始化搜索结果数组
    _xiajiaMuArr = [[NSMutableArray alloc]init];
    addArr = [[NSMutableArray alloc]init];
    
    //创建并初始化,添加到视图
    self.sliderView = [[TCChooseSlideView alloc]init];
    self.sliderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50*HEIGHTSCALE);
    self.sliderView.backgroundColor = [UIColor whiteColor];
    self.sliderView.tag = 200 ;
    if(![[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        [self.view addSubview:self.sliderView];    //设置菜品名数组
    }
    self.sliderView.sliderDelegate = self;
    NSArray *menuArray = [NSArray arrayWithObjects:@"商家库",@"顺道嘉库", nil];
    [self.sliderView  setNameWithArray:menuArray];
    [self _getTag:0];
    
    //创建搜索tableView
    if(tagStr == 100){
        searchTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 50*HEIGHTSCALE, WIDHT, HEIGHT -  46 - 50*HEIGHTSCALE - 10 - 48*HEIGHTSCALE) style:UITableViewStyleGrouped];
    }
    if(tagStr == 200){
        searchTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 50*HEIGHTSCALE, WIDHT, HEIGHT -  46 - 50*HEIGHTSCALE - 10) style:UITableViewStyleGrouped];
    }
    if([[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        searchTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT -  46 - 10 - 48*HEIGHTSCALE) style:UITableViewStyleGrouped];
    }
    //创建搜索tableview
    searchTableview.delegate = self;
    searchTableview.dataSource = self;
    searchTableview.rowHeight = 167;
    searchTableview.tableFooterView = [[UIView alloc]init];
    searchTableview.hidden = YES;
    [self.view addSubview:searchTableview];
    
    //创建商品名字
    shopNameTableView = [[UITableView alloc] initWithFrame:CGRectMake(18, 0, WIDHT - 80, 30 * shopNameArr.count) style:UITableViewStylePlain];
    shopNameTableView.delegate = self;
    shopNameTableView.dataSource = self;
    shopNameTableView.scrollEnabled = NO;
    shopNameTableView.showsVerticalScrollIndicator = NO;
    shopNameTableView.rowHeight = 30;
    shopNameTableView.tableFooterView = [[UIView alloc]init];
    shopNameTableView.hidden = YES;
    [self.view addSubview:shopNameTableView];
    
    if ([[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
        _isShow = YES;
    }
}

//实现协议方法;
-(void)_getTag:(NSInteger)tag
{
    [seacrchImage removeFromSuperview];
    [inquireLabel removeFromSuperview];
    [self createResultView];
//    searchView.YYSearch.text = @"";
//    searchView.YYSearch.placeholder = @"输入商品名称";
    [searchArr removeAllObjects];
    [searchTableview reloadData];
    [codeBtn removeFromSuperview];
    [addBtn removeFromSuperview];
    [addShop removeFromSuperview];
    [seacrImage removeFromSuperview];
    [inquLabel removeFromSuperview];
    [disLabel removeFromSuperview];
    if (tag == 0) {
        tagStr = 100;
    }else if (tag == 1) {
        tagStr = 200;
        [codeBtn removeFromSuperview];
        [addBtn removeFromSuperview];
    }
}
#pragma mark -- 搜索结果的view
-(void)createResultView{
    seacrchImage = [[UIImageView alloc]init];
    seacrchImage.image = [UIImage imageNamed:@"garySearch"];
    seacrchImage.frame = CGRectMake((WIDHT - 50 )/2, (HEIGHT - 50 )/2 - 64 , 70, 70);
    inquireLabel = [[UILabel alloc]init];
    inquireLabel.frame = CGRectMake((WIDHT - 150 )/2, (HEIGHT - 50 )/2 + 22 + 70 - 64  , 170, 20);
    inquireLabel.text = @"搜索商品";
    inquireLabel.font = [UIFont systemFontOfSize:21];
    inquireLabel.textAlignment = NSTextAlignmentCenter;
    inquireLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self.view addSubview:seacrchImage];
    [self.view addSubview:inquireLabel];
}


//监听文本框刚开始的变化
-(void)valueChanged:(UITextField *)textField{
    if(textField.text.length > 0){
        
        
        if(tagStr == 100 || [[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            //发送请求商品库
            [self createShopQuest:textField.text];
        }else if (tagStr == 200){
            //顺道嘉库
            [self createSdjQuest:textField.text];
            self.textfield = textField.text;
            
        }
    }
}

#pragma mark -- 商品库的搜索
-(void)createShopQuest:(NSString *)str{
    [shopNameArr removeAllObjects];
    NSDictionary *dic = @{@"key":str,@"token":[userdefault valueForKey:@"userToken"],@"id":[userdefault valueForKey:@"userID"],@"shopid":self.shopID};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300113"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if(dic[@"data"]){
            [shopNameArr addObjectsFromArray: dic[@"data"]];
            shopNameTableView.hidden = NO;
            shopNameTableView.frame = CGRectMake(18, 0, WIDHT - 80, 30 * shopNameArr.count);
            [shopNameTableView reloadData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark -- 顺道嘉库的搜索
-(void)createSdjQuest:(NSString *)str{
    [shopNameArr removeAllObjects];
    NSDictionary *dic = @{@"key":str,@"token":[userdefault valueForKey:@"userToken"],@"id":[userdefault valueForKey:@"userID"],@"shopid":self.shopID};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300114"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if(dic[@"data"]){
            [shopNameArr addObjectsFromArray: dic[@"data"]];
            shopNameArr = dic[@"data"];
            shopNameTableView.hidden = NO;
            shopNameTableView.frame = CGRectMake(18, 0, WIDHT - 80, 30 * shopNameArr.count);
            [shopNameTableView reloadData];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//点击搜索键盘的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType==UIReturnKeySearch){
        if([textField.text isEqualToString:@""] && [textField.placeholder isEqualToString:@"输入商品名称"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂时还未搜索商品" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确定");
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            searchTableview.hidden = NO;
            //请求搜索过来的接口
            [self setupRefresh:textField.text];
            
    }
  }
    return YES;
}

#pragma mark -- 添加刷新页面
-(void)setupRefresh:(NSString *)text{
    __block int  page = 1;
    self.view.userInteractionEnabled = NO;
    
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        //发送请求
        [self createShopLib:text];
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
        [self createShopLib:page addtext:text];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    //加入tableview中
    searchTableview.mj_header = header;
    searchTableview.mj_footer = footer;
    [header beginRefreshing];
}

//搜索到的tableView
-(void)createShopLib:(NSString *)text{
    //添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [codeBtn removeFromSuperview];
    [addBtn removeFromSuperview];
    [addShop removeFromSuperview];
    shopNameTableView.hidden = YES;
    [searchArr removeAllObjects];
    //商家库
    if(tagStr == 100 || [[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300111"] paramter:@{@"id":[userdefault valueForKey:@"userID"], @"token":[userdefault valueForKey:@"userToken"],@"key":text,@"shopid":_shopID,@"page":@"1"} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            if (jsonDic[@"data"]) {
                [searchArr addObjectsFromArray:jsonDic[@"data"]];
                [searchTableview.mj_header endRefreshing];
                [seacrchImage removeFromSuperview];
                [inquireLabel removeFromSuperview];
                [addShop removeFromSuperview];
                [seacrImage removeFromSuperview];
                [inquLabel removeFromSuperview];
                [disLabel removeFromSuperview];
                //创建底部两个按钮
                [self createBtn];
            }else{
                [seacrchImage removeFromSuperview];
                [inquireLabel removeFromSuperview];
                [searchArr removeAllObjects];
                [searchTableview reloadData];
                [codeBtn removeFromSuperview];
                [addBtn removeFromSuperview];
                [addShop removeFromSuperview];
                [seacrImage removeFromSuperview];
                [inquLabel removeFromSuperview];
                [disLabel removeFromSuperview];
                //提示的view
                [self toilView:text];
                [searchTableview.mj_header endRefreshing];
            }
            shopNameTableView.hidden = YES;
            [searchTableview reloadData];
            self.view.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            nil;
        }];
    }else if (tagStr == 200){
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300112"] paramter:@{@"id":[userdefault valueForKey:@"userID"], @"token":[userdefault valueForKey:@"userToken"],@"key":text,@"shopid":_shopID,@"page":@"1"} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            if (jsonDic[@"data"]) {
                [seacrchImage removeFromSuperview];
                [inquireLabel removeFromSuperview];
                [addBtn removeFromSuperview];
                [codeBtn removeFromSuperview];
                [searchArr addObjectsFromArray:jsonDic[@"data"]];
                shopNameTableView.hidden = YES;
                [searchTableview.mj_header endRefreshing];
                [searchTableview reloadData];
                [seacrImage removeFromSuperview];
                [inquLabel removeFromSuperview];
                [disLabel removeFromSuperview];
                //商家库
                [self createshopBtn];
            }else{
                [seacrchImage removeFromSuperview];
                [searchArr removeAllObjects];
                [searchTableview reloadData];
                [codeBtn removeFromSuperview];
                [addBtn removeFromSuperview]; 
                [addShop removeFromSuperview];
                [seacrImage removeFromSuperview];
                [inquLabel removeFromSuperview];
                [disLabel removeFromSuperview];
                
                //提示的view
                [self toilView:text];
                [searchTableview.mj_header endRefreshing];
                
            }
            self.view.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            nil;
            self.view.userInteractionEnabled = YES;
        }];
    }
}
-(void)createshopBtn
{
    //上架按钮
    addShop = [UIButton buttonWithType:UIButtonTypeSystem];
    addShop.frame = CGRectMake(35 * WIDHTSCALE, HEIGHT - 50 * HEIGHTSCALE - 50 *HEIGHTSCALE - 64 + 45*HEIGHTSCALE , WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
    addShop.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:0.7];
    
    [addShop setTitle:@"确定上传" forState:UIControlStateNormal];
    
    [addShop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addShop.layer.cornerRadius = 5;
    addShop.layer.masksToBounds = YES;
    [addShop addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addShop];
}
#pragma mark -- 确认上架的按钮
-(void)addClick{
    [self createView];
}
//点击确认上传的弹框
-(void)createView{
    //背景色
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:backView];
    //自定义的弹窗
    UIView *shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake((WIDHT - 592*WIDHTSCALE/2)/2, (backView.frame.size.height - 160 *HEIGHTSCALE)/2, 592*WIDHTSCALE/2, 160*HEIGHTSCALE);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 5;
    shoperView.layer.borderWidth = 0.1;
    [backView addSubview:shoperView];
    
    UIView *garyView = [[UIView alloc]init];
    garyView.frame = CGRectMake((592/2 - 528/2)/2 *WIDHTSCALE, 32 *HEIGHTSCALE, 528/2 *WIDHTSCALE, (120 - 64) *HEIGHTSCALE) ;
    garyView.backgroundColor = [UIColor colorWithRed:237/255.0 green:241/255.0 blue:242/255.0 alpha:1.0];
    [shoperView addSubview:garyView];
    
    UILabel *diLabel = [[UILabel alloc]init];
    diLabel.frame = CGRectMake(5*WIDHTSCALE , 0, 528/2 *WIDHTSCALE , (120 - 64) *HEIGHTSCALE);
    diLabel.text = @"上传的商品会转移到您的顺道嘉库中，想编辑该商品信息可以去顺道嘉库中搜索该商品进行修改";
    diLabel.numberOfLines = 0;
    diLabel.font = [UIFont systemFontOfSize:14 *HEIGHTSCALE];
    diLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [garyView addSubview:diLabel];
    
    UIButton *coumBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    coumBtn.frame = CGRectMake(0, 120 *HEIGHTSCALE, 592/2*WIDHTSCALE/2, 40*HEIGHTSCALE);
    [coumBtn setBackgroundImage:[UIImage imageNamed:@"取消按钮"] forState:(UIControlStateNormal)];
    [coumBtn setBackgroundImage:[UIImage imageNamed:@"取消按钮-（点击）"] forState:(UIControlStateHighlighted)];
    [coumBtn addTarget:self action:@selector(cauleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:coumBtn];
    
    UIButton *trueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    trueBtn.frame = CGRectMake(592/2*WIDHTSCALE/2, 120 *HEIGHTSCALE, 592/2*WIDHTSCALE/2, 40*HEIGHTSCALE);
    [trueBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮"] forState:(UIControlStateNormal)];
    [trueBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮（点击）"] forState:(UIControlStateHighlighted)];
    [trueBtn addTarget:self action:@selector(trueBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:trueBtn];
}
-(void)trueBtn
{
    [backView removeFromSuperview];
    NSLog(@"请求接口");
    //上架
    if (_xiajiaMuArr.count != 0) {
        NSString *str = _xiajiaMuArr[0];
        for (int i = 1; i < _xiajiaMuArr.count; i++) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@",%@", _xiajiaMuArr[i]]];
        }
        NSLog(@"重组后 %@", str);
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"添加中..."];
        //下架请求
        NSDictionary *paramter = @{@"id":[userdefault valueForKey:@"userID"], @"token":[userdefault valueForKey:@"userToken"], @"shopid":_shopID, @"ids":str};
        NSLog(@"parem:%@",paramter);
        [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"300109"] parameters:paramter success:^(id responseObject) {
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"上架商品返回数据 %@", str);
            
            
            [SVProgressHUD dismiss];
            //[SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            [TCProgressHUD showMessage:dic[@"retMessage"]];
            
            
            [self createShopLib:self.textfield];
            self.view.userInteractionEnabled = YES;
           [searchTableview reloadData];
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            //[SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            [TCProgressHUD showMessage:@"添加失败"];
           // [SVProgressHUD showErrorWithStatus:@"添加失败"];
        }];
    } else {
        [TCProgressHUD showMessage:@"没有添加商品"];
    }
    
}

#pragma mark -- 弹出框的点击事件
-(void)cauleBtn{
    [backView removeFromSuperview];
}

//上拉加载
- (void)createShopLib:(int)page addtext:(NSString *)text{
    if(tagStr == 100 || [[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300111"] paramter:@{@"id":[userdefault valueForKey:@"userID"], @"token":[userdefault valueForKey:@"userToken"],@"key":text,@"shopid":_shopID,@"page":@(page)} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            if (jsonDic[@"data"]) {
                [searchArr addObjectsFromArray:jsonDic[@"data"]];
                [searchTableview.mj_footer endRefreshing];
                
            }else{
                [searchTableview.mj_footer endRefreshing];
                [searchTableview.mj_footer endRefreshingWithNoMoreData];
            }
            [searchTableview reloadData];
        } failure:^(NSError *error) {
            nil;
        }];
    }else if (tagStr == 200){
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300112"] paramter:@{@"id":[userdefault valueForKey:@"userID"], @"token":[userdefault valueForKey:@"userToken"],@"key":text,@"shopid":_shopID,@"page":@(page),@"pagesize":@"15"}  success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            if (jsonDic[@"data"]) {
                [searchArr addObjectsFromArray:jsonDic[@"data"]];
                [searchTableview.mj_footer endRefreshing];
            }else{
                [searchTableview.mj_footer endRefreshing];
                [searchTableview.mj_footer endRefreshingWithNoMoreData];
            }
            [searchTableview reloadData];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}

//提示的view
-(void)toilView:(NSString *)text
{
    [seacrchImage removeFromSuperview];
    [inquireLabel removeFromSuperview];
    
    seacrImage = [[UIImageView alloc]init];
    seacrImage.image = [UIImage imageNamed:@"未搜到商品提示图片"];
    seacrImage.frame = CGRectMake((WIDHT - 50 )/2, (HEIGHT - 50 )/2 - 64 , 70, 70);
    
    inquLabel = [[UILabel alloc]init];
    inquLabel.frame = CGRectMake(0, (HEIGHT - 50 )/2 + 22 + 70 - 64 , WIDHT, 20);
    inquLabel.text = [NSString stringWithFormat:@"暂时没搜到“%@”相关商品",text];
    inquLabel.font = [UIFont systemFontOfSize:15];
    inquLabel.textAlignment = NSTextAlignmentCenter;
    inquLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    disLabel = [[UILabel alloc]init];
    disLabel.frame = CGRectMake((WIDHT - 240 )/2, inquireLabel.frame.size.height + inquireLabel.frame.origin.y + 8 , 240, 20);
    if(tagStr == 100 || [[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
      noteStr = [[NSMutableAttributedString alloc] initWithString:@"换个关键词试试或创建该商品吧"];
    }
    if(tagStr == 200){
      noteStr = [[NSMutableAttributedString alloc] initWithString:@"换个关键词试试或在商家库创建该商品吧"]; 
    }
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9,5)];
    disLabel.attributedText = noteStr;
    disLabel.font = [UIFont systemFontOfSize:12];
    disLabel.textAlignment = NSTextAlignmentCenter;
    disLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    [self.view addSubview:seacrImage];
    [self.view addSubview:inquLabel];
    [self.view addSubview:disLabel];
}

//创建底部两个按钮
-(void)createBtn
{
    codeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    codeBtn.frame = CGRectMake(0, HEIGHT - 48 * HEIGHTSCALE - 50 - 10, WIDHT/2, 48 *HEIGHTSCALE);
    [codeBtn setBackgroundImage:[UIImage imageNamed:@"条形码添加"] forState:(UIControlStateNormal)];
    [codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeBtn];
    
    
    addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addBtn.frame = CGRectMake(WIDHT/2, HEIGHT - 48 * HEIGHTSCALE - 50 - 10 , WIDHT/2, 48 *HEIGHTSCALE);
    [addBtn setTitle:@"手动添加" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    addBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    addBtn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addBtn];
}
#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == shopNameTableView){
        return shopNameArr.count;
    }else{
        return searchArr.count;
    }
}

#pragma mark - tableView UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == shopNameTableView){
        return 0;
    }else{
        if(section == 0){
        return 8;
        }else{
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(tableView == shopNameTableView){
        return 0;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == shopNameTableView){
        static NSString *cellIdentity = @"leftCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        cell.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15 *HEIGHTSCALE];
        cell.textLabel.text = shopNameArr[indexPath.row];
        return cell;
    }else{
        [searchTableview registerNib:[UINib nibWithNibName:@"TCShopsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        TCShopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (searchArr.count != 0) {
            //如果有中文
            NSString *string1 = [searchArr[indexPath.row][@"headPic"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.shopimageviews sd_setImageWithURL:[NSURL URLWithString:string1] placeholderImage:[UIImage imageNamed:@"shopmo.png"]];
            cell.shopname.text = searchArr[indexPath.row][@"name"];
            cell.money.text = [NSString stringWithFormat:@"¥%@", searchArr[indexPath.row][@"price"]];
            cell.select.tag = indexPath.section;
            if ([searchArr[indexPath.row][@"spec"] isEqualToString:@""]) {
                cell.guige.text = @"规格:暂无";
            }else{
                cell.guige.text = [NSString stringWithFormat:@"规格:%@", searchArr[indexPath.row][@"spec"]];
            }
            if(tagStr == 100 || [[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
                if (_isShow) {
                    cell.bianji.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    [cell.bianji setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.kucun.text = [NSString stringWithFormat:@"库存量:%@", searchArr[indexPath.row][@"stockCount"]];
                }else{
                    cell.bianji.layer.borderColor = Color.CGColor;
                    [cell.bianji setTitleColor:Color forState:UIControlStateNormal];
                    cell.kucun.text = @"";
            }
                //编辑按钮
                cell.bianji.tag = indexPath.row;
                [cell.bianji addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
                cell.select.hidden = YES;
                if([searchArr[indexPath.section][@"status"] isEqualToString:@"1"]){
                    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"已上架角标"]];
                    imageView.frame = CGRectMake(WIDHT - 40, 130 - 40, 40, 40);
                    [cell.contentView addSubview:imageView];
                }
            }
            if(tagStr == 200){
                cell.kucun.text = [NSString stringWithFormat:@"库存量:%@", searchArr[indexPath.row][@"stockCount"]];
                //如果有中文
                NSString *string1 = [searchArr[indexPath.row][@"images"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [cell.shopimageviews sd_setImageWithURL:[NSURL URLWithString:string1] placeholderImage:[UIImage imageNamed:@"shopmo.png"]];
                cell.shopname.text = searchArr[indexPath.row][@"name"];
                cell.money.text = [NSString stringWithFormat:@"¥%@", searchArr[indexPath.row][@"price"]];
                cell.select.tag = indexPath.row;
                cell.select.hidden = NO;
        
                if ([searchArr[indexPath.row][@"spec"] isEqualToString:@""]) {
                    cell.guige.text = @"规格:暂无";
                }else{
                    cell.guige.text = [NSString stringWithFormat:@"规格:%@", searchArr[indexPath.row][@"spec"]];
                }
                [cell.select addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([searchArr[indexPath.row][@"shophas"] intValue] == 1) {
                    [cell.select setImage:[UIImage imageNamed:@"选中框（灰色）"] forState:UIControlStateNormal];
                    cell.userInteractionEnabled = NO;
                    cell.select.selected = NO;
                }else{
                    if ([_xiajiaMuArr containsObject: searchArr[indexPath.row][@"id"]]) {
                        cell.select.selected = YES;
                    }else{
                        cell.select.selected = NO;
                    }
                    [cell.select setImage:[UIImage imageNamed:@"商品未选中框x"] forState:UIControlStateNormal];
                    
                    cell.userInteractionEnabled = YES;
                    //                cell.select.selected = YES;
                }
                
//                if ([_xiajiaMuArr containsObject: searchArr[indexPath.row][@"id"]]) {
//                    cell.select.selected = YES;
//                }else{
//                    cell.select.selected = NO;
//                }
                if (_isShow) {
                    cell.bianji.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    [cell.bianji setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.kucun.text = [NSString stringWithFormat:@"库存量:%@", searchArr[indexPath.row][@"stockCount"]];
                }else{
                    cell.bianji.layer.borderColor = Color.CGColor;
                    [cell.bianji setTitleColor:Color forState:UIControlStateNormal];
                    cell.kucun.text = @"";
                }
                
                cell.bianji.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [cell.bianji setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.bianji.userInteractionEnabled = NO;
                if([searchArr[indexPath.section][@"status"] isEqualToString:@"1"]){
                    
                }
            }
            return cell;

            }
        return cell;
    }
    
}
//下架勾选按钮点击事件
- (void)select:(UIButton *)sender{
    NSLog(@"当前tag%ld", (long)sender.tag);
    if (!_isShow) {
        if ([_xiajiaMuArr containsObject: searchArr[sender.tag][@"id"]]) {
            [_xiajiaMuArr removeObject:searchArr[sender.tag][@"id"]];
        }else{
            [_xiajiaMuArr addObject:searchArr[sender.tag][@"id"]];
        }
        [searchTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == shopNameTableView){
        if (shopNameArr.count != 0) {
            
            [shopNameArr removeAllObjects];
            searchTableview.hidden = NO;
        }
    }else if (tableView == searchTableview){
        if (!_isShow) {
            if(tagStr == 100){
                TCShopEditViewController *c = [[TCShopEditViewController alloc]init];
                c.isChange = YES;
                c.shopMesDic = searchArr[indexPath.row];
                c.shopid = searchArr[indexPath.row][@"id"];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:c animated:YES];
            }
        }else{
            if ([[userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
                if(tagStr == 100){
                    TCShopEditViewController *c = [[TCShopEditViewController alloc]init];
                    c.isChange = YES;
                    c.shopMesDic = searchArr[indexPath.row];
                    c.shopid = searchArr[indexPath.row][@"id"];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:c animated:YES];
                }
            }
        }
    }
}
//编辑店铺
- (void)bianji:(UIButton *)sender{
    TCShopEditViewController *c = [[TCShopEditViewController alloc]init];
    c.isChange = YES;
    c.shopMesDic = searchArr[sender.tag];
    c.shopid = searchArr[sender.tag][@"id"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:c animated:YES];
}
#pragma mark -- 底部按钮的点击事件
-(void)codeClick:(UIButton *)sender
{
    NSLog(@"二维码添加");
    TCQrcodeViewController *qr = [[TCQrcodeViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qr animated:YES];
}
-(void)addBtnClick:(UIButton *)sender
{
    NSLog(@"手动添加");
    TCShopEditViewController *edit = [[TCShopEditViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:edit animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
