//
//  TCYinhangkaViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCYinhangkaViewController.h"
#import "TCAddYinhkViewController.h"
#import "TCCardTableViewCell.h"

@interface TCYinhangkaViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIImageView *imageviews;
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) UIBarButtonItem *right;
@end

@implementation TCYinhangkaViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self request];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(he) name:@"refresh" object:nil];
}

- (void)he{
    [self request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    _arr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = backGgray;
    //    _right = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(guanli)];
    self.navigationItem.rightBarButtonItem = _right;

    _imageviews = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT / 4, 100 * HEIGHTSCALE)];
    _imageviews.center = self.view.center;
    _imageviews.image = [UIImage imageNamed:@"bangdingk.png"];
    _imageviews.contentMode = UIViewContentModeScaleAspectFit;
    _imageviews.autoresizesSubviews = YES;
    _imageviews.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview: _imageviews];

    _lb = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageviews.frame.origin.y + _imageviews.frame.size.height - 64, WIDHT, 30)];
    _lb.text = @"您还未绑定任何银行卡";
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.font = [UIFont systemFontOfSize:20];
    _lb.textColor = ColorLine;
    [self.view addSubview: _lb];
   
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(50 * WIDHTSCALE, HEIGHT - 8 - 48 * HEIGHTSCALE - 64, WIDHT - 100 * WIDHTSCALE, 48 * HEIGHTSCALE);
    _btn.backgroundColor = btnColors;
    _btn.layer.cornerRadius = 5;
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn setTitle:@"添加银行卡" forState: UIControlStateNormal];
    [_btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _btn];
    //如果是供货商没有添加按钮了哦
    if([[self.userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        _btn.hidden = YES;
    }
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, _btn.frame.origin.y - 10) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = backGgray;
    [_tableview setSeparatorColor:backGgray];

    [self request];

}

//请求银行卡数据
- (void)request{
    [_arr removeAllObjects];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100116"] parameters:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"]) {
           
            _right = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(guanli)];
            self.navigationItem.rightBarButtonItem = _right;
            if([[self.userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
                self.navigationItem.rightBarButtonItem = nil; 
            }
            
            [_arr addObjectsFromArray: dic[@"data"]];
            [self.view addSubview: _tableview];
            _lb.hidden = YES;
            _imageviews.hidden = YES;
            
            [_tableview reloadData];
        }else{
            _lb.hidden = NO;
            _imageviews.hidden = NO;
        }
        [SVProgressHUD dismiss];
//        NSLog(@"银行卡返回信息%@", str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(_arr.count != 0){
        //前22个有颜色，其他的随机
        if([_arr[indexPath.section][@"bankid"] isEqualToString:@"1"]){
            cell.backView.backgroundColor = RGB(218,38,28);
            cell.lb.text = @"中国工商银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"2"]){
            cell.backView.backgroundColor = RGB(61,91,153);
            cell.lb.text = @"中国建设银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"3"]){
            cell.backView.backgroundColor = RGB(195,36,41);
            cell.lb.text = @"中国银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"4"]){
            cell.backView.backgroundColor = RGB(0,144,116);
            cell.lb.text = @"中国农业银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"5"]){
            cell.backView.backgroundColor = RGB(0,59,121);
            cell.lb.text = @"交通银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"6"]){
            cell.backView.backgroundColor = RGB(174,24,27);
            cell.lb.text = @"招商银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"7"]){
            cell.backView.backgroundColor = RGB(235,39,39);
            cell.lb.text = @"中信银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"8"]){
            cell.backView.backgroundColor = RGB(0,103,185);
            cell.lb.text = @"中国民生银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"9"]){
            cell.backView.backgroundColor = RGB(0,58,121);
            cell.lb.text = @"兴业银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"10"]){
            cell.backView.backgroundColor = RGB(0,41,106);
            cell.lb.text = @"上海浦东发展银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"11"]){
            cell.backView.backgroundColor = RGB(0,136,57);
            cell.lb.text = @"中国邮政储蓄银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"12"]){
            cell.backView.backgroundColor = RGB(103,18,132);
            cell.lb.text = @"中国光大银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"13"]){
            cell.backView.backgroundColor = RGB(255,51,1);
            cell.lb.text = @"平安银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"14"]){
            cell.backView.backgroundColor = RGB(255,76,76);
            cell.lb.text = @"华夏银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"15"]){
            cell.backView.backgroundColor = RGB(231,0,18);
            cell.lb.text = @"北京银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"16"]){
            cell.backView.backgroundColor = RGB(255,76,76);
            cell.lb.text = @"广发银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"17"]){
            cell.backView.backgroundColor = RGB(52,57,125);
            cell.lb.text = @"上海银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"18"]){
            cell.backView.backgroundColor = RGB(0,92,161);
            cell.lb.text = @"江苏银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"19"]){
            cell.backView.backgroundColor = RGB(21,46,86);
            cell.lb.text = @"恒丰银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"20"]){
            cell.backView.backgroundColor = RGB(167,51,42);
            cell.lb.text = @"浙商银行";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"21"]){
            cell.backView.backgroundColor = RGB(2,145,63);
            cell.lb.text = @"农村信用合作社";
        }else if ([_arr[indexPath.section][@"bankid"] isEqualToString:@"22"]){
            cell.backView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            cell.lb.text = @"其他银行";
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell.im sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.moumou001.com/banks/%@.png",_arr[indexPath.section][@"bankid"]]] placeholderImage:nil];
    }
//    cell.lb.text = _arr[indexPath.section][@"bank"];
      cell.num.text = _arr[indexPath.section][@"cardid"];
//    cell.backgroundColor = backGgray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * HEIGHTSCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isCome) {
        NSLog(@" 多少%@", _arr[indexPath.section]);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cardMes" object:nil userInfo:@{@"id":_arr[indexPath.section]}];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if([[self.userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        [SVProgressHUD showErrorWithStatus:@"供货商不能删除银行卡"];
    }else{

    [SVProgressHUD showWithStatus:@"操作中..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"cid":_arr[indexPath.section][@"id"]};
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100117"] parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"删除返回信息%@", dic[@"retMessage"]);
        [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
        if (_arr.count != 0) {
            [_arr removeObjectAtIndex:indexPath.section];
        }
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    }
}

//添加银行卡
- (void)add{
    TCAddYinhkViewController *add = [[TCAddYinhkViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:add animated:YES];
}

//管理
- (void)guanli{
    _tableview.editing = !_tableview.editing;
    if (_tableview.isEditing) {
        _right.title = @"取消";
    }else{
        _right.title = @"管理";
    }
}









@end
