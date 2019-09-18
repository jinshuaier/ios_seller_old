//
//  TCMessageViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCMessageViewController.h"
#import "TCMessageTableViewCell.h"
#import "TCMesOrderViewController.h"
#import "TCMeshdViewController.h"
#import "TCMesZdViewController.h"
#import "TCMesXtViewController.h"
@interface TCMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *messageTable;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSDictionary *dic;
@end

@implementation TCMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //请求
    [self request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    self.view.backgroundColor = backGgray;
   _userdefaults = [NSUserDefaults standardUserDefaults];
    //创建tableView
    [self createMessageTable];

    // Do any additional setup after loading the view.
}

- (void)request{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"600007"] parameters:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"]) {
            _dic = dic[@"data"];
            [_messageTable reloadData];
        }
        NSLog(@"返回数数据 %@  %@", dic, str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}
//创建tableView
-(void)createMessageTable
{
    self.messageTable = [[UITableView alloc]init];
    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"店长"] ||[[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"])
    {
        self.messageTable.frame = CGRectMake(0, 0, WIDHT, 80);
    }else{
        self.messageTable.frame = CGRectMake(0, 0, WIDHT, 80 * 4);
    }
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.messageTable.scrollEnabled = NO;
    [self.view addSubview:self.messageTable];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TCMesOrderViewController * order = [[TCMesOrderViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:order animated:YES];
    }else if (indexPath.row == 2){
        TCMeshdViewController *hd = [[TCMeshdViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hd animated:YES];
    }else if (indexPath.row == 1){
        TCMesZdViewController *zhangd = [[TCMesZdViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zhangd animated:YES];
    }else if (indexPath.row == 3){
        TCMesXtViewController *xt = [[TCMesXtViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:xt animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [_messageTable registerNib:[UINib nibWithNibName:@"TCMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    TCMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    cell.disLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    cell.redImage.hidden = YES;
    
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"订单消息图标"];
        cell.titleLabel.text = @"订单消息";
        if(!_dic[@"ordNum"]){
          cell.disLabel.text = @"您有0条未读订单消息，请注意查看";
        }else{
        cell.disLabel.text = [NSString stringWithFormat:@"您有%@条未读订单消息，请注意查看", [NSString stringWithFormat:@"%@", _dic[@"ordNum"]]];
        }
        if ([_dic[@"ordNum"] intValue] == 0) {
            cell.redImage.hidden = YES;
        }else{
            cell.redImage.hidden = NO;
        }
        return cell;
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"账单消息图标"];
        cell.titleLabel.text = @"账单消息";
        if(!_dic[@"blaNum"]){
            cell.disLabel.text = @"您有0条未读账单消息，请注意查看";
        }else{
            cell.disLabel.text = [NSString stringWithFormat:@"您有%@条未读账单消息，请注意查看", [NSString stringWithFormat:@"%@", _dic[@"blaNum"]]];
        }
        if ([_dic[@"blaNum"] intValue] == 0) {
            cell.redImage.hidden = YES;
        }else{
            cell.redImage.hidden = NO;
        }
        return cell;
        
    }else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"活动消息图标"];
        cell.titleLabel.text = @"活动消息";
        if(!_dic[@"actNum"]){
            cell.disLabel.text = @"您有0条未读活动消息，请注意查看";
        }else{
            cell.disLabel.text = [NSString stringWithFormat:@"您有%@条未读系统消息，请注意查看", [NSString stringWithFormat:@"%@", _dic[@"actNum"]]];
        }
        if ([_dic[@"actNum"] intValue] == 0) {
            cell.redImage.hidden = YES;
        }else{
            cell.redImage.hidden = NO;
        }
        return cell;
        
    }else{
        cell.imageView.image = [UIImage imageNamed:@"系统消息"];
        cell.titleLabel.text = @"系统消息";
        if(!_dic[@"norNum"]){
            cell.disLabel.text = @"您有0条未读系统消息，请注意查看";
        }else{
            cell.disLabel.text = [NSString stringWithFormat:@"您有%@条未读系统消息，请注意查看", [NSString stringWithFormat:@"%@", _dic[@"norNum"]]];
        }
        if ([_dic[@"norNum"] intValue] == 0) {
            cell.redImage.hidden = YES;
        }else{
            cell.redImage.hidden = NO;
        }
        return cell;
    }
    
}


//最后下划线顶格
- (void)viewDidLayoutSubviews{
    if ([_messageTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_messageTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_messageTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_messageTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 3){
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"店长"] || [[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
        return 1;
    }
    return 4;
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
