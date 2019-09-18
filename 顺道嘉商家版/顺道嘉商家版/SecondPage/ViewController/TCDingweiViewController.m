//
//  TCDingweiViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/8.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCDingweiViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "TCseTableViewCell.h"
#import "SVProgressHUD.h"


@interface TCDingweiViewController ()<UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AMapLocationManagerDelegate>
@property (nonatomic, strong) UISearchController *searchcontroller;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UITableView *newtableview;
@property(nonatomic,retain) NSArray *searchResults;
@property(nonatomic,retain) NSArray *items;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@end

@implementation TCDingweiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择定位";
    _userdefaults = [NSUserDefaults standardUserDefaults];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"×" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = left;
    _searchResults = @[@"弗雷尔卓德 Freijord",
                        @"班德尔城 Bandle City",
                        @"无畏先锋"];
    _items = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
               @"比尔吉沃特(Bill Ji walter)",
                                     @"瓦洛兰 Valoran",
                                     @"祖安 Zaun",
                                     @"德玛西亚 Demacia",
                                     @"诺克萨斯 Noxus",
                                     @"艾欧尼亚 Ionia",
                                     @"皮尔特沃夫 Piltover",
                                     @"弗雷尔卓德 Freijord",
                                     @"班德尔城 Bandle City",
                                     @"无畏先锋",
                                     @"战争学院 The Institute of War",
                                     @"巨神峰",
                                     @"雷瑟守备(JustThunder)",
                                     @"裁决之地(JustRule)"];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];

    _newtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDHT, HEIGHT) style:UITableViewStylePlain];
    _newtableview.delegate = self;
    _newtableview.dataSource = self;
    _newtableview.hidden = YES;
    [self.view addSubview:_newtableview];

    _locationManager = [[AMapLocationManager alloc]init];
    _locationManager.delegate = self;

    self.searchcontroller = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchcontroller.searchBar.placeholder = @"请输入您的位置信息";
    [self.searchcontroller.searchBar sizeToFit];

    self.searchcontroller.searchResultsUpdater = self;
    self.searchcontroller.dimsBackgroundDuringPresentation = NO;
    self.searchcontroller.searchBar.delegate = self;
    self.searchcontroller.searchBar.tintColor = [UIColor whiteColor];
    [self.searchcontroller.searchBar setBackgroundImage:[[UIImage alloc]init]];
    [self.searchcontroller.searchBar setBackgroundColor:Color];//背景色
    self.searchcontroller.searchBar.barTintColor = Color;//可改变编辑状态下的颜色
//    self.tableview.tableHeaderView = self.searchcontroller.searchBar;
    _searchcontroller.searchBar.userInteractionEnabled = NO;

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (self.searchcontroller.active) {
        _tableview.frame = CGRectMake(0, 64, WIDHT, HEIGHT);
        _newtableview.hidden = NO;
    }else{
        _tableview.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
        _newtableview.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableview) {
        //未编辑
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableview) {
        return 1;
    }else{
        return _searchResults.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
    if (tableView == _tableview) {
        if (![self.userdefaults valueForKey:@"currentAdd"]) {
            cell.textLabel.text = @"点击获取当前位置信息";
            return cell;
        }else{
            [_tableview registerNib:[UINib nibWithNibName:@"TCseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            TCseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            //未编辑
            cell.titles.text = [_userdefaults valueForKey:@"currentAdd"];
            [cell.btn addTarget:self action:@selector(zidong) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else{
        cell.textLabel.text = @"haha";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _tableview) {
        [self zidong];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"当前位置";
}

//自动定位
- (void)zidong{
    [SVProgressHUD showWithStatus:@"获取位置中..."];
    //一次定位 精度10米
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //定位超时
    _locationManager.locationTimeout = 2;
    //逆地理超时
    _locationManager.reGeocodeTimeout = 12;
    //得到数据
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed) {
                return ;
            }
        }
        NSLog(@"location:%f  %f", location.coordinate.latitude, location.coordinate.longitude);
        if (regeocode){
            NSLog(@"reGeocode:%@   \n位置%@", regeocode, regeocode.formattedAddress);
            [SVProgressHUD dismiss];
            //持久化定位地点
            [_userdefaults setValue:regeocode.formattedAddress forKey:@"currentAdd"];

            NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
            NSString *lon = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
            //持久化经纬度
            [_userdefaults setValue:lat forKey:@"latitude"];
            [_userdefaults setValue:lon forKey:@"longitude"];

            if([_userdefaults valueForKey:@"longitude"]){
               [[NSNotificationCenter defaultCenter]postNotificationName:@"locationmess" object:nil userInfo:@{@"currentAdd":[_userdefaults valueForKey:@"currentAdd"], @"lat":[_userdefaults valueForKey:@"latitude"], @"lon":[_userdefaults valueForKey:@"longitude"]}];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:@"定位失败"];
            }
            [_tableview reloadData];
        }
    }];
}

- (void)dismiss{
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
