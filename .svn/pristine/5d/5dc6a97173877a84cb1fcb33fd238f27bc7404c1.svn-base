//
//  TCMyMesViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/28.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMyMesViewController.h"
#import "TCDownTableViewCell.h"

@interface TCMyMesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSDictionary *dicsss;
@end

@implementation TCMyMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    self.title = @"个人信息";
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];

//    [self request];
}

- (void)request{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;

    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100114"] parameters:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if (dics[@"data"]) {
            _dicsss = dics[@"data"];
            [_tableview reloadData];
        }
        NSLog(@"返回信息%@", str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(![[self.userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        return  2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"姓名";
            cell.detailTextLabel.text = _dicsss[@"name"];
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"身份证号";
            if(_dicsss[@"idno"]){
              cell.detailTextLabel.text = _dicsss[@"idno"];
            }else{
                cell.detailTextLabel.text = @"暂无";
            }
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"手机号";
            cell.detailTextLabel.text = _dicsss[@"mobile"];
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"角色";
            cell.detailTextLabel.text = _dicsss[@"role"];
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"会员编号";
            if(_dicsss[@"memberCode"]){
              cell.detailTextLabel.text = _dicsss[@"memberCode"];
            }else{
              cell.detailTextLabel.text = @"暂无";
            }
        }else if (indexPath.row == 5){
            cell.textLabel.text = @"店铺名称";
            cell.detailTextLabel.text = _dicsss[@"shopname"];
        }
        return cell;
    }else{
        
        [_tableview registerNib:[UINib nibWithNibName:@"TCDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells"];
        TCDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if([_dicsss[@"qrcode"] isEqualToString:@""] ){
            NSLog(@"空");
        }else{
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:_dicsss[@"qrcode"]]];
        }
            return cell;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50 * HEIGHTSCALE;
    }else{
        return 260;
    }
}


@end
