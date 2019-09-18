//
//  TCBalanceViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCBalanceViewController.h"
#import "TCBlanceCollectionViewCell.h"
#import "TCBillViewController.h"
#import "TCBenefitViewController.h"
#import "TCChongzhiViewController.h"
#import "TCTixiansViewController.h"
#import "TCShopListViewController.h"

//查看保证金
#import "TCLookDepositViewController.h"
@interface TCBalanceViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UILabel *moneyLabel;
}
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UICollectionView *balanceCollectionView;
@property (nonatomic, strong) UIBarButtonItem *right;


@end

@implementation TCBalanceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = Color;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shuaxin) name:@"shuaxin" object:nil];
}
-(void)shuaxin{
     [self createQueste];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金额";
   
    _userdefaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = backGgray;
    _right = [[UIBarButtonItem alloc]initWithTitle:@"账单记录" style:UIBarButtonItemStylePlain target:self action:@selector(jilu)];
    self.navigationItem.rightBarButtonItem = _right;

    //设置View
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, WIDHT, 100 *HEIGHTSCALE);
    backView.backgroundColor = Color;
    [self.view addSubview:backView];
    //金额
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.frame = CGRectMake(0, 20 *HEIGHTSCALE, WIDHT, 30 *HEIGHTSCALE);

    moneyLabel.font = [UIFont systemFontOfSize:30*HEIGHTSCALE];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [UIColor whiteColor];
    [backView addSubview:moneyLabel];
    //金额描述
    UILabel *disLabel = [[UILabel alloc]init];
    disLabel.frame = CGRectMake(0, moneyLabel.frame.size.height + moneyLabel.frame.origin.y + 20*HEIGHTSCALE, WIDHT, 15*HEIGHTSCALE);
    disLabel.textColor = [UIColor whiteColor];
    disLabel.font = [UIFont systemFontOfSize:12*HEIGHTSCALE];
    disLabel.text = @"金额=销售额+充值+分润转账";
    disLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:disLabel];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    _balanceCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, backView.frame.size.height + backView.frame.origin.y, WIDHT, HEIGHT - 48 + 20) collectionViewLayout:flowLayout];
    _balanceCollectionView.backgroundColor = backGgray;
    _balanceCollectionView.delegate = self;
    _balanceCollectionView.dataSource = self;
    _balanceCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview: _balanceCollectionView];

    //进行网络请求
    [self createQueste];

    // Do any additional setup after loading the view.
}
#pragma mark -- 进行网络请求
-(void)createQueste
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
        
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]};
        [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"700001"] parameters:paramter success:^(id responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if (dic[@"data"]) {
//                [SVProgressHUD showSuccessWithStatus:@"加载成功!"];
                moneyLabel.text = [NSString stringWithFormat:@"¥ %@",dic[@"data"][@"total"]];
            }else{
                moneyLabel.text = @"¥0.00";
                [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
            }
        } failure:^(NSError *error) {
            
            nil;
        }];
       
}
//多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分区多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

//设置每个分区的中cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(WIDHT / 2 - 2, 80);
}

//设置每个分区cell上下左右的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
   
        return UIEdgeInsetsMake(0, 0, 1, 1);
}

//设置cell最大最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//设置cell中的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    [_balanceCollectionView registerNib:[UINib nibWithNibName:@"TCBlanceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    TCBlanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
         cell.title.text = @"额度";
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            cell.im.image = [UIImage imageNamed:@"额度图标（灰）"];
            cell.title.textColor = TCUIColorFromRGB(0xC4C4C4);
        }else{
            cell.im.image = [UIImage imageNamed:@"额度图标"];
            cell.title.textColor = TCUIColorFromRGB(0x4D4D4D);
        }
    }else if (indexPath.row == 1){
        cell.title.text = @"奖金";
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            cell.im.image = [UIImage imageNamed:@"奖金图标（灰）"];
            cell.title.textColor = TCUIColorFromRGB(0xC4C4C4);
        }else{
            cell.im.image = [UIImage imageNamed:@"分润图标"];
            cell.title.textColor = TCUIColorFromRGB(0x4D4D4D);
        }
    }else if (indexPath.row == 2) {
        cell.im.image = [UIImage imageNamed:@"提现图标"];
        cell.title.text = @"提现";
        cell.title.textColor = TCUIColorFromRGB(0x4D4D4D);
    }else if (indexPath.row == 3) {
        cell.title.text = @"充值";
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            cell.im.image = [UIImage imageNamed:@"充值图标(灰)"];
            cell.title.textColor = TCUIColorFromRGB(0xC4C4C4);
        }else{
            cell.im.image = [UIImage imageNamed:@"充值图标"];
            cell.title.textColor = TCUIColorFromRGB(0x4D4D4D);
        }
    }else if (indexPath.row == 4) {
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            cell.im.image = [UIImage imageNamed:@"提交保证金图标-（灰）.png"];
        }else{
            cell.im.image = [UIImage imageNamed:@"xai提交保证金图标"];
        }
        cell.title.text = @"终端机保证金";
        cell.title.textColor = TCUIColorFromRGB(0x4D4D4D);
    }else{
        cell.im.image = [UIImage imageNamed:@"敬请期待图标"];
        cell.title.text = @"尽情期待";
        cell.title.textColor = TCUIColorFromRGB(0xC4C4C4);
    }
    return cell;
}
//点击cell触发事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSLog(@"额度");
        [TCHubView showWithText:@"正在开发中" WithDurations:1.5];
        //[SVProgressHUD showInfoWithStatus:@"正在开发中"];
    }else if (indexPath.row == 1){
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            //[SVProgressHUD showErrorWithStatus:@"您没有访问权限"];
//            [TCHubView showWithText:@"您没有访问权限" WithDurations:1.5];
        }else{
           TCBenefitViewController * benefitVC = [[TCBenefitViewController alloc]init];
           self.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:benefitVC animated:YES];
        }
    }else if (indexPath.row == 2){
        TCTixiansViewController *tixian = [[TCTixiansViewController alloc]init];
        tixian.ye = moneyLabel.text;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tixian animated:YES];
    }else if (indexPath.row == 3){
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
//            [TCHubView showWithText:@"您没有访问权限" WithDurations:1.5];
        }else{
            TCChongzhiViewController *chognzhi = [[TCChongzhiViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chognzhi animated:YES];
        }
    }else if (indexPath.row == 4){
        if([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            
        }else{
            TCShopListViewController *shoplist = [[TCShopListViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shoplist animated:YES];
        }
    }else{
        [TCHubView showWithText:@"敬请期待" WithDurations:1.5];
    }
  }

#pragma mark -- 账单记录v
-(void)jilu
{
    TCBillViewController * bill = [[TCBillViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bill animated:YES];
    
}


@end
