//
//  TCShopViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopViewController.h"
#import "TCCreateShopsViewController.h"
#import "TCShopAssistantController.h"
#import "TCActivityManageController.h"
#import "TCShopManagerViewController.h"
#import "SGAdvertScrollView.h"
#import "TCNewChangeViewController.h"
#import "TCPersonalInformationViewController.h"
#import "TCOrderNumViewController.h" //本月的订单数量
#import "TCOrderSellViewController.h" //本月的销售额
#import "TCOrderEvaluateViewController.h" //本月的好评
#import "TCFinanialViewController.h" //财务管理
#import "TCshopmanageViewController.h"//店铺管理
#import "TCSetetViewController.h" //设置
#import "TCTabBarViewController.h"
#import "TCHtmlViewController.h"
#import "TCShopShareViewController.h"
#import "TCMyshopCollectionViewCell.h"

@interface TCShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, SGAdvertScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UIView *backImageView;
    UIImageView *businessImage; // 营业中
    UITableView *shopTableView; //展示数据的tableview
    NSMutableArray *shopArr; // 保存数据的数组
    CGRect  textSize; //cell随着高度增而变化
    NSArray *pricelabelArr; // 中间4个view的上面的字
    NSString * cLabelString;
    
}
@property (nonatomic, strong) NSMutableDictionary *dict ; //字典
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSData *imageData;//把图片打包成data
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) UIView *selectView;//选择
@property (nonatomic, strong) UIImageView *statusIm;
@property (nonatomic, strong)NSString *idStr; //保存店铺的id
@property (nonatomic, strong) NSMutableArray *workerArr;
@property (nonatomic, assign) BOOL noshop;
@property (nonatomic, strong) NSArray *kauibaoArr;
@property (nonatomic, strong) SGAdvertScrollView *advertScrollView;
@property (nonatomic, strong) UIView *midview;
@property (nonatomic, strong) UIView *midNextView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *kuaibaoView;
@property (nonatomic, strong) UIButton *hotsellbtn;
@property (nonatomic, strong) UIButton *creatshopBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSArray *imageS;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) BOOL isCreat;
@property (nonatomic, assign) BOOL isHave;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *shopNamelabel;
@property (nonatomic, strong) NSString *shopstatu;
@property (nonatomic, strong) UIImageView *stateImage;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) NSString *shopid;

@end

@implementation TCShopViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear: YES];
//    self.tabBarController.tabBar.hidden= NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = Color;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    //去除边框影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    //一进来请求数据
    [self creatRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}


-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置垂直间的最小间距
        layout.minimumLineSpacing = 1;
        //设置水平间的最小间距
        layout.minimumInteritemSpacing = 1;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.bgView.frame) + 8 , WIDHT, 91*2) collectionViewLayout:layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = NO;
        _myCollectionView.backgroundColor = TCBgColor;
    }
    return _myCollectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCreat = YES;
    self.isHave = NO;
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 202)];
    bgView.image = [UIImage imageNamed:@"Group 9"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    UIButton *setupBT = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 14.5 - 20, 31.8, 20, 20)];
    [setupBT setBackgroundImage:[UIImage imageNamed:@"设置-4"] forState:(UIControlStateNormal)];
    [setupBT addTarget:self action:@selector(clickSetup:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:setupBT];
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 64)/2, 51, 64, 64)];
    self.headImage.userInteractionEnabled = YES;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 32;
    self.headImage.image = [UIImage imageNamed:@"1"];
    [bgView addSubview:self.headImage];
    
    self.shopNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImage.frame) + 8, WIDHT, 15)];
    self.shopNamelabel.text = @"味多美餐饮";
    self.shopNamelabel.font = [UIFont fontWithName:@"PingFangTC-Medium" size:13];
    self.shopNamelabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.shopNamelabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.shopNamelabel];

    
    self.creatshopBtn = [[UIButton alloc]initWithFrame:CGRectMake((WIDHT - 130)/2, 81, 130, 40)];
    [self.creatshopBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
    [self.creatshopBtn setTitle:@"创建店铺" forState:(UIControlStateNormal)];
    [self.creatshopBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [self.creatshopBtn addTarget:self action:@selector(clickCreatshop:) forControlEvents:(UIControlEventTouchUpInside)];
    self.creatshopBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    self.creatshopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.creatshopBtn.layer.masksToBounds = YES;
    self.creatshopBtn.layer.cornerRadius = 11;
    [bgView addSubview:self.creatshopBtn];
    
    UIImageView *btnImage = [[UIImageView alloc]init];
    self.stateImage = btnImage;
    if (self.isHave == YES) {
        self.creatshopBtn.hidden = YES;
        self.headImage.hidden = NO;
        self.shopNamelabel.hidden = NO;
        btnImage.frame = CGRectMake((WIDHT - 80)/2, CGRectGetMaxY(self.shopNamelabel.frame) + 10, 80, 40);
    }else{
        self.creatshopBtn.hidden = NO;
        self.headImage.hidden = YES;
        self.shopNamelabel.hidden = YES;
        btnImage.frame = CGRectMake((WIDHT - 80)/2, CGRectGetMaxY(self.creatshopBtn.frame) + 27, 80, 40);
    }
    
    btnImage.layer.masksToBounds = YES;
    btnImage.layer.cornerRadius = 5;
    [btnImage setImage:[UIImage imageNamed:@"营业状态栏"]];
    btnImage.userInteractionEnabled = YES;
    btnImage.hidden = YES;
    [bgView addSubview:btnImage];
    UITapGestureRecognizer *tapState = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapState:)];
    [btnImage addGestureRecognizer:tapState];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 80, 10)];
    label.text = @"营业状态";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    label.textColor = TCUIColorFromRGB(0xFFFFFF);
    label.textAlignment = NSTextAlignmentCenter;
    [btnImage addSubview:label];
    
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 7, 80, 12)];
    self.stateLabel.text = @"待营业";
    self.stateLabel.font = [UIFont fontWithName:@"PingFangTC-Medium" size:12];
    self.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [btnImage addSubview:self.stateLabel];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), WIDHT, 76)];
    self.bgView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:self.bgView];
    NSArray *titleArr = @[@"本月订单数",@"本月销售额",@"好评"];
    NSInteger width = WIDHT/titleArr.count;
    for (int i = 0; i < titleArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(width*i, 0, width, 76)];
        view.tag = 1000 + i;
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [self.bgView addSubview:view];
        //加入手势
        if (i == 0) {
            UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewone)];
            [view addGestureRecognizer:tapView];
        }else if (i == 1){
            UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewtwo)];
            [view addGestureRecognizer:tapView];
        }else if (i == 2){
            UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewthird)];
            [view addGestureRecognizer:tapView];
        }
     
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, width, 20)];
        numLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        numLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.text = @"-";
        [view addSubview:numLabel];
        if (i == 0) {
            self.orderLabel = numLabel;
        }else if (i == 1){
            self.moneyLabel = numLabel;
        }else if (i == 2){
            self.rankLabel = numLabel;
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(numLabel.frame) + 10, width, 11)];
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArr[i];
        titleLabel.textColor = TCUIColorFromRGB(0x333333);
        [view addSubview:titleLabel];
    }
    
    [self creatUI];
    
}
-(void)creatUI{
    self.imageS = @[@"钱包图标 copy",@"优惠券",@"我的收藏",@"商家学院",@"实名认证图标 copy",@"敬请期待"];
    self.titleArr = @[@"财务管理",@"商品管理",@"店铺管理",@"商家学院",@"店铺分享",@"敬请期待"];
    [self.myCollectionView registerClass:[TCMyshopCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.myCollectionView];

}

-(void)creatRequest{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"sign":signStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201003"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@--%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            self.orderLabel.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"ordernum"]];
            self.moneyLabel.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"moneynum"]];
            self.rankLabel.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"ranknum"]];
            NSString *shopstates = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"status"]];
            self.shopstatu = shopstates;
            if ([shopstates isEqualToString:@"1"]) {
                self.shopid = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"shopid"]];
                self.headImage.hidden = NO;
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"headPic"]]];
                self.creatshopBtn.hidden = YES;
                self.stateImage.hidden = NO;
                self.shopNamelabel.hidden = NO;
                self.shopNamelabel.text = jsonDic[@"data"][@"name"];
                self.stateImage.userInteractionEnabled = YES;
                self.stateLabel.text = @"营业中";
            }else if ([shopstates isEqualToString:@"-3"]){
                self.headImage.hidden = YES;
                [self.creatshopBtn setTitle:@"审核中" forState:(UIControlStateNormal)];
                self.creatshopBtn.hidden = NO;
                self.shopNamelabel.hidden = YES;
                self.stateImage.hidden = NO;
                self.creatshopBtn.userInteractionEnabled = NO;
                self.stateLabel.text = @"待营业";
                self.stateImage.userInteractionEnabled = NO;
            }else if ([shopstates isEqualToString:@"-2"]){
                self.headImage.hidden = NO;
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"headPic"]]];
                self.creatshopBtn.hidden = YES;
                self.shopNamelabel.hidden = NO;
                self.shopNamelabel.text = jsonDic[@"data"][@"name"];
                self.stateLabel.text = @"待营业";
                //self.shopNamelabel.hidden = YES;
                 self.stateImage.hidden = NO;
                self.stateImage.userInteractionEnabled = NO;
            }else if ([shopstates isEqualToString:@"-1"]){
                self.shopid = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"shopid"]];
                self.headImage.hidden = NO;
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"headPic"]]];
                self.creatshopBtn.hidden = YES;
                self.stateImage.hidden = NO;
                self.shopNamelabel.hidden = NO;
                self.shopNamelabel.text = jsonDic[@"data"][@"name"];
                self.stateImage.userInteractionEnabled = YES;
                self.stateLabel.text = @"暂停营业";
            }else if ([shopstates isEqualToString:@"-6"]){
                self.headImage.hidden = YES;
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"headPic"]]];
                self.creatshopBtn.hidden = NO;
                [self.creatshopBtn setTitle:@"创建中" forState:(UIControlStateNormal)];
                self.creatshopBtn.userInteractionEnabled = YES;
                self.shopNamelabel.hidden = YES;
                self.shopNamelabel.text = jsonDic[@"data"][@"name"];
                self.stateLabel.text = @"待营业";
                self.shopNamelabel.hidden = YES;
                self.stateImage.hidden = YES;
                self.stateLabel.hidden = YES;
                self.stateImage.userInteractionEnabled = NO;
            }else if ([shopstates isEqualToString:@"-7"]){
                self.headImage.hidden = YES;
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"headPic"]]];
                self.creatshopBtn.hidden = NO;
                [self.creatshopBtn setTitle:@"修改中" forState:(UIControlStateNormal)];
                self.creatshopBtn.userInteractionEnabled = YES;
                self.shopNamelabel.hidden = YES;
                 self.stateImage.hidden = YES;
                self.shopNamelabel.text = jsonDic[@"data"][@"name"];
                self.stateLabel.text = @"待营业";
                self.stateImage.userInteractionEnabled = NO;
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark -- UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个cell的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (WIDHT - 3)/3;
    return CGSizeMake(width, 91);
}
//cell的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 1, 1);
}
//cell 的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageS.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TCMyshopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 25)/2, 21, 27, 25);
    }else if (indexPath.row == 1){
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 26.6)/2, 20, 28.8, 26.6);
    }else if (indexPath.row == 2){
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 26.8)/2, 23, 26.8, 21);
    }else if (indexPath.row == 3){
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 28)/2, 19.5, 28, 25);
    }else if (indexPath.row == 4){
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 27)/2, 19.5, 27, 26);
    }else if (indexPath.row == 5){
        cell.iconImage.frame = CGRectMake((cell.contentView.frame.size.width - 26)/2, 19.5, 26, 26);
    }
    
    
    cell.iconImage.image = [UIImage imageNamed:self.imageS[indexPath.row]];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    
    return cell;
}

//设置cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的是%@",self.titleArr[indexPath.row]);
    if (indexPath.row == 0) {
        NSLog(@"财务管理");
        
        NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
            TCFinanialViewController *FinanialVC = [[TCFinanialViewController alloc] init];
            FinanialVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:FinanialVC animated:YES];
        }
        
        
    }else if (indexPath.row == 1){
        
        
        NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
           
            TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
            tab.selectedIndex = 2;
            [self presentViewController:tab animated:YES completion:nil];
        }

    }else if (indexPath.row == 2){
        NSLog(@"店铺管理");
        
        NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
            
            if ([self.shopstatu isEqualToString:@"-3"]) {
                nil;
            }else{
                TCshopmanageViewController *shopManagerVc = [[TCshopmanageViewController alloc]init];
                shopManagerVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopManagerVc animated:YES];
            }
        }
        
       
    }else if (indexPath.row == 3){
        NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
            
            NSLog(@"商家学院");
            TCHtmlViewController *htmlVC = [[TCHtmlViewController alloc] init];
            htmlVC.hidesBottomBarWhenPushed = YES;
            htmlVC.html = @"https://h5.moumou001.com/help/seller/index.html";
            htmlVC.title = @"使用说明";
            [self.navigationController pushViewController:htmlVC animated:YES];
            htmlVC.hidesBottomBarWhenPushed = NO;

        }
    }else if (indexPath.row == 4){
        NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
        if ([shopStr isEqualToString:@"0"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善店铺信息" message:@"完善店铺信息后才能继续操作下一步功能，完善店铺信息可尽快审核上架店铺并且能用当前app全部功能,请您尽快完善。" preferredStyle:UIAlertControllerStyleAlert];
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
            
            NSLog(@"店铺分享");
                        
            TCShopShareViewController *shopManagerVc = [[TCShopShareViewController alloc]init];
            shopManagerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopManagerVc animated:YES];
        }
    }else if (indexPath.row == 5){
        NSLog(@"敬请期待");
    }
    
}



#pragma mark -- 修改营业状态
-(void)tapState:(UITapGestureRecognizer *)tap{
    if ([self.stateLabel.text isEqualToString:@"营业中"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂停营业" message:@"亲爱的店主，是否让你的店铺暂停营业？暂停营业后，您的店铺自动下架且不能继续售卖。" preferredStyle:UIAlertControllerStyleAlert];
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
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"暂停营业" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self requeststate:@"-1"];
        }];
        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"开始营业" message:@"亲爱的店主，是否让你的店铺暂停营业？暂停营业后，您的店铺自动下架且不能继续售卖。" preferredStyle:UIAlertControllerStyleAlert];
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
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"开始营业" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self requeststate:@"1"];
        }];
        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
       
        
    }
    
}
-(void)requeststate:(NSString *)state{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":self.shopid,@"status":state};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"sign":signStr,@"shopid":self.shopid,@"status":state};
   // [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201030"]
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201030"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@-----%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",jsonDic[@"msg"]]];
            if ([state isEqualToString:@"1"]) {
                self.stateLabel.text = @"营业中";
            }else{
                self.stateLabel.text = @"暂停营业";
            }
        }else{
            [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",jsonDic[@"msg"]]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
    }];
    
}

#pragma mark -- 点击设置
-(void)clickSetup:(UIButton *)sender{
    NSLog(@"点击设置");
    TCSetetViewController *setetVC = [[TCSetetViewController alloc] init];
    setetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setetVC animated:YES];
    setetVC.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 点击创建店铺
-(void)clickCreatshop:(UIButton *)sender{
    NSLog(@"点击创建店铺");
    TCCreateShopsViewController *creatshopVC = [[TCCreateShopsViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creatshopVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 点击手势
-(void)tapViewone{
    NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
        
        TCOrderNumViewController *orderNumVC = [[TCOrderNumViewController alloc] init];
        orderNumVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderNumVC animated:YES];
        orderNumVC.hidesBottomBarWhenPushed = NO;
    }
}
-(void)tapViewtwo{
    NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
        
        TCOrderSellViewController *orderSellVC = [[TCOrderSellViewController alloc] init];
        orderSellVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderSellVC animated:YES];
        orderSellVC.hidesBottomBarWhenPushed = NO;

    }
}
-(void)tapViewthird{
    
    NSString *shopStr = [NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
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
        
        TCOrderEvaluateViewController *ordeEvaVC = [[TCOrderEvaluateViewController alloc] init];
        ordeEvaVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ordeEvaVC animated:YES];
        ordeEvaVC.hidesBottomBarWhenPushed = NO;
    }
}


//创建顶部图片的view
-(void)createImage{
    //设置图片
    backImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 162 * HEIGHTSCALE)];
    backImageView.backgroundColor = Color;
    
    //创建上方的图片
    UIImageView *imageShop = [UIImageView new];
    [imageShop setImage:[UIImage imageNamed:@"shopimage"]];
    imageShop.frame = CGRectMake((WIDHT - 80 *WIDHTSCALE)/2, 20 + 10, 80*HEIGHTSCALE, 80*HEIGHTSCALE);
    imageShop.tag = 101;
    imageShop.layer.cornerRadius = 40 *HEIGHTSCALE;
    imageShop.layer.masksToBounds = YES;
    imageShop.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel)];
    [imageShop addGestureRecognizer:tap1];
    //画边框圆
    imageShop.layer.borderWidth = 2;//边框宽度
    imageShop.layer.borderColor = [[UIColor whiteColor] CGColor];//边框颜色
    
    //创建营业状态
    _statusIm = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 12 * WIDHTSCALE - 60 * WIDHTSCALE, imageShop.frame.origin.y + imageShop.frame.size.height - 24 * HEIGHTSCALE, 60 * WIDHTSCALE, 24 * HEIGHTSCALE)];
    //    _statusIm.backgroundColor = [UIColor redColor];
    [backImageView addSubview: _statusIm];
    
    //月销售
    _hotsellbtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _hotsellbtn.frame = CGRectMake(12 * WIDHTSCALE, _statusIm.frame.origin.y, 70 * WIDHTSCALE, 24 * HEIGHTSCALE);
    [_hotsellbtn setImage:[UIImage imageNamed:@"商品销量榜标签"] forState:UIControlStateNormal];
    _hotsellbtn.hidden = YES;
    [_hotsellbtn addTarget:self action:@selector(clickhot) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview: _hotsellbtn];
    
    //创建店铺的label
    UILabel *shopLabel = [[UILabel alloc]init];
    shopLabel.tag = 100;
    shopLabel.text = @"创建店铺";
    shopLabel.frame = CGRectMake(0, imageShop.frame.origin.y + imageShop.frame.size.height + 8, WIDHT, 20);
    shopLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    shopLabel.textAlignment = NSTextAlignmentCenter;
    shopLabel.textColor = [UIColor whiteColor];
    //给label添加手势，修改昵称
    UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel)];
    shopLabel.userInteractionEnabled = YES;
    [shopLabel addGestureRecognizer:labelTap];
    
    //创建一个手势用来修改店铺
    if([[_userdefault valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        UITapGestureRecognizer * roleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(roleTap)];
        backImageView.userInteractionEnabled = YES;
        [backImageView addGestureRecognizer:roleTap];
    }
    
    [self.view addSubview: backImageView];
    [backImageView addSubview:imageShop];
    [backImageView addSubview:shopLabel];
 
    //创建快报view
    _kuaibaoView = [[UIView alloc]initWithFrame:CGRectMake(0, backImageView.frame.size.height, WIDHT, 0)];
    [self.view addSubview: _kuaibaoView];
}


//点击事件
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index{
    //code=1 跳转店铺列表，code=2跳转实名认证。
    if ([[NSString stringWithFormat:@"%@", _kauibaoArr[index][@"code"]] isEqualToString:@"1"]) {
        TCShopManagerViewController *create = [[TCShopManagerViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:create animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if([[NSString stringWithFormat:@"%@", _kauibaoArr[index][@"code"]] isEqualToString:@"2"]){
        if ([[_userdefault valueForKey:@"userRole"] isEqualToString:@"商家"]) {
            [self shifourenzheng];
        }
    }
}

//判断是否认证
- (void)shifourenzheng{
    [SVProgressHUD showWithStatus:@"获取中..."];
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"100114"] paramter:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        TCPersonalInformationViewController *personal = [[TCPersonalInformationViewController alloc]init];
        personal.mseDic = jsonDic;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personal animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } failure:^(NSError *error) {
        nil;
    }];
}

//请求快报
- (void)requestkuaibao{
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200028"] paramter:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic) {
            _kauibaoArr = jsonDic[@"data"];
            if (_kauibaoArr.count != 0) {
                //创建快报
                _kuaibaoView.frame = CGRectMake(0, backImageView.frame.size.height, WIDHT, 54);
                _advertScrollView = [[SGAdvertScrollView alloc]initWithFrame:CGRectMake(0, backImageView.frame.size.height, WIDHT, 0)];
                _advertScrollView.frame = CGRectMake(0, 0, WIDHT, 54);
                _advertScrollView.userInteractionEnabled = YES;
                _advertScrollView.advertScrollViewDelegate = self;
                _advertScrollView.image = [UIImage imageNamed:@"顺道嘉快报图标.png"];
                _advertScrollView.titleArray = _kauibaoArr;
                [_kuaibaoView addSubview:_advertScrollView];
            }else{
                //创建快报
                [_kuaibaoView removeFromSuperview];
                _kuaibaoView = [[UIView alloc]initWithFrame:CGRectMake(0, backImageView.frame.size.height, WIDHT, 0)];
                [self.view addSubview: _kuaibaoView];
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

//设置view的背景颜色
- (void)setViewBack:(NSInteger)tag{
    _selectView.backgroundColor = [UIColor whiteColor];
    UIView *view = [self.view viewWithTag:tag];
    view.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.3];
    _selectView = view;
}


#pragma mark -- 点击手势
-(void)roleTap{
    TCNewChangeViewController *newchange = [[TCNewChangeViewController alloc]init];
    if(self.dict){
        newchange.shopTel = self.dict[@"mobile"];
        newchange.shopName = self.dict[@"name"];
        newchange.priceStr = self.dict[@"price"];
        newchange.status = self.dict[@"status"];
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: newchange animated:YES
     ];
    self.hidesBottomBarWhenPushed = NO;
}

@end
