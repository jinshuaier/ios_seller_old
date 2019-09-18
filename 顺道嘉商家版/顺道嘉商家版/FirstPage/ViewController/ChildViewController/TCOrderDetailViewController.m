//
//  TCOrderDetailViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/3.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderDetailViewController.h"
#import "TCorderLTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "TCGoodsNumTableViewCell.h"
#import "HggBigImage.h"

@interface TCOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource,MFMessageComposeViewControllerDelegate>
{
    NSString *messageStr; //发送短信的内容
    UILabel *messLabel;
    UILabel *messLabel_two;
    BOOL isSclect;
    CGRect cellHight_one; //备注
    CGRect cellHight_two; //商品
    CGRect cellHight_three; //纠纷
}
@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic, strong) UIView *ziquView;//门店自取view
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UILabel *ziqulb;//自选订单等。。。
@property (nonatomic, strong) UILabel *getTimelb;//送达时间
@property (nonatomic, strong) UILabel *nameLb;//姓名
@property (nonatomic, strong) UILabel *addressLb;//地址
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UILabel *shangpinje;//商品金额
@property (nonatomic, strong) UILabel *youhuijine;//优惠金额
@property (nonatomic, strong) UILabel *peisongfei;//配送费
@property (nonatomic, strong) UILabel *orderjine;//订单金额
@property (nonatomic, strong) UITextView *beizhuTV;//备注
@property (nonatomic, strong) UILabel *ordernum;//订单编号
@property (nonatomic, strong) UILabel *xiadantime;//下单时间
@property (nonatomic, strong) UILabel *zhifufangshi;//支付方式
@property (nonatomic, strong) UILabel *wanchengshijian;//完成时间
@property (nonatomic, strong) UIButton *leftBtn;//底部左侧按钮
@property (nonatomic, strong) UIButton *rightBtn;//底部右侧按钮
@property (nonatomic, strong) UIButton *bigBtn;//底部大按钮
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *phontNum;//用来存放订单联系方式
@property (nonatomic, assign) NSInteger shopNum;//用来存放订单中商品个数
@property (nonatomic, strong) UIView *bottomView;//底部的view
@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *timeStr;

//设置定时器
@property (nonatomic, strong) NSTimer *timer;
@property (assign, nonatomic) long int timeCount;

//背景颜色
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextView *tww;
@property (nonatomic, strong) UIView *juview;

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *goodsArray; //商品的数组
@property (nonatomic, strong) NSMutableArray *countArr; //优惠的数组
@property (nonatomic, strong) NSString *stateStr; //订单的状态
@property (nonatomic, strong) NSString *issueStatusStr; //纠纷的状态
@property (nonatomic, strong) NSMutableArray *issueArr; //是否纠纷图片


@end

@implementation TCOrderDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    self.tabBarController.tabBar.hidden= YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if([self.typeStr isEqualToString:@"0"]){
        //左边导航栏的按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12*WIDHTSCALE, 20*HEIGHTSCALE)];
        // Add your action to your button
        [leftButton addTarget:self action:@selector(barButtonItemsao:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
        UIBarButtonItem *barleftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = barleftBtn;
    }
    [self.timer invalidate];
}

- (void)setTime{
    //获取当前时间
    NSDate *datanow = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取当前时间戳
    long int curTime = (long)[datanow timeIntervalSince1970];
    //    NSLog(@"dateString:%@   %ld",dateString, curTime);
    
    //获取订单时间
    NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"endTime"]];
    NSDate *ordert = [dateFormatter dateFromString:str];
    //获取订单时间
    long int orderTime = (long)[ordert timeIntervalSince1970];
    //    NSLog(@"订单时间 %@  %ld", str, orderTime);
    
    //获取时间差
    long int cha = orderTime - curTime;
    
    if (cha > 0) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
    }else{
        NSLog(@"没有了");
        self.timeStr = [NSString stringWithFormat:@"%d",0];
    }
}

//倒计时
- (void)reduceTime:(NSTimer *)coderTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        
        //停止定时器
        [self.timer invalidate];
    }else{
        
        self.timeStr = [NSString stringWithFormat:@"%ld",self.timeCount];
    }
}


- (void)barButtonItemsao:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"订单id %@", _oid);
   
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = self.statusName;
    //把导航栏的左边箭头后面的字体去掉
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    //导航栏的左边箭头为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    _lineColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    _userdefault = [NSUserDefaults standardUserDefaults];
    self.goodsArray = [NSMutableArray array];
    self.countArr = [NSMutableArray array];
    self.issueArr = [NSMutableArray array];
    //请求
    [self request];
}

//请求
- (void)request{
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];

    if(_oid == nil || shopID == nil){
        NSLog(@"hh");
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        NSDictionary *dic = @{@"orderId":_oid,@"shopId":shopID};
        NSString *singStr = [TCServerSecret signStr:dic];
        NSDictionary *parameters = @{@"orderId":_oid,@"shopId":shopID,@"sign":singStr};
        NSDictionary *dicc = [TCServerSecret report:parameters];
      
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202002"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            if (jsonDic[@"data"]) {
                _dataDic = jsonDic[@"data"];

                NSArray *goodArr = jsonDic[@"data"][@"goods"];
                NSArray *countArr = jsonDic[@"data"][@"discountArr"];
                //商品
                [self.goodsArray removeAllObjects];
                for (NSDictionary *dic in goodArr) {
                    [self.goodsArray addObject:dic];
                }
                //满减优惠
                for (NSDictionary *dic1 in countArr) {
                    [self.countArr addObject:dic1];
                }
                //查看状态
                self.stateStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"status"]];
                self.title = jsonDic[@"data"][@"statusName"];
                //纠纷的状态
                self.issueStatusStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"issueStatus"]];
                
                //纠纷
                NSArray *issuesssArr = jsonDic[@"data"][@"issue"];
                if (issuesssArr.count == 0){
                    NSLog(@"无");
                } else {
                    self.issueArr = jsonDic[@"data"][@"issue"][@"image"];
                }
               // 配置页面
                [self createUI];
            
            } else {
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            [self.listTableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            nil;
            [SVProgressHUD dismiss];
        }];
    }
}

//配置页面
- (void)createUI{
    //声明tableView
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    self.listTableView.backgroundColor = TCBgColor;
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTableView];
}

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return self.goodsArray.count + 1;
    } else if (section == 2){
        return 3 + self.countArr.count;
    } else if (section == 3){
        
        //根据状态判断
        if ([self.stateStr isEqualToString:@"1"] || [self.stateStr isEqualToString:@"2"] || [self.stateStr isEqualToString:@"3"]){ //待结单 、 待发货 、已发货
            return 4;
        } else if ([self.stateStr isEqualToString:@"4"]){ //送达
            return 5;
        } else if ([self.stateStr isEqualToString:@"5"]){
            return 6;
        }
        return 6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *issueStatus = [NSString stringWithFormat:@"%@",self.dataDic[@"issueStatus"]];
    if ([issueStatus isEqualToString:@"1"]){
        if (section == 0){
            NSArray *arr = self.dataDic[@"issue"][@"image"];
            if (arr.count == 0){
                return 133;
            } else {
                return 182;
            }
        }
    } else if ([self.stateStr isEqualToString:@"-2"]){
        if (section == 0){
            return 45;
        }
    } else {
        return 10;
    }
    
    if (section == 2){
        return 0.1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *issueStatus = [NSString stringWithFormat:@"%@",self.dataDic[@"issueStatus"]];
    if (section == 3){
        if ([issueStatus isEqualToString:@"1"]){
            return 67;
        } else {
        if ([self.stateStr isEqualToString:@"1"]){
            return 174;
        } else if ([self.stateStr isEqualToString:@"2"]){
            return 107;
        } else if ([self.stateStr isEqualToString:@"3"]){
            return 107;
        }
        return 40;
        }
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        return cellHight_one.size.height;
    } else if (indexPath.section == 1){
        if (indexPath.row == 0){
            return 91;
        } else {
            return cellHight_two.size.height;
        }
    } else if (indexPath.section == 2){
        if (indexPath.row == 2 + self.countArr.count){ //总价
            return 56;
        }
        return 44;
    } else if (indexPath.section == 3){
        if (indexPath.row == 0){
            return 54;
        } else {
            return 44;
        }
    }
    return 313;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = TCBgColor;
    headView.frame =CGRectMake(0, 0, WIDHT, 0);
    
    NSString *issueStatus = [NSString stringWithFormat:@"%@",self.dataDic[@"issueStatus"]];
    if ([issueStatus isEqualToString:@"1"]){
        if (section == 0){
            headView.frame =CGRectMake(0, 0, WIDHT,  123);
            //创建背景View
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            backView.frame =CGRectMake(10, 10, WIDHT - 20,  123);
            [headView addSubview:backView];
            
            //退款理由
            UILabel *tuireaon = [UILabel publicLab:@"退款理由" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
            tuireaon.frame = CGRectMake(10, 15, 60, 14);
            [backView addSubview:tuireaon];
            
            //        //退款灰框
            UIView *garyView = [[UIView alloc] init];
            garyView.frame = CGRectMake(10, CGRectGetMaxY(tuireaon.frame) + 10, WIDHT - 20 - 20 , 79);
            garyView.backgroundColor = TCUIColorFromRGB(0xF9F9F9);
            [backView addSubview:garyView];
            
            //退款的原因
            UILabel *tuiPriceLabel = [UILabel publicLab:self.dataDic[@"issue"][@"remark"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
            tuiPriceLabel.frame = CGRectMake(10, 10, WIDHT - 20 -20 -20, 50);
            CGSize size5 = [tuiPriceLabel sizeThatFits:CGSizeMake(WIDHT - 20 - 20 - 20, MAXFLOAT)];
            tuiPriceLabel.frame = CGRectMake(10, 10, WIDHT - 20 - 20 - 20, size5.height);
            garyView.frame = CGRectMake(10, CGRectGetMaxY(tuireaon.frame) + 10, WIDHT - 20 - 20, CGRectGetMaxY(tuiPriceLabel.frame) + 10);
            [garyView addSubview:tuiPriceLabel];
            headView.frame =CGRectMake(0, 0, WIDHT, CGRectGetMaxY(garyView.frame) + 15);
            
            
            //退款带有图片
            NSArray *arr = self.dataDic[@"issue"][@"image"];
            if (arr.count == 0){
                backView.frame =CGRectMake(10, 10, WIDHT - 20,  123);
                headView.frame =CGRectMake(0, 0, WIDHT,  123);
            } else {
                //创建图片
                for (int i = 0; i < arr.count; i ++) {
                    UIImageView *image = [[UIImageView alloc] init];
                    image.frame = CGRectMake(10 + 56 * i, CGRectGetMaxY(garyView.frame) + 15, 56, 56);
                    [image sd_setImageWithURL:[NSURL URLWithString:arr[i][@"src"]] placeholderImage:[UIImage imageNamed:@""]];
                    [backView addSubview:image];
                    backView.frame =CGRectMake(10, 10, WIDHT - 20,  172);
                    headView.frame =CGRectMake(0, 0, WIDHT,  172);
                }
            }
        }
    } else if ([self.stateStr isEqualToString:@"-2"]){
        if (section == 0){
            headView.frame =CGRectMake(0, 0, WIDHT,  35);
            //创建背景View
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            backView.frame =CGRectMake(10, 10, WIDHT - 20,  35);
            [headView addSubview:backView];
            
            //关闭原因
            UILabel *closeLabel = [UILabel publicLab:@"关闭原因:" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
            closeLabel.frame = CGRectMake(10, 0, 100, 35);
            [backView addSubview:closeLabel];
            
            //根据colse判断
            NSString *closeStr = [NSString stringWithFormat:@"%@",self.dataDic[@"close"]];
            NSString *resonStr;
            if ([closeStr isEqualToString:@"0"]){
                resonStr = @"未支付";
            } else if ([closeStr isEqualToString:@"1"]){
                resonStr = @"支付超时";
            } else if ([closeStr isEqualToString:@"2"]){
                resonStr = @"接单超时";
            } else if ([closeStr isEqualToString:@"3"]){
                resonStr = @"商家拒单";
            } else if ([closeStr isEqualToString:@"4"]){
                resonStr = @"用户取消";
            }
            //关闭原因的状态
            UILabel *closestateLabel = [UILabel publicLab:resonStr textColor:TCUIColorFromRGB(0xFF5544) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
            closestateLabel.frame = CGRectMake(WIDHT - 20 - 10 - 200, 0, 200, 35);
            [backView addSubview:closestateLabel];
        }
        
    }

        return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 40)];
    
    if (section == 3){
        
        NSString *issueStatus = [NSString stringWithFormat:@"%@",self.dataDic[@"issueStatus"]];
        if ([issueStatus isEqualToString:@"1"]){
            NSLog(@"哈哈哈哈");
            footerView.frame = CGRectMake(0, 0, WIDHT, 67);

            //同意退款的按钮
            UIButton *ordertuiBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            ordertuiBtn.frame = CGRectMake(0, 20, WIDHT/2, 47);
            [ordertuiBtn setTitle:@"同意退款" forState:(UIControlStateNormal)];
            ordertuiBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            [ordertuiBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
            [ordertuiBtn addTarget:self action:@selector(ordertuiBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
            ordertuiBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
            [footerView addSubview:ordertuiBtn];
            //
            UIButton *orderjujueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            orderjujueBtn.frame = CGRectMake(WIDHT/2, 20, WIDHT/2, 47);
            [orderjujueBtn setTitle:@"拒绝退款" forState:(UIControlStateNormal)];
            orderjujueBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            [orderjujueBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
            [orderjujueBtn addTarget:self action:@selector(orderjujueBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
            orderjujueBtn.layer.borderWidth = 1;
            orderjujueBtn.layer.masksToBounds = YES;
            orderjujueBtn.layer.borderColor = TCUIColorFromRGB(0x53C3C3).CGColor;
            orderjujueBtn.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            [footerView addSubview:orderjujueBtn];
            
        } else if ([issueStatus isEqualToString:@"2"]) {
            
        } else {
            
            if ([self.stateStr isEqualToString:@"1"]){ //待结单
                footerView.frame = CGRectMake(0, 0, WIDHT, 174);
                
                //确认接单的按钮
                UIButton *orderRecBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                orderRecBtn.frame = CGRectMake(10, 40, WIDHT - 20, 47);
                [orderRecBtn setTitle:@"确认接单" forState:(UIControlStateNormal)];
                orderRecBtn.layer.cornerRadius = 5;
                orderRecBtn.layer.masksToBounds = YES;
                orderRecBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
                [orderRecBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
                [orderRecBtn addTarget:self action:@selector(orderRecAction:) forControlEvents:(UIControlEventTouchUpInside)];
                orderRecBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
                [footerView addSubview:orderRecBtn];
                
                //数据返回的字符串
                //拒单
                [self setTime];
                
                UIButton *ordersalesBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                ordersalesBtn.frame = CGRectMake(10, CGRectGetMaxY(orderRecBtn.frame) + 20, WIDHT - 20, 47);
                [ordersalesBtn setTitle:[NSString stringWithFormat:@"拒单"] forState:(UIControlStateNormal)];
                ordersalesBtn.layer.cornerRadius = 5;
                ordersalesBtn.layer.borderWidth = 1;
                ordersalesBtn.layer.borderColor = TCUIColorFromRGB(0x53C3C3).CGColor;
                ordersalesBtn.layer.masksToBounds = YES;
                ordersalesBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
                [ordersalesBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
                [ordersalesBtn addTarget:self action:@selector(ordersaleAction:) forControlEvents:(UIControlEventTouchUpInside)];
                ordersalesBtn.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
                [footerView addSubview:ordersalesBtn];
            }
            else if ([self.stateStr isEqualToString:@"2"]){
                footerView.frame = CGRectMake(0, 0, WIDHT, 107);
                
                //确认接单的按钮
                UIButton *peiBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                peiBtn.frame = CGRectMake(10, 40, WIDHT - 20, 47);
                [peiBtn setTitle:@"确认配送" forState:(UIControlStateNormal)];
                if ([self.typeS isEqualToString:@"2"]) {
                    [peiBtn setTitle:@"确认到达" forState:(UIControlStateNormal)];
                }
                peiBtn.layer.cornerRadius = 5;
                peiBtn.layer.masksToBounds = YES;
                peiBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
                [peiBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
                [peiBtn addTarget:self action:@selector(peisong) forControlEvents:(UIControlEventTouchUpInside)];
                peiBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
                [footerView addSubview:peiBtn];
            } else if ([self.stateStr isEqualToString:@"3"]) { //已发货
                UIButton *yifahuoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                yifahuoBtn.frame = CGRectMake(10, 40, WIDHT - 20, 47);
                [yifahuoBtn setTitle:@"确认送达" forState:(UIControlStateNormal)];
                if ([self.typeS isEqualToString:@"2"]) {
                    [yifahuoBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
                }
                yifahuoBtn.layer.cornerRadius = 5;
                yifahuoBtn.layer.masksToBounds = YES;
                yifahuoBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
                [yifahuoBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
                [yifahuoBtn addTarget:self action:@selector(querensongda) forControlEvents:(UIControlEventTouchUpInside)];
                yifahuoBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
                [footerView addSubview:yifahuoBtn];
            }
        }
    }
    
    footerView.backgroundColor = TCBgColor;
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = TCBgColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    //背景view
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    backView.frame =CGRectMake(10, 0, WIDHT - 20, 313);
    [cell.contentView addSubview:backView];
    
    if (indexPath.section == 0){
        //送货信息
        UILabel *messGoods = [UILabel publicLab:@"送货信息" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        messGoods.frame = CGRectMake(10, 15, 60, 14);
        [backView addSubview:messGoods];
        //送达时间
        UILabel *sendTimeLabel = [UILabel publicLab:[NSString stringWithFormat:@"%@之前送达",_dataDic[@"sendTime"]] textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
        sendTimeLabel.frame = CGRectMake(CGRectGetMaxX(messGoods.frame), 15, WIDHT - 20 - 10 - (CGRectGetMaxX(messGoods.frame)), 12);
        [backView addSubview:sendTimeLabel];
        //商家是否配送
        UILabel *deveLabel = [UILabel publicLab:@"商家配送" textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
        deveLabel.frame = CGRectMake(0, CGRectGetMaxY(sendTimeLabel.frame) + 10, WIDHT - 20 - 10, 14);
        [backView addSubview:deveLabel];
        //状态
        if ([self.stateStr isEqualToString:@"1"] || [self.stateStr isEqualToString:@"2"] || [self.stateStr isEqualToString:@"3"] ){
            sendTimeLabel.hidden = NO;
            deveLabel.frame = CGRectMake(0, CGRectGetMaxY(sendTimeLabel.frame) + 10, WIDHT - 20 - 10, 14);
            
        } else {
            sendTimeLabel.hidden = YES;
            deveLabel.frame = CGRectMake(CGRectGetMaxX(messGoods.frame), 15, WIDHT - 20 - 10 - (CGRectGetMaxX(messGoods.frame)), 14);
        }
        
        //下划线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = TCLineColor;
        lineView.frame = CGRectMake(10, CGRectGetMaxY(deveLabel.frame) + 14, WIDHT - 20 - 20, 1);
        [backView addSubview:lineView];
        //姓名
        UILabel *nameLabel = [UILabel publicLab:_dataDic[@"address"][@"name"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        nameLabel.frame = CGRectMake(12, 15 + CGRectGetMaxY(lineView.frame), 45, 15);
        CGSize size = [nameLabel sizeThatFits:CGSizeMake(WIDHT - 20 - 20, 15)];
        nameLabel.frame = CGRectMake(12, 15 + CGRectGetMaxY(lineView.frame),size.width, 15 );
        [backView addSubview:nameLabel];
        //电话
        UILabel *telLabel = [UILabel publicLab:_dataDic[@"address"][@"mobile"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
        telLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 20, CGRectGetMaxY(lineView.frame) + 15, WIDHT - 20 - 20 - (CGRectGetMaxX(nameLabel.frame) + 20), 15);
        [backView addSubview:telLabel];
        //地址
        NSString *adressStr = [_dataDic[@"address"][@"locaddress"] stringByAppendingString:_dataDic[@"address"][@"address"]];
        UILabel *adressLabel = [UILabel publicLab:adressStr textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        adressLabel.frame = CGRectMake(10, CGRectGetMaxY(nameLabel.frame) + 10, WIDHT - 20 - 20, 36);
        CGSize size1 = [adressLabel sizeThatFits:CGSizeMake(WIDHT - 20 - 20, MAXFLOAT)];
        adressLabel.frame = CGRectMake(10, CGRectGetMaxY(nameLabel.frame) + 10, WIDHT - 20 - 20, size1.height);
        [backView addSubview:adressLabel];
        //下划线
        UIView *line_twoView = [[UIView alloc] init];
        line_twoView.backgroundColor = TCLineColor;
        line_twoView.frame = CGRectMake(0, CGRectGetMaxY(adressLabel.frame) + 14, WIDHT - 20, 1);
        [backView addSubview:line_twoView];
        //电话view
        UIView *phoneView = [[UIView alloc] init];
        phoneView.frame = CGRectMake(0, CGRectGetMaxY(line_twoView.frame), WIDHT - 20, 81);
        [backView addSubview:phoneView];
        //发短信，打电话
        //短信和电话的图标
        NSArray *imageArr = @[@"发短信图标",@"打电话图标"];
        NSArray *titleArr = @[@"发短信",@"打电话"];
        for (int i = 0; i < imageArr.count; i ++) {
            //细线
            UIView *line_threeView = [[UIView alloc] init];
            line_threeView.frame = CGRectMake((WIDHT - 20)/2, (81 - 43)/2, 2, 43);
            line_threeView.backgroundColor = TCLineColor;
            [phoneView addSubview:line_threeView];

            //图片
            UIImageView *image = [[UIImageView alloc] init];
            image.image = [UIImage imageNamed:imageArr[i]];
            image.tag = 1000 +i;
            image.userInteractionEnabled = YES;
            image.frame = CGRectMake(((WIDHT - 20)/2 - 40)/2 + (WIDHT - 20)/2 * i, 11, 40, 40);
            [phoneView addSubview:image];
            
            //加入手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [image addGestureRecognizer:tap];
            
            //文字
            UILabel *phTitleLabel = [UILabel publicLab:titleArr[i] textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
            phTitleLabel.frame = CGRectMake((WIDHT - 20)/2 * i, CGRectGetMaxY(image.frame) + 5, (WIDHT - 20)/2, 14);
            [phoneView addSubview:phTitleLabel];
            //下划线
            UIView *line_fourView = [[UIView alloc] init];
            line_fourView.backgroundColor = TCLineColor;
            line_fourView.frame = CGRectMake(0, CGRectGetMaxY(phoneView.frame), WIDHT - 20, 1);
            [backView addSubview:line_fourView];
        }
        //备注
        UILabel *ramkLabel = [UILabel publicLab:@"备注" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        ramkLabel.frame = CGRectMake(10, CGRectGetMaxY(phoneView.frame) + 25, 28, 18);
        [backView addSubview:ramkLabel];
        //备注背景
        UIView *garyBackView = [[UIView alloc] init];
        garyBackView.backgroundColor = TCUIColorFromRGB(0xF9F9F9);
        garyBackView.frame = CGRectMake(CGRectGetMaxX(ramkLabel.frame) + 10, CGRectGetMaxY(phoneView.frame) + 15, WIDHT - 20 - 10 - (CGRectGetMaxX(ramkLabel.frame) + 10), 57);
        [backView addSubview:garyBackView];
        //备注信息
        UILabel *mesRamkLabel = [UILabel publicLab:@"这是备注信息这是备注信息这是备注信息这是备注信息这是备注信息这" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        if ([_dataDic[@"remark"] isEqualToString:@""]){
            mesRamkLabel.text = @"暂无备注";
        } else {
            mesRamkLabel.text = _dataDic[@"remark"];
        }
        mesRamkLabel.frame =CGRectMake(10, 10, garyBackView.frame.size.width - 20, 36);
        CGSize size2 = [adressLabel sizeThatFits:CGSizeMake(garyBackView.frame.size.width - 20, MAXFLOAT)];
        mesRamkLabel.frame = CGRectMake(10,  10, garyBackView.frame.size.width - 20, size2.height);
        garyBackView.frame = CGRectMake(CGRectGetMaxX(ramkLabel.frame) + 10, CGRectGetMaxY(phoneView.frame) + 15, WIDHT - 20 - 10 - (CGRectGetMaxX(ramkLabel.frame) + 10), CGRectGetMaxY(mesRamkLabel.frame) + 10);
        [garyBackView addSubview:mesRamkLabel];
        
        backView.frame = CGRectMake(10, 10, WIDHT - 20, CGRectGetMaxY(garyBackView.frame) + 15);
        cellHight_one.size.height = CGRectGetMaxY(backView.frame);
        
    } else if (indexPath.section == 1){  //商品的详情
      
        if (indexPath.row == 0){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 91);
            //订单商品数量
            UILabel *numOrderLabel = [UILabel publicLab:[NSString stringWithFormat:@"订单商品(%@)",_dataDic[@"goodsNum"]] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
            numOrderLabel.frame = CGRectMake(10, 0, WIDHT - 20, 54);
            [backView addSubview:numOrderLabel];
            //下划线
            UIView *line_fivView = [[UIView alloc] init];
            line_fivView.frame = CGRectMake(0, CGRectGetMaxY(numOrderLabel.frame), WIDHT - 20, 1);
            line_fivView.backgroundColor = TCLineColor;
            [backView addSubview:line_fivView];
            //商品名称、数量、价格
            UILabel *nameTitleLabel = [UILabel publicLab:@"商品名称、规格" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            nameTitleLabel.frame = CGRectMake(10, CGRectGetMaxY(line_fivView.frame), 204, 36);
            [backView addSubview:nameTitleLabel];
            //价格
            UILabel *priceTitleLabel = [UILabel publicLab:@"价格" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            priceTitleLabel.frame = CGRectMake(WIDHT - 20 - 10 - 38, CGRectGetMaxY(line_fivView.frame), 28, 36);
            [backView addSubview:priceTitleLabel];
            //数量
            UILabel *numTitleLabel = [UILabel publicLab:@"数量" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            numTitleLabel.frame = CGRectMake(CGRectGetMaxX(priceTitleLabel.frame) - 28 - 28 - 30, CGRectGetMaxY(line_fivView.frame), 28, 36);
            [backView addSubview:numTitleLabel];
            
        } else { //这里就是商品的展示了
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 91);
            backView.backgroundColor = [UIColor redColor];
            //灰色背景
            UIView *garyView = [[UIView alloc] init];
            garyView.backgroundColor = TCUIColorFromRGB(0xF9F9F9);
            garyView.frame = CGRectMake(0, 0, WIDHT - 20, 70);
            [backView addSubview:garyView];
            
            //商品图片
            UIImageView *goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 64, 64)];
            goodsImage.userInteractionEnabled = YES;
            goodsImage.contentMode = UIViewContentModeScaleAspectFit;
            //goodsImage.image = [UIImage imageNamed:@"关于我们-顺道嘉图标"];
            [goodsImage sd_setImageWithURL:[NSURL URLWithString:self.goodsArray[indexPath.row - 1][@"src"]] placeholderImage:[UIImage imageNamed:@"占位图（方形）"]];
            //加入手势
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            [goodsImage addGestureRecognizer:tapImage];
            UIView *singleTapView = [tapImage view];
            singleTapView.tag = indexPath.row - 1;
            [garyView addSubview:goodsImage];
            //商品名称
            UILabel *goodsNameLabel = [UILabel publicLab:self.goodsArray[indexPath.row - 1][@"name"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsNameLabel.frame = CGRectMake(CGRectGetMaxX(goodsImage.frame) + 20, 15, 150, 36);
             CGSize size3 = [goodsNameLabel sizeThatFits:CGSizeMake(150, MAXFLOAT)];
            goodsNameLabel.frame = CGRectMake(CGRectGetMaxX(goodsImage.frame) + 20, 15, 150, size3.height);
            [garyView addSubview:goodsNameLabel];
            //商品的价格
            UILabel *goodsPriceLabel = [UILabel publicLab:[NSString stringWithFormat:@"¥%@",self.goodsArray[indexPath.row - 1][@"price"]] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsPriceLabel.frame = CGRectMake(WIDHT - 20 - 10 - 45 , 15, 45 + 40, 18);
            [garyView addSubview:goodsPriceLabel];
            //数量
            UILabel *goodsNumLabel = [UILabel publicLab:self.goodsArray[indexPath.row - 1][@"amount"] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsNumLabel.frame = CGRectMake(CGRectGetMaxX(goodsPriceLabel.frame) - goodsPriceLabel.frame.size.width - 30 - 20, 15, 20, 18);
            [garyView addSubview:goodsNumLabel];
            //规格
            UILabel *goodsSpecLabel = [UILabel publicLab:self.goodsArray[indexPath.row - 1][@"spec"] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsSpecLabel.frame = CGRectMake(CGRectGetMaxX(goodsImage.frame) + 20, CGRectGetMaxY(goodsNameLabel.frame) + 10, WIDHT - 20 - 20, 12);
            [garyView addSubview:goodsSpecLabel];
            garyView.frame = CGRectMake(0, 0, WIDHT - 20, CGRectGetMaxY(goodsSpecLabel.frame) + 15);
            //小白条
            UIView *view_sixLine = [[UIView alloc] init];
            view_sixLine.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            view_sixLine.frame = CGRectMake(0, CGRectGetMaxY(garyView.frame), WIDHT - 20, 2);
            [backView addSubview:view_sixLine];
            backView.frame = CGRectMake(10, 0, WIDHT - 20, CGRectGetMaxY(view_sixLine.frame));
            cellHight_two.size.height =  CGRectGetMaxY(view_sixLine.frame);
        }
    } else if (indexPath.section == 2){  //金钱
        backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);

        if (indexPath.row == 0){
            //商品金额
            UILabel *goodsTileLabel = [UILabel publicLab:@"商品金额" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsTileLabel.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:goodsTileLabel];
            //金额
            UILabel *goodsPriLabel = [UILabel publicLab:[NSString stringWithFormat:@"¥%@",_dataDic[@"originalPrice"]] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            goodsPriLabel.frame = CGRectMake(WIDHT - 20 - 10 - WIDHT/2, 15, WIDHT/2, 18);
            [backView addSubview:goodsPriLabel];
        } else if (indexPath.row > 0 && indexPath.row < self.countArr.count + 1){
            //小图标
            UILabel *jianLabel = [UILabel publicLab:@"减" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:10 numberOfLines:0];
            jianLabel.frame = CGRectMake(8, (44 - 16)/2, 16, 16);
            jianLabel.layer.cornerRadius = 4;
            jianLabel.layer.masksToBounds = YES;
            jianLabel.backgroundColor = TCUIColorFromRGB(0xF99E20);
            [backView addSubview:jianLabel];
            //满减优惠
            UILabel *countTileLabel = [UILabel publicLab:self.countArr[indexPath.row - 1][@"typeName"] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            countTileLabel.frame = CGRectMake(CGRectGetMaxX(jianLabel.frame)  + 6, 0, 56, 44);
            [backView addSubview:countTileLabel];
            //金额
            UILabel *countPriLabel = [UILabel publicLab:[NSString stringWithFormat:@"¥%@",self.countArr[indexPath.row - 1][@"price"]] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            countPriLabel.frame = CGRectMake(WIDHT - 20 - 10 - WIDHT/2, 15, WIDHT/2, 18);
            [backView addSubview:countPriLabel];
        } else if (indexPath.row == self.countArr.count + 1){
            //配送费
            UILabel *peiTileLabel = [UILabel publicLab:@"配送费" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            peiTileLabel.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:peiTileLabel];
            //金额
            UILabel *peiPriLabel = [UILabel publicLab:[NSString stringWithFormat:@"¥%@",_dataDic[@"deliverPrice"]] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            peiPriLabel.frame = CGRectMake(WIDHT - 20 - 10 - 100, 0, 100, 44);
            [backView addSubview:peiPriLabel];
            //线
            UIView *line_sevView = [[UIView alloc] init];
            line_sevView.frame = CGRectMake(0, CGRectGetMaxY(peiPriLabel.frame), WIDHT - 20, 1);
            line_sevView.backgroundColor = TCLineColor;
            [backView addSubview:line_sevView];
        } else {
            
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 56);
            //总价
            NSString *str = [NSString stringWithFormat:@"订单金额：¥%@",_dataDic[@"sellerMoney"]];
            UILabel *zongPriLabel = [UILabel publicLab:str textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            [self fuwenbenLabel:zongPriLabel FontNumber:[UIFont fontWithName:@"PingFangSC-Medium" size:14] AndRange:NSMakeRange(5, str.length - 5) AndColor:TCUIColorFromRGB(0xFF5544)];
            zongPriLabel.frame = CGRectMake(0, 0, WIDHT - 20 - 10, 56);
            [backView addSubview:zongPriLabel];
        }
    } else {  //最后的订单了
        if (indexPath.row == 0){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 54);
            //订单信息
            UILabel *orderLabel = [UILabel publicLab:@"订单信息" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            orderLabel.frame = CGRectMake(10, 0, 60, 54);
            [backView addSubview:orderLabel];
            //线
            UIView *line_hiView = [[UIView alloc] init];
            line_hiView.frame = CGRectMake(0, CGRectGetMaxY(orderLabel.frame), WIDHT - 20, 1);
            line_hiView.backgroundColor = TCLineColor;
            [backView addSubview:line_hiView];
        } else if (indexPath.row == 1) {
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);
            UILabel *label = [UILabel publicLab:@"订单编号" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            label.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:label];
            //详情
            UILabel *disLabel = [UILabel publicLab:_dataDic[@"ordersn"] textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            disLabel.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, WIDHT - 20 - 56 - 20, 44);
            [backView addSubview:disLabel];
            //细线
            UIView *line_viewv = [[UIView alloc] init];
            line_viewv.frame = CGRectMake(10, 44, WIDHT - 20 - 10, 1);
            line_viewv.backgroundColor = TCLineColor;
            [backView addSubview:line_viewv];
            
        } else if (indexPath.row == 2){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);
            UILabel *label = [UILabel publicLab:@"支付方式" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            label.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:label];
            //详情
            UILabel *disLabel = [UILabel publicLab:[NSString stringWithFormat:@"%@支付",_dataDic[@"payTypeName"]] textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            disLabel.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, WIDHT - 20 - 56 - 20, 44);
            [backView addSubview:disLabel];
            //细线
            UIView *line_viewv = [[UIView alloc] init];
            line_viewv.frame = CGRectMake(10, 44, WIDHT - 20 - 10, 1);
            line_viewv.backgroundColor = TCLineColor;
            [backView addSubview:line_viewv];
        } else if (indexPath.row == 3){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);
            UILabel *label = [UILabel publicLab:@"下单时间" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            label.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:label];
            //详情
            UILabel *disLabel = [UILabel publicLab:_dataDic[@"createTime"] textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            disLabel.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, WIDHT - 20 - 56 - 20, 44);
            [backView addSubview:disLabel];
            //细线
            UIView *line_viewv = [[UIView alloc] init];
            line_viewv.frame = CGRectMake(10, 44, WIDHT - 20 - 10, 1);
            line_viewv.backgroundColor = TCLineColor;
            [backView addSubview:line_viewv];
        } else if (indexPath.row == 4){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);
            UILabel *label = [UILabel publicLab:@"送达时间" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            label.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:label];
            //详情
            UILabel *disLabel = [UILabel publicLab:_dataDic[@"receiveTime"] textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            disLabel.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, WIDHT - 20 - 56 - 20, 44);
            [backView addSubview:disLabel];
            //细线
            UIView *line_viewv = [[UIView alloc] init];
            line_viewv.frame = CGRectMake(10, 44, WIDHT - 20 - 10, 1);
            line_viewv.backgroundColor = TCLineColor;
            [backView addSubview:line_viewv];
        } else if (indexPath.row == 5){
            backView.frame = CGRectMake(10, 0, WIDHT - 20, 44);
            UILabel *label = [UILabel publicLab:@"完成时间" textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            label.frame = CGRectMake(10, 0, 56, 44);
            [backView addSubview:label];
            //详情
            UILabel *disLabel = [UILabel publicLab:_dataDic[@"completeTime"] textColor:TCUIColorFromRGB(0x4C4C4C) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            disLabel.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, WIDHT - 20 - 56 - 20, 44);
            [backView addSubview:disLabel];
            //细线
            UIView *line_viewv = [[UIView alloc] init];
            line_viewv.frame = CGRectMake(10, 44, WIDHT - 20 - 10, 1);
            line_viewv.backgroundColor = TCLineColor;
            [backView addSubview:line_viewv];
        }
    }
    
    return cell;
}

//message的代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    //隐藏视图
    [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

//拒单事件
- (void)judan{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview: _backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_backView addGestureRecognizer: tap];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - 150 * HEIGHTSCALE, WIDHT - 40 * WIDHTSCALE, 300 * HEIGHTSCALE)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [_backView addSubview: view];
    _juview = view;

    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 30)];
    lb.text = @"拒单原因";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:18];
    [view addSubview: lb];
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, lb.frame.size.height, view.frame.size.width, 1)];
    lb1.backgroundColor = backGgray;
    [view addSubview: lb1];
    UITextView *tvw = [[UITextView alloc]initWithFrame:CGRectMake(10, lb1.frame.origin.y + 11, view.frame.size.width - 20, 150 * HEIGHTSCALE)];
    tvw.backgroundColor = backGgray;
    tvw.layer.cornerRadius = 5;
    tvw.text = @"十分抱歉，暂时无法为您配送！";
    [view addSubview: tvw];
    _tww = tvw;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = btnColors;
    btn.frame = CGRectMake(10, tvw.frame.origin.y + tvw.frame.size.height + 10, view.frame.size.width - 20, 48 * HEIGHTSCALE);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(get) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    [view addSubview: btn];

    view.frame = CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - (280 * HEIGHTSCALE / 2), WIDHT - 40 * WIDHTSCALE, 280 * HEIGHTSCALE);
}

- (void)get{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"操作中..."];
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"oid":_oid, @"terminal":@"ios", @"reason":_tww.text};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200017"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if ([jsonDic[@"retValue"] intValue] == 1) {
            [SVProgressHUD dismiss];
            [_backView removeFromSuperview];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"needRefresh" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}


- (void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *userInfo = [note userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if (HEIGHT - 280 * HEIGHTSCALE - height <= HEIGHT / 2 - (280 * HEIGHTSCALE / 2)) {
        _juview.frame = CGRectMake(20 * WIDHTSCALE, HEIGHT - 280 * HEIGHTSCALE - height, WIDHT - 40 * WIDHTSCALE, 280 * HEIGHTSCALE);
    }
}

- (void)keyboardWillHide{
    _juview.frame = CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - (280 * HEIGHTSCALE / 2), WIDHT - 40 * WIDHTSCALE, 280 * HEIGHTSCALE);
}

- (void)tap{
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
    }];
}

//更改订单状态
- (void)changeOidStatus:(NSString *)status{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"操作中..."];
    
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    
    NSDictionary *dic = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"orderid":self.oid,@"status":status};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"orderid":self.oid,@"sign":singStr,@"status":status};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201028"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        [self request];
        //状态更改完毕后 要求订单列表页面刷新
        [[NSNotificationCenter defaultCenter]postNotificationName:@"needRefresh" object:nil];
        [SVProgressHUD dismiss];
        [TCProgressHUD showMessage:jsonDic[@"msg"]];
    } failure:^(NSError *error) {
        nil;
    }];
}

//接受订单事件
- (void)jieshou{
    [self changeOidStatus:@"2"];
}

//二维码事件
- (void)code{
    NSLog(@"我的二维码");
    if(_backView){
        [_backView removeFromSuperview];
    }
    //创建背景颜色
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    _backView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);

    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    window.windowLevel = UIWindowLevelNormal;

    UIImageView *barcodeImage= [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - (WIDHT - 40 * WIDHTSCALE) / 2, WIDHT - 40 * WIDHTSCALE, WIDHT - 40 * WIDHTSCALE)];
//    [barcodeImage sd_setImageWithURL:[NSURL URLWithString: _dataDic[@"qrcode"]]];

    [barcodeImage sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"qrcode"]] placeholderImage:[UIImage imageNamed:@"shopmo.png"]];
    barcodeImage.userInteractionEnabled = YES;

    //给这张图片加个手势
    //添加一个手势
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    [window addGestureRecognizer:tapgesture];
    [_backView addSubview:barcodeImage];
    [window addSubview:_backView];
}

-(void)tapgesture
{
    [_backView removeFromSuperview];
}

#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
    }];
    
}
#pragma mark -- 按钮点击事件
-(void)caluseBtn:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
    }];
}

//打电话或者发短信
- (void)tap:(UITapGestureRecognizer *)tap
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    if ([singleTap view].tag == 1000){
        NSLog(@"发短信");
        if( [MFMessageComposeViewController canSendText] ){
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
            controller.recipients = [NSArray arrayWithObject:_dataDic[@"address"][@"mobile"]];
            controller.messageComposeDelegate = self;
            controller.navigationBar.tintColor = [UIColor redColor];
            [self presentViewController:controller animated:YES completion:nil];
            
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"顺道嘉短信"];//修改短信界面标题
        } else {
            [self alertWithTitle:@"提示信息" msg:@"请选择您要发送的内容"];
        }
    } else {
        NSLog(@"打电话");
        //拨打电话
        NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_dataDic[@"address"][@"mobile"]];
        // NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }
}

#pragma mark -- 确认接单
- (void)orderRecAction:(UIButton *)sender
{
    [self changeOidStatus:@"2"];
}

#pragma mark -- 拒单
- (void)ordersaleAction:(UIButton *)sender
{
    [self changeOidStatus:@"-2"];
}

//配送事件
- (void)peisong{
    [self changeOidStatus:@"3"];
}

//确认送达事件
- (void)querensongda{
    [self changeOidStatus:@"4"];
}

#pragma mark -- 同意退款
- (void)ordertuiBtnAction
{
    [self tuiOidStatus:@"1"];
}

//拒绝退款
- (void)orderjujueBtnAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拒绝退款" message:@"亲爱的商家，建议您先联系客户了解实际情况后再选择拒绝退款，选择拒绝退款后客服会联系您，请保持手机畅通，谢谢配合！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"返回联系客户" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拒绝退款" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self tuiOidStatus:@"-1"];
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

//订单退款
- (void)tuiOidStatus:(NSString *)status{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"操作中..."];
    
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    
    NSDictionary *dic = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"orderid":self.oid,@"status":status};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"shopid":shopID,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"orderid":self.oid,@"sign":singStr,@"status":status};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201029"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        [self request];
        //状态更改完毕后 要求订单列表页面刷新
        [[NSNotificationCenter defaultCenter]postNotificationName:@"needRefresh" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
        [TCProgressHUD showMessage:jsonDic[@"msg"]];
    } failure:^(NSError *error) {
        nil;
    }];
}


//设置不同字体颜色
-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    labell.attributedText = str;
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击图片
- (void)tapImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    UIImageView *image_big = [[UIImageView alloc] init];
   
    [image_big sd_setImageWithURL:[NSURL URLWithString:self.goodsArray[[singleTap view].tag][@"src"]] placeholderImage:[UIImage imageNamed:@"占位图（方形）"]];
    [HggBigImage showImage:image_big];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}
@end
