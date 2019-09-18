//
//  TCActivityManageController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActivityManageController.h"
#import "TCCreateActiveController.h"
#import "TCActiveShowViewController.h"
#import "TCPreferentialController.h"
#import "TCOffLineActivityViewController.h"
#import "TCActivityManageTableViewCell.h"
@interface TCActivityManageController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *activeTableView;
}
@property (nonatomic, strong) NSArray *imageArr;//图片的数组
@property (nonatomic, strong) NSArray *titleArray;//文字数组
@property (nonatomic, strong) NSArray *disTitleArray; //描述文字数组
@end

@implementation TCActivityManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动管理";
    self.view.backgroundColor = ViewColor;
    //数组
    [self createArr];
    //创建提示框以及创建活动的按钮
    [self createActiveTable];
    // Do any additional setup after loading the view.
}
#pragma mark -- 创建tableView
-(void)createActiveTable
{
    activeTableView = [[UITableView alloc]init];
    activeTableView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    activeTableView.delegate = self;
    activeTableView.dataSource = self;
    activeTableView.rowHeight = 72;
    activeTableView.scrollEnabled = NO;
    activeTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview: activeTableView];
    [activeTableView registerClass:[TCActivityManageTableViewCell class] forCellReuseIdentifier:@"cells"];
}
//数组
-(void)createArr
{
    self.imageArr = @[@"优惠活动图标",@"线下店铺活动图标",@"新建线上活动"];
    self.titleArray = @[@"优惠活动",@"线下店铺活动",@"新建线上活动"];
    self.disTitleArray = @[@"顺道嘉系统统一提供的优惠活动",@"只用于进店消费使用",@"只用于线上消费的活动"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCActivityManageTableViewCell *cell = [activeTableView dequeueReusableCellWithIdentifier:@"cells"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *imageTitle = self.imageArr[indexPath.row];
    cell.imageTop.image = [UIImage imageNamed:imageTitle];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.disLabel.text = self.disTitleArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 2){
       if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
           [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
       if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
           [cell setLayoutMargins:UIEdgeInsetsZero];
    }
       if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
           [cell setSeparatorInset:UIEdgeInsetsZero];
    }
  }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        [TCProgressHUD showMessage:@"敬请期待~" duration:1.5];
//        TCPreferentialController *preVC = [[TCPreferentialController alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:preVC animated:YES];
    }else if (indexPath.row == 1){
        TCOffLineActivityViewController *offLineVC = [[TCOffLineActivityViewController alloc]init];
        offLineVC.isPush = NO;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:offLineVC animated:YES];
    }else if (indexPath.row == 2){
        [TCProgressHUD showMessage:@"敬请期待~" duration:1.5];
//        TCActiveShowViewController *activeVC = [[TCActiveShowViewController alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:activeVC animated:YES];
    }
}

#pragma mark -- 右边箭头的点击事件
-(void)click:(UIButton *)sender
{
    
    if(sender.tag == 1000){
        TCPreferentialController *preVC = [[TCPreferentialController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:preVC animated:YES];
    }
    if(sender.tag == 1001){
        TCActiveShowViewController *activeVC = [[TCActiveShowViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activeVC animated:YES];
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
