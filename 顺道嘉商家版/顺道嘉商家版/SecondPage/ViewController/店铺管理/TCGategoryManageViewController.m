//
//  TCGategoryManageViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/26.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCGategoryManageViewController.h"
#import "UITableView+HD_NoList.h"
#import "TCNoMessageView.h"
#import "TCAddCategoryViewController.h" //添加新的品类
#import "TCCateListTableViewCell.h" //cell
#import "TCCateList.h" //model
#import "TCDeleCateListView.h" //删除的弹窗
#import "TMSwipeCell.h"

@interface TCGategoryManageViewController ()<UITableViewDelegate,UITableViewDataSource,CheckNetworkDelegate,TMSwipeCellDelegate>
@property (nonatomic, strong) UIBarButtonItem *editBtn;
@property (nonatomic, strong) TCNoMessageView *nomessageView; //占位
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *deleteArray;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIButton *bottomBtn; //下方的按钮

@end

@implementation TCGategoryManageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"品类管理";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.dataSource = [NSMutableArray array];
    //由上个页面传过来的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxinList) name:@"shuaxinCateList" object:nil];
    [self setupTableView];  //创建tableView
    [self initData]; //数据源
    [self bottomView]; //下方的新增品类的按钮
    
    // Do any additional setup after loading the view.
}

//传过来就刷新
- (void)shuaxinList
{
    [self initData];
}
//数据源 请求数据
- (void)initData{
    [self.dataSource removeAllObjects];
    NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"shopid":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];

    NSDictionary *parameters = @{@"shopid":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];

    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202017"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            NSArray *arr = jsonDic[@"data"];
            for (NSDictionary *dic in arr) {
                TCCateList *model = [TCCateList cateListInfoWithDictionary:dic];
                [self.dataSource addObject:model];
            }
            self.bottomBtn.hidden = NO;
        } else {
            self.bottomBtn.hidden = YES;
        }
        //占位图
        [self NeedResetNoView];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
}

//占位图
- (void)NeedResetNoView{
    if (self.dataSource.count >0) {
        [self.tableView dismissNoView];
        [self.nomessageView removeFromSuperview];
    }else{
        if (self.nomessageView){
            [self.nomessageView removeFromSuperview];
            self.nomessageView = [[TCNoMessageView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT) AndImage:@"无订单缺省页" AndLabel:@"您还没有自定义的品类，快去添加吧" andButton:@"新增品类"];
            self.nomessageView.delegate = self;
            
            [self.view addSubview:self.nomessageView];
            
        } else {
            self.nomessageView = [[TCNoMessageView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT) AndImage:@"无订单缺省页" AndLabel:@"您还没有自定义的品类，快去添加吧" andButton:@"新增品类"];
            self.nomessageView.delegate = self;
            [self.view addSubview:self.nomessageView];
        }
    }
}
//tableView
- (void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 48 - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.backgroundColor = TCBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

//新增品类的按钮
- (void)bottomView
{
    self.bottomBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.bottomBtn.frame = CGRectMake(0, HEIGHT - 48 - 64, WIDHT, 48);
    self.bottomBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    self.bottomBtn.hidden = YES;
    [self.bottomBtn setTitle:@"新增品类" forState:(UIControlStateNormal)];
    [self.bottomBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [self.bottomBtn addTarget:self action:@selector(bottomAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.bottomBtn];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCCateList *model = [_dataSource objectAtIndex:indexPath.row];
    TCCateListTableViewCell *cell = [[TCCateListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.nameLabel.text = model.name;
    cell.sortLabel.text = model.sort;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (BOOL)swipeCell:(TMSwipeCell *)swipeCell canSwipeRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (nullable NSArray<TMSwipeCellAction *> *)swipeCell:(TMSwipeCell *)swipeCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMSwipeCellAction *action1 = [TMSwipeCellAction rowActionWithStyle:TMSwipeCellActionStyleNormal title:@"编辑" handler:^(TMSwipeCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"");
        self.tableView.editing = NO;
        TCAddCategoryViewController *addCateVC = [[TCAddCategoryViewController alloc] init];
        addCateVC.isChange = YES;
        TCCateList *model = self.dataSource[indexPath.row];
        addCateVC.goodscateid = model.goodscateid;
        addCateVC.nameStr = model.name;
        addCateVC.sortStr = model.sort;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addCateVC animated:YES];
    }];
    TMSwipeCellAction *action2 = [TMSwipeCellAction rowActionWithStyle:TMSwipeCellActionStyleDestructive title:@"删除" handler:^(TMSwipeCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        TCDeleCateListView *deleView = [[TCDeleCateListView alloc] initWithFrame:self.view.frame andTtile:@"品类删除后，该品类下的所有商品会一并删除，且不可恢复，是否确认删除"];
        TCCateList *model = self.dataSource[indexPath.row];
        
        //删除
        deleView.buttonAction = ^(UIButton *sender) {
            //删除的接口
            NSString *shopID = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"shopID"]];
            NSDictionary *dic = @{@"shopid":shopID,@"goodscateid":model.goodscateid};
            NSString *singStr = [TCServerSecret signStr:dic];
            
            NSDictionary *parameters = @{@"shopid":shopID,@"sign":singStr,@"goodscateid":model.goodscateid};
            NSDictionary *dicc = [TCServerSecret report:parameters];
            
            [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202019"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
                
                NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
                if ([codeStr isEqualToString:@"1"]){
                    
                    [self.dataSource removeObjectAtIndex:indexPath.row];
                    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    if (self.dataSource.count == 0){
                        [self initData];
                    }
                } else {
                    [TCProgressHUD showMessage:jsonDic[@"msg"]];
                }
                
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                nil;
            }];
            
        };
        [self.view addSubview:deleView];
    }];

    return @[action1, action2];
}

#pragma mark -- 添加品类
- (void)bottomAction:(UIButton *)sender
{
    TCAddCategoryViewController *addCateVC = [[TCAddCategoryViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCateVC animated:YES];
}

#pragma mark -- 添加品类
- (void)reloadData{
    TCAddCategoryViewController *addCateVC = [[TCAddCategoryViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCateVC animated:YES];
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
