//
//  TCShopsManaerViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/19.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopsManaerViewController.h"
#import "TCSellViewController.h"
#import "TCDownViewController.h"
#import "TCStoreViewController.h"
#import "TCSeachShopViewController.h"
#import "TCQrcodeViewController.h"
#import "TCShopEditViewController.h"

#import "TCTabBarViewController.h"
#import "TCLeftGoodsViewCell.h"
#import "TCRightGoodsViewCell.h"
#import "TCTableViewHeaderView.h"
#import "UITableView+HD_NoList.h"
#import "TCAddGoodsViewController.h" //添加商品
#import "TCShopCateGoryModel.h"
#import "TCShopGoodsModel.h"
#import "TCCreateShopsViewController.h" //添加商品
#import "TCSearchgoodsViewController.h"//搜索商品
#import "TCPhoneType.h"
//#import "MMScanViewController.h" //二维码扫描

static float kLeftTableViewWidth = 96;

@interface TCShopsManaerViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *lastButton;
    UIView *lineView;
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    UILabel *allgoodsLabel; //搜索框内的显示商品总数
    UIButton *saoCodeBtn; // 扫描添加或者手动添加
    UIButton *shangdeleBtn; //上架删除按钮
    UIButton *xiadeleBtn; //下架删除按钮
    UIButton *shoudeleBtn; //收完删除按钮
    UIButton *xiajiaBtn; //下架按钮
    UIButton *shangjiaBtn; //上架的按钮
    UIButton *allSeleBtn; //全选的按钮
    UILabel *allSeleLabel; //全选的文字
    UIButton *rightButton;
    
    NSString * type; //选择的类型
    //是否全选
    BOOL isSelect;
    //是否点击管理
    BOOL isGuanli;
    //已选的商品合集
    NSMutableArray *selectGoods;
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
@property (nonatomic, strong) NSDictionary *sortDic;
@property (nonatomic, strong) UIScrollView *titleView3;//分类按钮view
@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIButton *rightBtn;//参数
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSMutableArray *dataLeftArr;
@property (nonatomic, strong) NSMutableArray *dataRightArr;
@property (nonatomic, strong) NSArray *goodsArr; //全选
@property (nonatomic, strong) UIImageView *zeroImage;
@property (nonatomic, strong) UILabel *zerolabel;
@property (nonatomic, strong) NSString *showQrstr;

@end

@implementation TCShopsManaerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    self.tabBarController.tabBar.hidden= NO;
    [self.navigationController setNavigationBarHidden:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
   
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    allSeleBtn.selected = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"1";
    _userdefaults = [NSUserDefaults standardUserDefaults];
    self.dataLeftArr = [NSMutableArray array];
    self.dataRightArr = [NSMutableArray array];
    selectGoods = [NSMutableArray array];
    self.showQrstr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"showQR"]];
    //添加成功返回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhishuaxin) name:@"tongzhishuaxin" object:nil];
    self.title = @"商品管理";
    //右边的导航栏
     rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 *WIDHTSCALE, 28*HEIGHTSCALE)];
    // Add your action to your button
    [rightButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"管理" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14*WIDHTSCALE];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    rightButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    rightButton.selected = NO;
    lastButton = rightButton;
    self.navigationItem.rightBarButtonItem = barBtn;
    if ([self.showQrstr isEqualToString:@"1"]) {
        
    }else{
        //左边的添加商品按钮
        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDHTSCALE, 11*HEIGHTSCALE, 19, 19)];
        [self.leftBtn addTarget:self action:@selector(clickleftBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"添加商品"] forState:(UIControlStateNormal)];
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
        self.navigationItem.leftBarButtonItem = leftBtn;
    }
    //创建View
    [self creatUI];
    //进来刷新
    [self questGoods:type];
}

#pragma mark -- tongzhishuaxin
- (void)tongzhishuaxin
{
    [self questGoods:type];
}

//请求商品的列表接口
- (void)questGoods:(NSString *)typeStr
{
    self.view.userInteractionEnabled = NO;
    UIView *bottomView = (UIView *)[self.view viewWithTag:10051];
    [self.dataLeftArr removeAllObjects];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    
    NSDictionary *dic = @{@"type":typeStr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"type":typeStr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"203011"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        
        if ([codeStr isEqualToString:@"1"]) {
            self.leftTableView.userInteractionEnabled = YES;
            self.view.userInteractionEnabled = YES;
            if (![self.showQrstr isEqualToString:@"1"]) {
                bottomView.hidden = YES;
            }
            if ([jsonDic[@"data"] count] != 0) {
                NSLog(@"%@",jsonDic);
                self.leftTableView.hidden = NO;
                self.rightTableView.hidden = NO;
                self.zeroImage.hidden = YES;
                self.zerolabel.hidden = YES;
                NSMutableArray *foodsort = jsonDic[@"data"];
                for (NSDictionary *dict in foodsort)
                {
                    TCShopCateGoryModel *model = [TCShopCateGoryModel shopCateInfogoryWithDictionary:dict];
                    [self.dataLeftArr addObject:model];
                }
                NSDictionary *dic = jsonDic[@"data"][0];
            
                NSString *goodscateid = [NSString stringWithFormat:@"%@",dic[@"goodscateid"]];
                [self creatRequestgoodscateid:goodscateid andType:typeStr];
                [_leftTableView reloadData];
                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                animated:YES
                                          scrollPosition:UITableViewScrollPositionNone];
            }
        }else{
            if ([typeStr isEqualToString:@"1"]) {
               [TCProgressHUD showMessage:@"出售中暂无商品"];
                self.leftTableView.hidden = YES;
                self.rightTableView.hidden = YES;
                [self NeedResetNoView];
            }else if ([typeStr isEqualToString:@"2"]){
               [TCProgressHUD showMessage:@"暂无售罄的商品"];
                self.leftTableView.hidden = YES;
                self.rightTableView.hidden = YES;
                [self NeedResetNoView];
            }else{
               [TCProgressHUD showMessage:@"下架库中暂无商品"];
                self.leftTableView.hidden = YES;
                self.rightTableView.hidden = YES;
                [self NeedResetNoView];
            }
            self.view.userInteractionEnabled = YES;
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)NeedResetNoView{
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    self.zeroImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 160)/2, CGRectGetMaxY(btn.frame) + 113, 160, 98)];
    self.zeroImage.image = [UIImage imageNamed:@"搜索无果缺省页"];
    [self.view addSubview:self.zeroImage];
    
    self.zerolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.zeroImage.frame) + 17, WIDHT, 22)];
    self.zerolabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.zerolabel.textAlignment = NSTextAlignmentCenter;
    self.zerolabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:153/255.0];
    self.zerolabel.text = @"暂无商品，请尽快上传";
    [self.view addSubview:self.zerolabel];

}

-(void)creatRequestgoodscateid:(NSString *)goodscateid andType:(NSString *)type{
    //下拉
    __block int page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        //刷新
        [self requestRight:goodscateid andType:type];
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
    
    _rightTableView.mj_header = header;
    [header beginRefreshing];
    //上拉
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self requestRight:page andGoodcateid:goodscateid andType:type];
    }];
    //设置上拉标题
    [footer setTitle:@"上拉加载更多顺道嘉商品" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多顺道嘉商品..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"无更多顺道嘉商品!" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    _rightTableView.mj_footer = footer;
}
#pragma mark -- 下拉刷新
-(void)requestRight:(NSString *)goodscateid andType:(NSString *)typestr{
    self.view.userInteractionEnabled = NO;
    UIView *bottomView = (UIView *)[self.view viewWithTag:10051];
     [self.dataRightArr removeAllObjects];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"type":typestr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"goodscateid":goodscateid};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"type":typestr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr,@"goodscateid":goodscateid};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"203012"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        NSLog(@"%@---%@",jsonDic,jsonStr);
        if (![self.showQrstr isEqualToString:@"1"]) {
             bottomView.hidden = YES;
        }
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            NSArray *arr = jsonDic[@"data"];
            for (NSDictionary *dic in arr) {
                TCShopGoodsModel *shopModel = [TCShopGoodsModel shopInfoWithDictionary:dic];
                [self.dataRightArr addObject:shopModel];
            }
            self.zeroImage.hidden = YES;
            self.zerolabel.hidden = YES;
            [_rightTableView reloadData];
            [_rightTableView.mj_header endRefreshing];
           
        }
        _rightTableView.userInteractionEnabled = YES;

        self.view.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        nil;
        self.view.userInteractionEnabled = YES;
    }];
    [_rightTableView.mj_footer resetNoMoreData];
}

#pragma mark -- 上拉加载
-(void)requestRight:(int)page andGoodcateid:(NSString *)goodscateid andType:(NSString *)typestr{
    UIView *bottomView = (UIView *)[self.view viewWithTag:10051];

    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"type":typestr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"goodscateid":goodscateid,@"page":pageStr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"type":typestr,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr,@"goodscateid":goodscateid,@"page":pageStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"203012"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        if (![self.showQrstr isEqualToString:@"1"]) {
            bottomView.hidden = YES;
        }
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            NSArray *arr = jsonDic[@"data"];
            for (NSDictionary *dic in arr) {
                TCShopGoodsModel *shopModel = [TCShopGoodsModel shopInfoWithDictionary:dic];
                [self.dataRightArr addObject:shopModel];
            }
            [_rightTableView.mj_footer endRefreshing];
            self.zeroImage.hidden = YES;
            self.zerolabel.hidden = YES;
            //占位图
        }
        [_rightTableView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
    [_rightTableView.mj_footer resetNoMoreData];
}

//创建View
- (void)creatUI
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = TCNavColor;
    headView.frame = CGRectMake(0, 0, WIDHT,44);
    [self.view addSubview:headView];
    
    //创建search
    UIView *seachView = [[UIView alloc] init];
    seachView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    seachView.frame = CGRectMake(15, 6, WIDHT - 30, 32);
    [headView addSubview:seachView];
    
    //加入手势点击进入搜索页面
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [seachView addGestureRecognizer:tap];
    
    //显示店内商品总数
    allgoodsLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDHT - 30 - 95)/2, 9, 95, 14)];
    allgoodsLabel.textColor = TCUIColorFromRGB(0x999C9E);
    allgoodsLabel.textAlignment = NSTextAlignmentLeft;
    allgoodsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    allgoodsLabel.text = @"搜索店内商品";
    [seachView addSubview:allgoodsLabel];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allgoodsLabel.frame) - 95 - 14 - 5, 9, 14, 14)];
    iconImage.image = [UIImage imageNamed:@"搜索放大镜"];
    [seachView addSubview:iconImage];
    
    
    //
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    titleView.frame = CGRectMake(0, CGRectGetMaxY(seachView.frame) + 10, WIDHT, 44);
    [self.view addSubview:titleView];
    
    NSArray *titleArr = @[@"出售中",@"售罄的",@"下架库"];
    for (int i = 0; i < titleArr.count; i ++) {
        CGFloat btnWidth = WIDHT / 3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, 44);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        
        [btn setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:TCUIColorFromRGB(0x333333) forState:UIControlStateSelected];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            lastButton = btn;
            type = @"1";
    }
    }
    lineView = [[UIView alloc] initWithFrame:CGRectMake((WIDHT/3 - 20)/2, 40, 20, 4)];
    lineView.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    [titleView addSubview:lineView];
    
    //小灰条
    UIView *garyView = [[UIView alloc] init];
    garyView.frame = CGRectMake(0, CGRectGetMaxY(titleView.frame), WIDHT, 5);
    garyView.backgroundColor = TCBgColor;
    [self.view addSubview:garyView];
    
    //创建tableView
    //左边的tableView
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(garyView.frame), kLeftTableViewWidth, HEIGHT - 56 - 49 - CGRectGetMaxY(garyView.frame))];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.rowHeight = 58;
    _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.tableFooterView = [UIView new];
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.separatorColor = [UIColor clearColor];
    //ios11解决点击刷新跳转的问题
    _leftTableView.estimatedRowHeight = 0;
    _leftTableView.estimatedSectionHeaderHeight = 0;
    _leftTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_leftTableView];
    //右边的tableView
    _rightTableView = [[UITableView alloc] init];
    _rightTableView.frame = CGRectMake(kLeftTableViewWidth, CGRectGetMaxY(garyView.frame) , WIDHT - kLeftTableViewWidth, HEIGHT - 56 - 49 - CGRectGetMaxY(garyView.frame));
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 124;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.estimatedRowHeight = 0;
    _rightTableView.estimatedSectionHeaderHeight = 0;
    _rightTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_rightTableView];
    
    _selectIndex = 0;
    _isScrollDown = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
    //底部的view
    UIView *bottomView = [[UIView alloc] init];
    bottomView.tag = 10051;
    NSString* phoneModel = [TCPhoneType iphoneType];//方法在下面
    if ([phoneModel isEqualToString:@"iPhone X"]) {
        bottomView.frame = CGRectMake(0, HEIGHT - 90 - 49 - 64, WIDHT, 90);
    } else {
        bottomView.frame = CGRectMake(0, HEIGHT - 56 - 49 - 64, WIDHT, 56);
    }
    
    bottomView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bottomView];
    
    if ([self.showQrstr isEqualToString:@"1"]) {
        bottomView.hidden = NO;
        
    }else{
        bottomView.hidden = YES;
    }
    
    //加条细线
    UIView *line_oneView = [[UIView alloc] init];
    line_oneView.backgroundColor = TCBgColor;
    line_oneView.frame = CGRectMake(0, 0, WIDHT, 1);
    [bottomView addSubview:line_oneView];
    
    //扫描添加
    NSArray *codeArr = @[@"扫码添加",@"手动添加"];
    for (int i = 0; i < 2; i ++) {
        saoCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = (WIDHT - 106 *2)/3;
        saoCodeBtn.frame = CGRectMake(width + (width + 106) * i, 10, 106, 36);
        [saoCodeBtn setTitle:codeArr[i] forState:UIControlStateNormal];
        [saoCodeBtn setTitleColor:TCUIColorFromRGB(0x5BBFBE) forState:UIControlStateNormal];
        saoCodeBtn.layer.cornerRadius = 5;
        saoCodeBtn.layer.borderWidth = 1;
        saoCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        saoCodeBtn.layer.borderColor = TCUIColorFromRGB(0x5BBFBE).CGColor;
        saoCodeBtn.layer.masksToBounds = YES;
        saoCodeBtn.tag = 10000 + i;
        saoCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [saoCodeBtn addTarget:self action:@selector(saoCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:saoCodeBtn];
    }

    //点击管理出来的底部的删除按钮
    //出售中的
    xiajiaBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    xiajiaBtn.frame = CGRectMake(20, 16, 68, 24);
    xiajiaBtn.layer.cornerRadius = 12;
    xiajiaBtn.layer.masksToBounds = YES;
    [xiajiaBtn setTitle:@"下架" forState:(UIControlStateNormal)];
    xiajiaBtn.layer.borderWidth = 1;
    xiajiaBtn.hidden = YES;
    xiajiaBtn.layer.borderColor = TCUIColorFromRGB(0x5BBFBE).CGColor;
    [xiajiaBtn setTitleColor:TCUIColorFromRGB(0x5BBFBE) forState:(UIControlStateNormal)];
    xiajiaBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [xiajiaBtn addTarget:self action:@selector(xiajiaAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:xiajiaBtn];
    
    //上架
    shangjiaBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shangjiaBtn.frame = CGRectMake(20, 16, 68, 24);
    shangjiaBtn.layer.cornerRadius = 12;
    shangjiaBtn.layer.masksToBounds = YES;
    [shangjiaBtn setTitle:@"上架" forState:(UIControlStateNormal)];
    shangjiaBtn.layer.borderWidth = 1;
    shangjiaBtn.hidden = YES;
    shangjiaBtn.layer.borderColor = TCUIColorFromRGB(0x5BBFBE).CGColor;
    [shangjiaBtn setTitleColor:TCUIColorFromRGB(0x5BBFBE) forState:(UIControlStateNormal)];
    shangjiaBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [shangjiaBtn addTarget:self action:@selector(xiajiaAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:shangjiaBtn];
    
    //删除按钮
    shangdeleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shangdeleBtn.frame = CGRectMake(20 + CGRectGetMaxX(shangjiaBtn.frame), 16, 68, 24);
    shangdeleBtn.layer.cornerRadius = 12;
    shangdeleBtn.layer.masksToBounds = YES;
    [shangdeleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    shangdeleBtn.layer.borderWidth = 1;
    shangdeleBtn.hidden = YES;
    shangdeleBtn.layer.borderColor = TCUIColorFromRGB(0xFF5544).CGColor;
    [shangdeleBtn setTitleColor:TCUIColorFromRGB(0xFF5544) forState:(UIControlStateNormal)];
    shangdeleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [shangdeleBtn addTarget:self action:@selector(deleBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:shangdeleBtn];
    
    
    //删除按钮
    xiadeleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    xiadeleBtn.frame = CGRectMake(20 + CGRectGetMaxX(xiajiaBtn.frame), 16, 68, 24);
    xiadeleBtn.layer.cornerRadius = 12;
    xiadeleBtn.layer.masksToBounds = YES;
    [xiadeleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    xiadeleBtn.layer.borderWidth = 1;
    xiadeleBtn.hidden = YES;
    xiadeleBtn.layer.borderColor = TCUIColorFromRGB(0xFF5544).CGColor;
    [xiadeleBtn setTitleColor:TCUIColorFromRGB(0xFF5544) forState:(UIControlStateNormal)];
    xiadeleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [xiadeleBtn addTarget:self action:@selector(deleBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:xiadeleBtn];
    
    //售完
    shoudeleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shoudeleBtn.frame = CGRectMake(20, 16, 68, 24);
    shoudeleBtn.layer.cornerRadius = 12;
    shoudeleBtn.layer.masksToBounds = YES;
    [shoudeleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    shoudeleBtn.layer.borderWidth = 1;
    shoudeleBtn.hidden = YES;
    shoudeleBtn.layer.borderColor = TCUIColorFromRGB(0xFF5544).CGColor;
    [shoudeleBtn setTitleColor:TCUIColorFromRGB(0xFF5544) forState:(UIControlStateNormal)];
    shoudeleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [shoudeleBtn addTarget:self action:@selector(deleBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:shoudeleBtn];
    
    //全选的label
    allSeleLabel = [UILabel publicLab:@"全选" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    allSeleLabel.frame = CGRectMake(WIDHT - 45 - 28, 0, 28, 56);
    allSeleLabel.hidden = YES;

    [bottomView addSubview:allSeleLabel];
    
    //全选的框
    allSeleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    allSeleBtn.frame = CGRectMake(CGRectGetMaxX(allSeleLabel.frame) + 10, (56 - 20)/2, 20, 20);
    [allSeleBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
    [allSeleBtn setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:(UIControlStateSelected)];
    [allSeleBtn addTarget:self action:@selector(allSeleBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    allSeleBtn.hidden = YES;
    [bottomView addSubview:allSeleBtn];
}

//点击手势
-(void)tap:(UITapGestureRecognizer *)tp{
    TCSearchgoodsViewController *searchgoodsVC = [[TCSearchgoodsViewController alloc]init];
    searchgoodsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchgoodsVC animated:YES];
}

- (void)btnClicked:(UIButton *)button {
    static NSTimeInterval time = 0.0;
    NSTimeInterval currentTime = [NSDate date].timeIntervalSince1970;
    if (currentTime - time > 1) {
        self.view.userInteractionEnabled = NO;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.zeroImage.hidden = YES;
        self.zerolabel.hidden = YES;
        lastButton.selected = NO;
        button.selected = YES;
        lastButton = button;
        
        UIButton *btn_one = (UIButton *)[self.view viewWithTag:10000];
        UIButton *btn_two = (UIButton *)[self.view viewWithTag:10001];
        
        [rightButton setTitle:@"管理" forState:(UIControlStateNormal)];
        btn_one.hidden = NO;
        btn_two.hidden = NO;
        xiadeleBtn.hidden = YES;
        xiajiaBtn.hidden = YES; //下架按钮
        shangjiaBtn.hidden = YES; //上架的按钮
        allSeleBtn.hidden = YES; //全选的按钮
        allSeleLabel.hidden = YES; //全选的文字
        shangjiaBtn.hidden = YES;
        shangdeleBtn.hidden = YES;
        shoudeleBtn.hidden = YES;
        
        CGRect frame = lineView.frame;
        switch (button.tag) {
            case 1000: {
                frame.origin.x = (WIDHT/3 - 20)/2;
                [self questGoods:@"1"];
                type = @"1";
            }
                break;
            case 1001: {
                frame.origin.x = (WIDHT/3 - 20)/2 + WIDHT/3;
                [self questGoods:@"2"];
                type = @"2";
            }
                break;
            case 1002: {
                frame.origin.x = WIDHT / 3 * 2 + (WIDHT/3 - 20)/2;
                [self questGoods:@"3"];
                type = @"3";
            }
                break;
            default:
                break;
        }
        lineView.frame = frame;
        [_leftTableView reloadData];
        [_rightTableView reloadData];
    }
    time = currentTime;
}


#pragma mark -- 扫码添加和手动添加
- (void)saoCodeBtnClicked:(UIButton *)sender
{
    if (sender.tag == 10000){
        
        NSString *shopStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"shopID"]];
        if ([shopStr isEqualToString:@"0"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善店铺信息" message:@"完善店铺信息后才能继续操作下一步功能，完善店铺信息可尽快审核上架店铺并且能用当前app全部功能，请您尽快完善。" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subView1 = alert.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *title = subView5.subviews[0];
            UILabel *message = subView5.subviews[1];
            message.textAlignment = NSTextAlignmentLeft;
            message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            message.textColor = TCUIColorFromRGB(0x333333);
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"完善店铺" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                TCCreateShopsViewController *createShopVC = [[TCCreateShopsViewController alloc] init];
                createShopVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:createShopVC animated:YES];
            }];
            [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不完善" style:(UIAlertActionStyleCancel) handler:nil];
            [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            [alert addAction:sure];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //扫码添加
            TCQrcodeViewController *qr = [[TCQrcodeViewController alloc]init];
            qr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qr animated:YES];
        }
    } else {
        
        NSString *shopStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"shopID"]];
        if ([shopStr isEqualToString:@"0"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善店铺信息" message:@"完善店铺信息后才能继续操作下一步功能，完善店铺信息可尽快审核上架店铺并且能用当前app全部功能，请您尽快完善。" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subView1 = alert.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *title = subView5.subviews[0];
            UILabel *message = subView5.subviews[1];
            message.textAlignment = NSTextAlignmentLeft;
            message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            message.textColor = TCUIColorFromRGB(0x333333);
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"完善店铺" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                TCCreateShopsViewController *createShopVC = [[TCCreateShopsViewController alloc] init];
                createShopVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:createShopVC animated:YES];
            }];
            [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不完善" style:(UIAlertActionStyleCancel) handler:nil];
            [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            [alert addAction:sure];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //手动添加
            TCAddGoodsViewController *addGoodsVC = [[TCAddGoodsViewController alloc] init];
            addGoodsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addGoodsVC animated:YES];
        }
    }
}
#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        
        return self.dataLeftArr.count;

    }
    else
    {
        return self.dataRightArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        TCLeftGoodsViewCell *Leftcell = [[TCLeftGoodsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Leftcell"];
        Leftcell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataLeftArr.count == 0){
           
        } else {
            TCShopCateGoryModel *model = self.dataLeftArr[indexPath.row];
            Leftcell.name.text = model.shopCategoryName;
            Leftcell.numLabel.text = [NSString stringWithFormat:@"(%@)",model.shopCategoryNum];

        }
        return Leftcell;
    }
    else
    {
        TCRightGoodsViewCell *Rightcell = [[TCRightGoodsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rightcell"];
        if (self.dataRightArr.count == 0){
           
        } else {
//            TCShopCateGoryModel *shopCategoryModel = self.dataRightArr[indexPath.row];
//            NSArray *arr = shopCategoryModel.shopCategoryGoodsArr;
            self.goodsArr = self.dataRightArr;
            if (isGuanli == YES){
                Rightcell.noSelecBtn.hidden = NO;
                Rightcell.selectionStyle = UITableViewCellSelectionStyleNone;
                Rightcell.isSelected = isSelect;
                
                
                //是否被选中
                if ([selectGoods containsObject:[self.dataRightArr objectAtIndex:indexPath.row]])
                {
                    Rightcell.isSelected = YES;
                }
                
                //block的实现方法
                Rightcell.cartBlock = ^(BOOL isSelec){
                    
                    //选中就加入到数组
                    if (isSelec) {
                        [selectGoods addObject:[self.dataRightArr objectAtIndex:indexPath.row]];
                    }
                    else
                    {
                        //移除
                        [selectGoods removeObject:[self.dataRightArr objectAtIndex:indexPath.row]];
                    }
                    
                    //全选了
                    if (selectGoods.count == self.dataRightArr.count) {
                        allSeleBtn.selected = YES;
                    }
                    else
                    {
                        allSeleBtn.selected = NO;
                    }
                };
            } else {
                Rightcell.noSelecBtn.hidden = YES;
            }
            TCShopGoodsModel *shopModel = self.dataRightArr[indexPath.row];
            Rightcell.model = shopModel;

        }
        
        Rightcell.selectionStyle = UITableViewCellSelectionStyleNone;
                //实现方法
        return Rightcell;
    }
}

#pragma mark -- 选择上架或者下架
- (void)noSelecBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
//    if ((_rightTableView == tableView)
//        && !_isScrollDown
//        && (_rightTableView.dragging || _rightTableView.decelerating))
//    {
//        [self selectRowAtIndexPath:section];
//    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
//    if ((_rightTableView == tableView)
//        && _isScrollDown
//        && (_rightTableView.dragging || _rightTableView.decelerating))
//    {
//        [self selectRowAtIndexPath:section + 1];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        TCShopCateGoryModel *model = self.dataLeftArr[indexPath.row];
        NSString *goodscateid = [NSString stringWithFormat:@"%@",model.shopCategoryID];
        [self creatRequestgoodscateid:goodscateid andType:type];
    } else if (_rightTableView == tableView) {
        if (self.dataRightArr.count == 0){
            
        } else {
//            TCShopCateGoryModel *shopCategoryModel = self.dataRightArr[indexPath.row];
//            NSArray *arr = shopCategoryModel.shopCategoryGoodsArr;
//            self.goodsArr = shopCategoryModel.shopCategoryGoodsArr;
//             TCShopGoodsModel *shopModel = arr[indexPath.row];
            TCShopGoodsModel *model = self.dataRightArr[indexPath.row];
            NSString *goodsid = model.shopGoodsID;
            [self creatRequestGoodsDetails:goodsid AndModle:model];
            
        }

    }
}

//请求选中的商品详情
-(void)creatRequestGoodsDetails:(NSString *)goodsId AndModle:(TCShopGoodsModel *)model{
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
            NSString *sort = jsonDic[@"data"][@"sort"];

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
            [seleDic setObject:sort forKey:@"sort"];
            [seleDic setValue:images forKey:@"images"];
            [seleDic setValue:speclists forKey:@"speclists"];
            TCAddGoodsViewController *addgoodsVC = [[TCAddGoodsViewController alloc]init];
            addgoodsVC.typeStr = type;
            addgoodsVC.selemodel = model;
            addgoodsVC.seleDic = seleDic;
            NSMutableArray *arrImage = [NSMutableArray array];

            for (int i = 0; i < images.count; i++) {
                if ([images[i][@"src"] isEqualToString:@""]){
                    [TCProgressHUD showMessage:@"暂时没有图片"];
                } else {
                    [arrImage addObject:images[i][@"src"]];
                }
            }
            addgoodsVC.goodsImageArr = arrImage;
            addgoodsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addgoodsVC animated:YES];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)clickleftBtn:(UIButton *)sender{
    NSString *shopStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"shopID"]];
    if ([shopStr isEqualToString:@"0"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善店铺信息" message:@"完善店铺信息后才能继续操作下一步功能，完善店铺信息可尽快审核上架店铺并且能用当前app全部功能，请您尽快完善。" preferredStyle:UIAlertControllerStyleAlert];
        UIView *subView1 = alert.view.subviews[0];
        UIView *subView2 = subView1.subviews[0];
        UIView *subView3 = subView2.subviews[0];
        UIView *subView4 = subView3.subviews[0];
        UIView *subView5 = subView4.subviews[0];
        UILabel *title = subView5.subviews[0];
        UILabel *message = subView5.subviews[1];
        message.textAlignment = NSTextAlignmentLeft;
        message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        message.textColor = TCUIColorFromRGB(0x333333);
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"完善店铺" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            TCCreateShopsViewController *createShopVC = [[TCCreateShopsViewController alloc] init];
            createShopVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:createShopVC animated:YES];
        }];
        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不完善" style:(UIAlertActionStyleCancel) handler:nil];
        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //手动添加
        TCAddGoodsViewController *addGoodsVC = [[TCAddGoodsViewController alloc] init];
        addGoodsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addGoodsVC animated:YES];
    }

}

#pragma mark -- 右边导航栏
- (void)barButtonItemPressed:(UIButton *)sender
{
    NSString *shopStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"shopID"]];
    if ([shopStr isEqualToString:@"0"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善店铺信息" message:@"完善店铺信息后才能继续操作下一步功能，完善店铺信息可尽快审核上架店铺并且能用当前app全部功能，请您尽快完善。" preferredStyle:UIAlertControllerStyleAlert];
        UIView *subView1 = alert.view.subviews[0];
        UIView *subView2 = subView1.subviews[0];
        UIView *subView3 = subView2.subviews[0];
        UIView *subView4 = subView3.subviews[0];
        UIView *subView5 = subView4.subviews[0];
        UILabel *title = subView5.subviews[0];
        UILabel *message = subView5.subviews[1];
        message.textAlignment = NSTextAlignmentLeft;
        message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        message.textColor = TCUIColorFromRGB(0x333333);
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"完善店铺" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            TCCreateShopsViewController *createShopVC = [[TCCreateShopsViewController alloc] init];
            createShopVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:createShopVC animated:YES];
        }];
        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不完善" style:(UIAlertActionStyleCancel) handler:nil];
        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //选择与被选择
        sender.selected = !sender.selected;
        UIView *bottomView = (UIView *)[self.view viewWithTag:10051];
        UIButton *btn_one = (UIButton *)[self.view viewWithTag:10000];
        UIButton *btn_two = (UIButton *)[self.view viewWithTag:10001];
        
        if (sender.selected == YES) {
            bottomView.hidden = NO;
            [rightButton setTitle:@"完成" forState:(UIControlStateNormal)];
            isGuanli = YES;
            //扫码隐藏
            btn_one.hidden = YES;
            btn_two.hidden = YES;
            if ([type isEqualToString:@"1"]){   //这里是出售中
                
                shangdeleBtn.hidden = YES;
                shangjiaBtn.hidden = YES;
                xiajiaBtn.hidden = NO;
                xiadeleBtn.hidden = NO;
                shoudeleBtn.hidden = YES;
                allSeleBtn.hidden = NO; //全选的按钮
                allSeleLabel.hidden = NO; //全选的文字
                
            } else if ([type isEqualToString:@"2"]) {  //这里是售馨
                shangdeleBtn.hidden = YES;
                shangjiaBtn.hidden = YES;
                xiajiaBtn.hidden = YES;
                xiadeleBtn.hidden = YES;
                shoudeleBtn.hidden = NO;
                allSeleBtn.hidden = NO;
                allSeleLabel.hidden = NO;
                
            } else if ([type isEqualToString:@"3"]) { //这里是下架库
                
                shangdeleBtn.hidden = NO;
                shangjiaBtn.hidden = NO;
                xiajiaBtn.hidden = YES;
                xiadeleBtn.hidden = YES;
                shoudeleBtn.hidden = YES;
                allSeleBtn.hidden = NO; //全选的按钮
                allSeleLabel.hidden = NO; //全选的文字
                
            }
        } else {
            [rightButton setTitle:@"管理" forState:(UIControlStateNormal)];
            if ([_showQrstr isEqualToString:@"1"]) {
                isGuanli = NO;
                shangdeleBtn.hidden = YES;
                shangjiaBtn.hidden = YES;
                xiajiaBtn.hidden = YES;
                xiadeleBtn.hidden = YES;
                shoudeleBtn.hidden = YES;
                allSeleBtn.hidden = YES; //全选的按钮
                allSeleLabel.hidden = YES; //全选的文字
                btn_one.hidden = NO;
                btn_two.hidden = NO;
            }else{
                bottomView.hidden = YES;
                isGuanli = NO;
                shangdeleBtn.hidden = YES;
                shangjiaBtn.hidden = YES;
                xiajiaBtn.hidden = YES;
                xiadeleBtn.hidden = YES;
                shoudeleBtn.hidden = YES;
                allSeleBtn.hidden = YES; //全选的按钮
                allSeleLabel.hidden = YES; //全选的文字
                btn_one.hidden = NO;
                btn_two.hidden = NO;

            }
        }
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
           }
}

#pragma mark -- 下架点击事件
- (void)xiajiaAction:(UIButton *)sender
{
    if (selectGoods.count == 0) {
        [TCProgressHUD showMessage:@"请至少选择一款商品"];
    }else{
        NSMutableArray * array1 = [NSMutableArray array]; // create a Mutable array
        for (int i = 0; i < selectGoods.count ; i++) {
            TCShopGoodsModel *model = [[TCShopGoodsModel alloc]init];
            model = selectGoods[i];
            
            [array1 addObject:model.shopGoodsID];
        }
        NSString *joinedString = [array1 componentsJoinedByString:@","];
        
        NSLog(@"joinedString is %@", joinedString);
        
        NSString *status;
        //上架
        if ([type isEqualToString:@"3"]){
            status = @"1";
        } else if ([type isEqualToString:@"1"]){
            status = @"0";
        }
        
        // 下架接口
        NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
        NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
        
        NSDictionary *dic = @{@"ids":joinedString,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"status":status};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *parameters = @{@"ids":joinedString,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"status":status,@"sign":singStr};
        
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"204003"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            //成功
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                UIView *bottomView = (UIView *)[self.view viewWithTag:10051];
                UIButton *btn_one = (UIButton *)[self.view viewWithTag:10000];
                UIButton *btn_two = (UIButton *)[self.view viewWithTag:10001];
                if (![self.showQrstr isEqualToString:@"1"]) {
                     bottomView.hidden = YES;
                }
                [rightButton setTitle:@"管理" forState:(UIControlStateNormal)];
                isGuanli = NO;
                shangdeleBtn.hidden = YES;
                shangjiaBtn.hidden = YES;
                xiajiaBtn.hidden = YES;
                xiadeleBtn.hidden = YES;
                shoudeleBtn.hidden = YES;
                allSeleBtn.hidden = YES; //全选的按钮
                allSeleLabel.hidden = YES; //全选的文字
                btn_one.hidden = NO;
                btn_two.hidden = NO;
                if ([type isEqualToString:@"1"]){
                    [self questGoods:@"1"];
                } else if ([type isEqualToString:@"3"]){
                    [self questGoods:@"3"];
                }
            }
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}

#pragma mark -- 删除
- (void)deleBtnAction:(UIButton *)sender
{
    UIView *bottomView = (UIView *)[self.view viewWithTag:10051];
    if (selectGoods.count == 0) {
        [TCProgressHUD showMessage:@"请至少选择一款商品"];
    }else{
        NSMutableArray * array1 = [NSMutableArray array]; // create a Mutable array
        for (int i = 0; i < selectGoods.count ; i++) {
            TCShopGoodsModel *model = [[TCShopGoodsModel alloc]init];
            model = selectGoods[i];
            
            [array1 addObject:model.shopGoodsID];
        }
        NSString *joinedString = [array1 componentsJoinedByString:@","];
        
        NSLog(@"joinedString is %@", joinedString);
        // 删除接口
        NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
        NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
        
        NSDictionary *dic = @{@"ids":joinedString,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *parameters = @{@"ids":joinedString,@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
        
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"204004"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            //成功
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                if ([type isEqualToString:@"1"]){
                    [self questGoods:@"1"];  //下架
                } else if ([type isEqualToString:@"3"]){
                    [self questGoods:@"3"];  //上架
                }
            }
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}

#pragma mark -- 全选的点击事件
- (void)allSeleBtnAction:(UIButton *)sender
{
    NSLog(@"全选");
 //点击全选时，把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    sender.selected = !sender.selected;
    isSelect = sender.selected;

    //如果选择了
    if (isSelect) {
        for (TCShopGoodsModel *model in self.goodsArr) {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    //刷新
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

@end
