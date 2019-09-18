//
//  TCshopmanageViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCshopmanageViewController.h"
#import "TCShopMangerTableViewCell.h"
#import "TCShopinfoViewController.h"
#import "TCCreateShopsViewController.h"
#import "TCZiZhiInfoViewController.h"
#import "TCShopActiveController.h"
#import "TCGategoryManageViewController.h" //品类管理

@interface TCshopmanageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation TCshopmanageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺管理";
    self.view.backgroundColor = TCBgColor;
    self.dataArr = @[@"店铺介绍管理",@"店铺资质管理",@"店铺信息管理",@"店铺活动管理",@"店铺品类管理"];
    self.titleArr = @[@"店铺介绍管理可修改内容为店铺名称、联系人等",@"店铺资质管理可修改内容为证照类及银行卡信息",@"店铺信息管理可修改店铺地址及店铺照片",@"（您可以在店铺运营管理内管理您的活动）",@"管理您自定义的商品或服务品类"];
    
    [self creatUI];
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10,WIDHT, self.dataArr.count * 78)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.showsVerticalScrollIndicator = NO;//隐藏分割线
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = TCBgColor;
    [self.view addSubview:self.mainTableView];
}
#pragma mark -- tableViewDelegateMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
        headerView.backgroundColor = TCBgColor;
        return headerView;
    }
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 78;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCShopMangerTableViewCell *cell = [[TCShopMangerTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    cell.topLabel.text = self.dataArr[indexPath.row];
    cell.grayLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.stateLabel.hidden = YES;
        cell.sanImage.hidden = NO;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 77, WIDHT - 15, 1)];
        line.backgroundColor = TCLineColor;
        [cell.contentView addSubview:line];
    }else{
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 77, WIDHT - 15, 1)];
        line.backgroundColor = TCLineColor;
        [cell.contentView addSubview:line];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"进入店铺介绍");
        TCCreateShopsViewController *creatVC = [[TCCreateShopsViewController alloc]init];
        creatVC.enterStr = @"1";
         creatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:creatVC animated:YES];
    }else if (indexPath.row == 1){
        NSLog(@"进入店铺资质");
        TCZiZhiInfoViewController *zizhiinfo = [[TCZiZhiInfoViewController alloc]init];
        zizhiinfo.enterStr = @"1";
         zizhiinfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zizhiinfo animated:YES];
    }else if (indexPath.row == 2){
        NSLog(@"进入店铺信息");
        TCShopinfoViewController *shopinfo = [[TCShopinfoViewController alloc]init];
        shopinfo.enterStr = @"1";
         shopinfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopinfo animated:YES];
    }else if (indexPath.row == 3){
        NSLog(@"进入店铺活动");
        TCShopActiveController *shopActiveVC = [[TCShopActiveController alloc]init];
        shopActiveVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopActiveVC animated:YES];
    } else {
        TCGategoryManageViewController *ManageVC = [[TCGategoryManageViewController alloc] init];
        ManageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ManageVC animated:YES];
    }
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
