//
//  TCGoodsViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCGoodsViewController.h"
#import "TCGoodssTableViewCell.h"
#import "TCShopsManaerViewController.h"

@interface TCGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSDictionary *myDic;
@property (nonatomic, strong) NSDictionary *listDic;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, assign) BOOL noshop;
@property (nonatomic, assign) BOOL canrequest;
@property (nonatomic, strong) NSString *mainshopid;
//@property (nonatomic, assign) BOOL isguanli;//判断是否有关联店铺
@end

@implementation TCGoodsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    if (_canrequest) {
        [self request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择店铺";
    self.tabBarItem.title = @"商品";
    _canrequest = YES;
    _arr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64 - 48) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.rowHeight = 114.0;
}

- (void)request{
    [SVProgressHUD showWithStatus:@"加载中..."];
    _canrequest = NO;
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200002"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        _myDic = jsonDic;
        NSString *str1 = [NSString stringWithFormat:@"%@", _myDic[@"data"][@"noShop"]];
        if ([str1 isEqualToString:@"1"]) {
            _noshop = YES;//表示下面没有关联店铺了
        }else{
            _noshop = NO;//表示下面有关联店铺了
        }
        [self.view addSubview: _tableview];
        [self requestList];
    } failure:^(NSError *error) {
        nil;
    }];
}

//获取店铺列表
- (void)requestList{
    [_arr removeAllObjects];
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200001"] paramter:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]}  success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            NSInteger x = 0;
            [_arr addObjectsFromArray:jsonDic[@"data"]];
            for (int i = 0; i < _arr.count; i++) {
                if ([_arr[i][@"id"] isEqualToString: _myDic[@"data"][@"shopid"]]) {
                    x = i;
                }
            }
            if (_noshop == NO) {
                //表示有关联店铺  要从列表中移除当前的店铺
                [_arr removeObjectAtIndex: x];
            }
            [_tableview reloadData];
            _canrequest = YES;
            [SVProgressHUD dismiss];
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _arr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCGoodssTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCGoodssTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        if ([_myDic[@"retValue"] intValue] == -1) {
            [cell.imageviews sd_setImageWithURL:[NSURL URLWithString:_myDic[@"data"][@"headPic"]] placeholderImage:[UIImage imageNamed:@"shopimage"]];
            cell.shopname.text = @"暂无关联店铺";
            cell.dianzhang.text = @"";
            cell.phone.text = @"";
        }else{
            [cell.imageviews sd_setImageWithURL:[NSURL URLWithString:_myDic[@"data"][@"headPic"]] placeholderImage:[UIImage imageNamed:@"shopimage"]];
            cell.shopname.text = _myDic[@"data"][@"name"];
            cell.dianzhang.text = [NSString stringWithFormat:@"店长:%@", _myDic[@"data"][@"shopkeeper"]];
            cell.phone.text = [NSString stringWithFormat:@"电话:%@", _myDic[@"data"][@"tel"]];
        }
        if (_noshop) {
            [cell.imageviews sd_setImageWithURL:[NSURL URLWithString:_myDic[@"data"][@"headPic"]] placeholderImage:[UIImage imageNamed:@"shopimage"]];
            cell.shopname.text = @"暂无关联店铺";
            cell.dianzhang.text = @"";
            cell.phone.text = @"";
        }
    }else{
        if (_arr.count != 0) {
            [cell.imageviews sd_setImageWithURL:[NSURL URLWithString:_arr[indexPath.row][@"headPic"]] placeholderImage:[UIImage imageNamed:@"shopimage"]];
            cell.shopname.text = _arr[indexPath.row][@"name"];
            cell.dianzhang.text = [NSString stringWithFormat:@"店长:%@", _arr[indexPath.row][@"shopkeeper"]];
            cell.phone.text = [NSString stringWithFormat:@"电话:%@", _arr[indexPath.row][@"tel"]];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1 + 35 * HEIGHTSCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 35 * HEIGHTSCALE)];
    views.backgroundColor = [UIColor whiteColor];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 35 * HEIGHTSCALE)];
    lb.textColor = Color;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:17];
    [views addSubview: lb];
    if (section == 0) {
        lb.text = @"我的店铺";
    }else{
        lb.text = @"其他店铺";
    }
    return views;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TCShopsManaerViewController *shopmanager = [[TCShopsManaerViewController alloc]init];
    if (indexPath.section == 0) {
        if (_noshop == NO) {
            //当有关联店铺是才能点击
            if ([_myDic[@"retValue"] intValue] != -1) {
                shopmanager.shopid = _myDic[@"data"][@"shopid"];
                shopmanager.isShow = NO;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopmanager animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        }
        
    }else{
        if (_arr.count != 0) {
            shopmanager.shopid = _arr[indexPath.row][@"id"];
            shopmanager.isShow = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopmanager animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: YES];
    [SVProgressHUD dismiss];
}


@end
