//
//  TCSeleCateViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSeleCateViewController.h"
#import "TCSeleCateView.h"
#import "TCAddCategoryViewController.h" //添加品类

@interface TCSeleCateViewController ()
@property (nonatomic, strong) TCSeleCateView *seleCateView;
@property (nonatomic, strong) NSMutableArray *myArray; //自定义
@property (nonatomic, strong) NSMutableArray *recommendArr; //推荐
@property (nonatomic, strong) NSArray *zongscates; //推荐总
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, assign) CGFloat hightView;
@end

@implementation TCSeleCateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择品类";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    self.userdefault = [NSUserDefaults standardUserDefaults];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxinList) name:@"shuaxinCateList" object:nil];
    self.myArray = [NSMutableArray array];
    self.recommendArr = [NSMutableArray array];
    
    //请求接口
    [self createQuest];

    
    //创建下面的按钮
    [self bottomView];

    // Do any additional setup after loading the view.
}

//传过来就刷新
- (void)shuaxinList
{
    [self createQuest];
}
//请求接口
- (void)createQuest
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self.myArray removeAllObjects];
    [self.recommendArr removeAllObjects];
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"shopid":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"shopid":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"203027"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            //推荐的
            NSArray *goodscates = jsonDic[@"data"][@"goodscates"][@"list"];
            //自定义的
            NSArray *shopcates = jsonDic[@"data"][@"shopcates"][@"list"];
            
            //一会查询
            self.zongscates = [goodscates arrayByAddingObjectsFromArray:shopcates]; ;
            
            //获取数据 推荐的
            for (NSDictionary *dic in goodscates) {
                [self.recommendArr addObject:dic[@"name"]];
            }
            
            //自定义的
            for (NSDictionary *dict in shopcates) {
                [self.myArray addObject:dict[@"name"]];
            }
            
            [self createScoller];
            
            NSLog(@"%@ %@",self.recommendArr,self.myArray);
            
        } else {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];
    }];
}

//创建滚动视图
- (void)createScoller
{
    //创建scrollview
    _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 48 - 64)];
    _scroller.backgroundColor = TCBgColor;
    _scroller.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroller];
    [_scroller addSubview:self.seleCateView];

    
    _scroller.contentSize = CGSizeMake(WIDHT, _hightView);
}

- (TCSeleCateView *)seleCateView
{
    if (!_seleCateView) {
        self.seleCateView = [[TCSeleCateView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT) recommendArr:self.recommendArr myArray:self.myArray];
        _hightView = self.seleCateView.viewHight;
        __weak TCSeleCateViewController *weakSelf = self;
        _seleCateView.tapAction = ^(NSString *str) {
            [weakSelf pushToSearchResultWithSearchStr:str];
        };
    }
    return _seleCateView;
}


//下方的按钮
- (void)bottomView
{
    UIButton *bottomBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    bottomBtn.frame = CGRectMake(0, HEIGHT - 48 - 64, WIDHT, 48);
    bottomBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    [bottomBtn setTitle:@"新增品类" forState:(UIControlStateNormal)];
    [bottomBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [bottomBtn addTarget:self action:@selector(bottomAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
}

#pragma mark -- 添加品类
- (void)bottomAction:(UIButton *)sender
{
    TCAddCategoryViewController *addCateVC = [[TCAddCategoryViewController alloc] init];
    addCateVC.isAddGoods = YES; //是从添加商品来的
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCateVC animated:YES];
}

- (void)pushToSearchResultWithSearchStr:(NSString *)str
{
    NSString *goodsID;
   //遍历数组
    for (int i = 0; i < self.zongscates.count; i ++){
        if ([self.zongscates[i][@"name"] isEqualToString:str]){
            goodsID = self.zongscates[i][@"goodscateid"];
        }
    }
    //通知传值怎么样
    NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:str,@"textOne",goodsID,@"textTwo",nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"addCatetongzhi" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
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
