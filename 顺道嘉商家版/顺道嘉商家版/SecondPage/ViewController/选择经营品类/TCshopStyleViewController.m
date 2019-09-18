//
//  TCshopStyleViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCshopStyleViewController.h"
#import "TCShopStyleTableViewCell.h"
static NSString *mutaStr;
@interface TCshopStyleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray* dataArr;
@property (nonatomic, strong) NSMutableArray *idArr;
@property (nonatomic, strong) NSIndexPath *lastPath;

@end

@implementation TCshopStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择经营品类";
    self.view.backgroundColor = TCBgColor;
    self.dataArr = [NSMutableArray array];
    self.idArr = [NSMutableArray array];
    
    for (int i = 0; i < self.messArr.count; i ++) {
        [self.dataArr addObject:self.messArr[i][@"name"]];
        [self.idArr addObject:self.messArr[i][@"id"]];
    }
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - StatusBarAndNavigationBarHeight)];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;//隐藏分割线
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = TCBgColor;
    
    [self.view addSubview:_mainTableView];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark -- tableViewDelegateMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCShopStyleTableViewCell *cell = [[TCShopStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.checkBtn.tag = indexPath.row;
    [cell.checkBtn addTarget:self action:@selector(clickCheck:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.titleLabel.text = self.dataArr[indexPath.row];
    for (NSInteger i = 0; i < self.dataArr.count ; i++) {
        NSString *str = self.dataArr[i];
        if ([str isEqualToString:mutaStr]) {
            NSInteger rr = i;
            NSLog(@"第几个%ld",(long)i);
            if (indexPath.row == rr) {
                [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:UIControlStateNormal];
            }else{
                [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:UIControlStateNormal];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)clickCheck:(UIButton *)sender{
    //    sender.selected = !sender.selected;
    TCShopStyleTableViewCell *cell = (TCShopStyleTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSLog(@"点击的是第%ld行按钮",indexPath.row);
    mutaStr = self.dataArr[indexPath.row];
    self.block(self.dataArr[indexPath.row]);
    self.blocks(self.idArr[indexPath.row]);
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
