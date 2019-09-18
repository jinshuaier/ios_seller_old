////
////  TCStoreViewController.m
////  顺道嘉商家版
////
////  Created by 某某 on 16/8/22.
////  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
////
//
//#import "TCStoreViewController.h"
//#import "TCShopsTableViewCell.h"
//#import "MJRefresh.h"
//#import "TCExplainView.h"
//
//@interface TCStoreViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
//@property (nonatomic, strong) UITableView *leftTableview;
//@property (nonatomic, strong) UITableView *rightTableview;
//@property (nonatomic, strong) UIView *rviews;
//@property (nonatomic, strong) NSUserDefaults *userdefaults;
//@property (nonatomic, strong) NSMutableArray *firstSortArr;//存放一级分类
//@property (nonatomic, strong) NSMutableArray *secSortArr;//存放要通知传送的分类
//@property (nonatomic, assign) NSInteger selectCell;//记录选中的cell
//@property (nonatomic, strong) NSMutableArray *shopsMuArr;//存储请求到的商品信息
//@property (nonatomic, strong) NSMutableArray *xiajiaMuArr;//用来保存下架勾选的商品
//@property (nonatomic, strong) UIButton *xiajia;//下架按钮
//@property (nonatomic, strong) NSString *secondSortid;//保存二级分类id
//@property (nonatomic, assign) CGFloat currentX;
//@property (nonatomic, strong) UIButton *backTopBtn;//返回顶部按钮
//@property (nonatomic, assign) CGFloat reviewHeight; //rviews 的高度 （右侧tableview的高度）
//@property (nonatomic, assign) CGFloat xiajiaY;//下架按钮的y轴
//@end
//
//@implementation TCStoreViewController
//
//
//
//- (void)get:(NSNotification *)not{
//    //刷新
//    [self setupRefresh: not.userInfo[@"sort"]];
//    _secondSortid = not.userInfo[@"sort"];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    _xiajiaMuArr = [NSMutableArray array];
//    _secondSortid = @"";
//    //接收选择分类传来的分类id
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get:) name:@"sortRefresh" object:nil];
//
//    self.view.backgroundColor = [UIColor colorWithRed:242.0 / 255 green:242.0 / 255 blue:242.0 / 255 alpha:1];
//    _userdefaults = [NSUserDefaults standardUserDefaults];
//    _shopsMuArr = [NSMutableArray array];
//
//
//    //判断是商家还是其他
//    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"商家"]) {
//        _reviewHeight = HEIGHT - 100 * HEIGHTSCALE - 10 - 64;
//        _xiajiaY = HEIGHT - 50 * HEIGHTSCALE - 50 * HEIGHTSCALE - 5 - 64;
//    }else{
//        _reviewHeight = HEIGHT - 100 * HEIGHTSCALE - 10 - 64;
//        _xiajiaY = HEIGHT - 50 * HEIGHTSCALE - 50 * HEIGHTSCALE - 5 - 64 - 48;
//    }
//
//    //判断是商家 是否还有其他店铺
//    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"商家"] && [[_userdefaults valueForKey:@"userList"] isEqualToString:@"yes"]) {
//        _reviewHeight = HEIGHT - 100 * HEIGHTSCALE - 10 - 64;
//        _xiajiaY = HEIGHT - 50 * HEIGHTSCALE - 50 * HEIGHTSCALE - 5 - 64;
//    }else{
//        _reviewHeight = HEIGHT - 100 * HEIGHTSCALE - 10 - 64;
//        _xiajiaY = HEIGHT - 50 * HEIGHTSCALE - 50 * HEIGHTSCALE - 5 - 64 - 48;
//    }
//
//    _leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT / 4, HEIGHT - 50 * HEIGHTSCALE - 50 * HEIGHTSCALE - 5 - 64 - 5) style:UITableViewStylePlain];
//    _leftTableview.delegate = self;
//    _leftTableview.dataSource = self;
//    _leftTableview.rowHeight = 44 * HEIGHTSCALE;
//    _leftTableview.tableFooterView = [[UIView alloc]init];
//    _leftTableview.backgroundColor = [UIColor colorWithRed:242.0 / 255 green:242.0 / 255 blue:242.0 / 255 alpha:1];
//
//    //添加商品库说明的view
//    UIView *headTopView = [[UIView alloc] init];
//    headTopView.frame = CGRectMake(CGRectGetMaxX(_leftTableview.frame), 0, WIDHT / 4 * 3, 70);
//    headTopView.userInteractionEnabled = YES;
//    headTopView.backgroundColor = TCUIColorFromRGB(0xDAF2FF);
//    [self.view addSubview:headTopView];
//    
//    //添加手势到这个view
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
//    [headTopView addGestureRecognizer:tapGes];
//    
//    //添加商品库说明的视图
//    UIImageView *iconImage = [[UIImageView alloc] init];
//    iconImage.image = [UIImage imageNamed:@"问号"];
//    iconImage.frame = CGRectMake(7, 8, 16, 16);
//    [headTopView addSubview:iconImage];
//    //文字说明
//    UILabel *explainLabel = [[UILabel alloc] init];
//    explainLabel.frame = CGRectMake(CGRectGetMaxX(iconImage.frame) + 8, 10, CGRectGetMaxX(headTopView.frame) - CGRectGetMaxX(iconImage.frame) - 8, 14);
//    explainLabel.textAlignment = NSTextAlignmentLeft;
//    explainLabel.text = @"顺道嘉库使用方法及注意事项";
//    explainLabel.font = [UIFont systemFontOfSize:14];
//    explainLabel.textColor = TCUIColorFromRGB(0x24A7F2);
//    [headTopView addSubview:explainLabel];
//    //点击查看的文字
//    UILabel *examineLabel = [[UILabel alloc] init];
//    examineLabel.frame = CGRectMake(WIDHT / 4 * 3 - 48 - 24, CGRectGetMaxY(explainLabel.frame) + 20, 50, 14);
//    examineLabel.text = @"点击查看";
//    examineLabel.textAlignment = NSTextAlignmentLeft;
//    examineLabel.textColor = TCUIColorFromRGB(0x24A7F2);
//    examineLabel.font = [UIFont systemFontOfSize:12];
//    [headTopView addSubview:examineLabel];
//    //查看的图标
//    UIImageView *exImage = [[UIImageView alloc] init];
//    exImage.image = [UIImage imageNamed:@"双箭头进入图标"];
//    exImage.frame = CGRectMake(WIDHT / 4 * 3 - 11 -8, CGRectGetMaxY(explainLabel.frame) + 24, 8, 8);
//    [headTopView addSubview:exImage];
//    
//    
//    //右侧tableview加在上面
//    _rviews = [[UIView alloc]initWithFrame:CGRectMake(_leftTableview.frame.origin.x + _leftTableview.frame.size.width, 70, WIDHT / 4 * 3, _reviewHeight)];
//    _rviews.userInteractionEnabled = NO;
//    _currentX = _rviews.frame.origin.x;
//    [self.view addSubview: _rviews];
//
//    _rightTableview = [[UITableView alloc]initWithFrame:_rviews.bounds style:UITableViewStylePlain];
//    _rightTableview.delegate = self;
//    _rightTableview.dataSource = self;
//    _rightTableview.tableFooterView = [[UIView alloc]init];
//    _rightTableview.rowHeight = 167;
//
//
//    //加手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    pan.delegate = self;
//    [_rviews addGestureRecognizer: pan];
//    [self.view addSubview: _rviews];
//
//    [self requestleft];
//
//    //下架按钮
//    _xiajia = [UIButton buttonWithType:UIButtonTypeSystem];
//    _xiajia.frame = CGRectMake(35 * WIDHTSCALE, _xiajiaY, WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
//    _xiajia.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:0.7];
//    [_xiajia setTitle:@"确认添加" forState:UIControlStateNormal];
//    [_xiajia setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _xiajia.layer.cornerRadius = 5;
//    _xiajia.layer.masksToBounds = YES;
//    [_xiajia addTarget:self action:@selector(xiajiashijian) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview: _xiajia];
//
//    //返回顶部按钮
//    _backTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 40 * WIDHTSCALE - 40 * HEIGHTSCALE, _xiajia.frame.origin.y - 20 - 40 * HEIGHTSCALE, 40 * HEIGHTSCALE, 40 * HEIGHTSCALE)];
//    [_backTopBtn setImage:[UIImage imageNamed:@"backtop.png"] forState:UIControlStateNormal];
//    [_backTopBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
//    _backTopBtn.hidden = YES;
//    _backTopBtn.userInteractionEnabled = NO;
//    [self.view addSubview: _backTopBtn];
//
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(scrollView.contentOffset.y > 100){
//        _backTopBtn.hidden = NO;
//    }else{
//        _backTopBtn.hidden = YES;
//    }
//}
//- (void)backTop{
//    NSLog(@"点击了");
//    //    _rightTableview.scrollsToTop = YES;
//    [_rightTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
//
//
////请求右侧分类
//- (void)requestleft{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD showWithStatus:@"加载中..."];
//    _firstSortArr = [NSMutableArray array];
//    
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300107"] paramter:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":_shopid, @"showgoods":@"-1"} success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        if (jsonDic[@"data"]) {
//            //存储一级分类
//            [_firstSortArr addObjectsFromArray:jsonDic[@"data"][@"goods_types"]];
//            //重新设置左侧高度
//            if (_firstSortArr.count <= 9) {
//                _leftTableview.frame = CGRectMake(0, 0, WIDHT / 4, 44 * HEIGHTSCALE * _firstSortArr.count);
//            }else{
//                _leftTableview.frame = CGRectMake(0, 0, WIDHT / 4, 44 * HEIGHTSCALE * 9);
//            }
//            [self.view addSubview: _leftTableview];
//            _selectCell = 0;
//            [_leftTableview reloadData];
//            [SVProgressHUD dismiss];
//            if (_firstSortArr.count != 0) {
//                //默认下拉请求第一个分类
//                [self setupRefresh: _firstSortArr[0][@"id"]];
//                _rviews.userInteractionEnabled = YES;
//                [_rviews addSubview: _rightTableview];
//            }
//        }
//    } failure:^(NSError *error) {
//        nil;
//    }];
//}
//
//
//// 添加刷新
//- (void)setupRefresh:(NSString *)strid{
//    _rightTableview.userInteractionEnabled = NO;
//    _rviews.userInteractionEnabled = NO;
//    _leftTableview.userInteractionEnabled = NO;
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"noTouch" object:nil];
//    __block int page = 1;
//    //下拉
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        page = 1;
//
//        //下拉刷新
//        [self requestshops:strid];
//    }];
//    //设置刷新标题
//    [header setTitle:@"下拉刷新..." forState:MJRefreshStateIdle];
//    [header setTitle:@"松开刷新..." forState:MJRefreshStatePulling];
//    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
//    // 设置字体
//    header.stateLabel.font = [UIFont systemFontOfSize:12];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
//    // 设置颜色
//    header.stateLabel.textColor = [UIColor lightGrayColor];
//    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
//    //上拉加载
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        page++;
//        //上拉加载
//        [self requestshops:strid andpage:page];
//    }];
//    //设置上拉标题
//    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
//    [footer setTitle:@"正在加载更多..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"无更多!" forState:MJRefreshStateNoMoreData];
//    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.stateLabel.textColor = [UIColor lightGrayColor];
//
//    //加入tableview中
//    _rightTableview.mj_header = header;
//    _rightTableview.mj_footer = footer;
//    [header beginRefreshing];
//}
//
////下拉刷新
//- (void)requestshops:(NSString *)sortid{
//    [_shopsMuArr removeAllObjects];
//    _xiajia.userInteractionEnabled = NO;
//    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"catid":sortid, @"shopid":_shopid};
//    
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300108"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        if (jsonDic[@"data"]) {
//            [_shopsMuArr addObjectsFromArray: jsonDic[@"data"]];
//            [_rightTableview reloadData];
//            [_rightTableview.mj_header endRefreshing];
//        }else{
//            [_rightTableview.mj_header endRefreshing];
//            [_rightTableview reloadData];
//        }
//        _leftTableview.userInteractionEnabled = YES;
//        _rightTableview.userInteractionEnabled = YES;
//        _rviews.userInteractionEnabled = YES;
//        _backTopBtn.userInteractionEnabled = YES;
//        _xiajia.userInteractionEnabled = YES;
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"Touch" object:nil];
////        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
////        [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        nil;
//    }];
//    [_rightTableview.mj_footer resetNoMoreData];
//}
//
////上拉加载
//- (void)requestshops:(NSString *)sortid andpage:(int) page{
//    NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":_shopid, @"catid":sortid, @"page":@(page)};
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300108"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        if (jsonDic[@"data"]) {
//            [_shopsMuArr addObjectsFromArray: jsonDic[@"data"]];
//            [_rightTableview reloadData];
//            [_rightTableview.mj_footer endRefreshing];
//        }else{
//            [_rightTableview.mj_footer endRefreshing];
//            [_rightTableview.mj_footer endRefreshingWithNoMoreData];
//        }
//    } failure:^(NSError *error) {
//        nil;
//    }];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView == _leftTableview) {
//        return _firstSortArr.count;
//    }else{
//        return _shopsMuArr.count;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == _leftTableview) {
//        [_leftTableview registerNib:[UINib nibWithNibName:@"TCLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"ce"];
//        TCLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ce"];
//       
//        return cell;
//    }else{
//        [_rightTableview registerNib:[UINib nibWithNibName:@"TCShopsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells"];
//        TCShopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
//        if (_shopsMuArr.count != 0) {
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            //如果有中文
//            NSString *string1 = [_shopsMuArr[indexPath.row][@"images"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            [cell.shopimageviews sd_setImageWithURL:[NSURL URLWithString:string1] placeholderImage:[UIImage imageNamed:@"shopmo.png"]];
//            cell.shopname.text = _shopsMuArr[indexPath.row][@"name"];
//            cell.money.text = [NSString stringWithFormat:@"¥%@", _shopsMuArr[indexPath.row][@"price"]];
//            cell.select.tag = indexPath.row;
//            
//            if ([_shopsMuArr[indexPath.row][@"spec"] isEqualToString:@""]) {
//                cell.guige.text = @"规格:暂无";
//            }else{
//                cell.guige.text = [NSString stringWithFormat:@"规格:%@", _shopsMuArr[indexPath.row][@"spec"]];
//            }
//            if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
//                cell.kucun.text = [NSString stringWithFormat:@"库存量:%@", _shopsMuArr[indexPath.row][@"stockCount"]];
//                cell.kucun.hidden = NO;
//                if ([_shopsMuArr[indexPath.row][@"stockCount"] intValue] <= [_shopsMuArr[indexPath.row][@"warning"] intValue]) {
//                    cell.kucun.textColor = [UIColor redColor];
//                }else{
//                    cell.kucun.textColor = [UIColor blackColor];
//                }
//            }else{
//                cell.kucun.hidden = YES;
//            }
//            [cell.select addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
//            
//            if ([_shopsMuArr[indexPath.row][@"shophas"] intValue] == 1) {
//                [cell.select setImage:[UIImage imageNamed:@"选中框（灰色）"] forState:UIControlStateNormal];
//                cell.userInteractionEnabled = NO;
//                cell.select.selected = NO;
//            }else{
//                if ([_xiajiaMuArr containsObject: _shopsMuArr[indexPath.row][@"id"]]) {
//                   cell.select.selected = YES;
//            }else{
//                   cell.select.selected = NO;
//            }
//                [cell.select setImage:[UIImage imageNamed:@"商品未选中框x"] forState:UIControlStateNormal];
//                
//                cell.userInteractionEnabled = YES;
////                cell.select.selected = YES;
//            }
////            if ([_xiajiaMuArr containsObject: _shopsMuArr[indexPath.row][@"id"]]) {
////                cell.select.selected = YES;
////               
////            }else{
////                cell.select.selected = NO;
////            }
//            cell.bianji.hidden = YES;
//            
//        }
//        return cell;
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (tableView == _leftTableview) {
//        _selectCell = indexPath.row;
//        [_leftTableview reloadData];
//        _secondSortid = _firstSortArr[indexPath.row][@"id"];
//        [self setupRefresh: _firstSortArr[indexPath.row][@"id"]];
//        //发送通知 要求移除记录选择分类的按钮
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"removeSelect" object:nil];
//    }
//}
//
////- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
////
////    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
////    //x和y的最终值为1
////    [UIView animateWithDuration:0.5 animations:^{
////        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
////    }];
////}
//
//
//
////下架勾选按钮点击事件
//- (void)select:(UIButton *)sender{
//    NSLog(@"当前tag%ld", (long)sender.tag);
//    if ([_xiajiaMuArr containsObject: _shopsMuArr[sender.tag][@"id"]]) {
//        [_xiajiaMuArr removeObject:_shopsMuArr[sender.tag][@"id"]];
//    }else{
//        [_xiajiaMuArr addObject:_shopsMuArr[sender.tag][@"id"]];
//    }
//    [_rightTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//}
//
//- (void)pan:(UIPanGestureRecognizer *)pan{
//    CGPoint translation = [pan translationInView:_rviews];//得到手指的位移
//    //如果处于滑动状态
//    if (pan.state == UIGestureRecognizerStateChanged) {
//
//        //滑动之前判断当前rview位置  在1/4地方可以左滑动
//        if (_currentX == WIDHT / 4) {
//            //判断偏移量是否在指定范围内  0 -- 1/4
//            if (fabs(translation.x) >=0 && fabs(translation.x) <= WIDHT / 4) {
//                //如果向左滑动
//                if (translation.x < 0) {
//                    _leftTableview.alpha = 1- (1.0 / (WIDHT / 4) * (-translation.x));
//                    [_rviews setFrame:CGRectMake(_leftTableview.frame.origin.x + _leftTableview.frame.size.width + translation.x, _leftTableview.frame.origin.y, WIDHT / 4 * 3 - translation.x, _reviewHeight + translation.x)];
//                    _rightTableview.frame = _rviews.bounds;
//                    _xiajia.frame = CGRectMake(35 * WIDHTSCALE, _xiajiaY + translation.x, WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
//                    _backTopBtn.frame = CGRectMake(WIDHT - 40 * WIDHTSCALE - 40 * HEIGHTSCALE, _xiajia.frame.origin.y - 20 - 40 * HEIGHTSCALE, 40 * HEIGHTSCALE, 40 * HEIGHTSCALE);
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"panNotification" object:nil userInfo:@{@"translation":@(translation.x), @"xzhou":@(_rviews.frame.origin.x)}];
//                }
//            }
//        }
//
//        //判断是否在0位置  可以右滑动
//        if (_currentX == 0) {
//            if (fabs(translation.x) >=0 && fabs(translation.x) <= WIDHT / 4){
//                if (translation.x >= 0) {
//                    _leftTableview.alpha = (1.0 / (WIDHT / 4) * (translation.x));
//                    [_rviews setFrame:CGRectMake(0 + translation.x, _leftTableview.frame.origin.y, WIDHT - translation.x, _reviewHeight -80 * HEIGHTSCALE + translation.x)];
//                    _rightTableview.frame = _rviews.bounds;
//
//                    _xiajia.frame = CGRectMake(35 * WIDHTSCALE, _xiajiaY - 80 * HEIGHTSCALE + translation.x, WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
//                    _backTopBtn.frame = CGRectMake(WIDHT - 40 * WIDHTSCALE - 40 * HEIGHTSCALE, _xiajia.frame.origin.y - 20 - 40 * HEIGHTSCALE, 40 * HEIGHTSCALE, 40 * HEIGHTSCALE);
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"panNotification" object:nil userInfo:@{@"translation":@(translation.x), @"xzhou":@(_rviews.frame.origin.x)}];
//                }
//            }
//        }
//    }
//
//    //如果滑动结束
//    if (pan.state == UIGestureRecognizerStateEnded){
//        //获取当前右侧tableview的位置
//        CGFloat x = _rviews.frame.origin.x;
//        //如果范围在 1/4/2 --- 1/4 之间    还原
//        if (x > WIDHT / 4 / 2 && x <= WIDHT / 4) {
//            _leftTableview.alpha = 1;
//            [_rviews setFrame:CGRectMake(_leftTableview.frame.origin.x + _leftTableview.frame.size.width, 70, WIDHT / 4 * 3, _reviewHeight)];
//            _rightTableview.frame = _rviews.bounds;
//
//            _xiajia.frame = CGRectMake(35 * WIDHTSCALE, _xiajiaY, WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
//            _backTopBtn.frame = CGRectMake(WIDHT - 40 * WIDHTSCALE - 40 * HEIGHTSCALE, _xiajia.frame.origin.y - 20 - 40 * HEIGHTSCALE, 40 * HEIGHTSCALE, 40 * HEIGHTSCALE);
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"panNotificationStop" object:nil userInfo:@{@"xzhou":@(x), @"sort":_firstSortArr[_selectCell]}];
//        }
//
//        //如果方位在0---1/4/2之间   展开
//        if (x <= WIDHT / 4 / 2 && x >= 0) {
//            //展开
//            _leftTableview.alpha = 0;
//            [_rviews setFrame:CGRectMake(0, _leftTableview.frame.origin.y, WIDHT, _reviewHeight - 80 * HEIGHTSCALE)];
//            _rightTableview.frame = _rviews.bounds;
//
//            _xiajia.frame = CGRectMake(35 * WIDHTSCALE, _xiajiaY - 80 * HEIGHTSCALE, WIDHT - 70 * WIDHTSCALE , 50 * HEIGHTSCALE);
//
//            _backTopBtn.frame = CGRectMake(WIDHT - 40 * WIDHTSCALE - 40 * HEIGHTSCALE, _xiajia.frame.origin.y - 20 - 40 * HEIGHTSCALE, 40 * HEIGHTSCALE, 40 * HEIGHTSCALE);
//
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"panNotificationStop" object:nil userInfo:@{@"xzhou":@(x), @"sort":_firstSortArr[_selectCell]}];
//        }
//        //重新赋值   下次滑动可知道  允许哪个方向滑动
//        _currentX = _rviews.frame.origin.x;
//    }
//}
////下架事件
//- (void)xiajiashijian{
//    
//    if (_xiajiaMuArr.count != 0) {
//        NSString *str = _xiajiaMuArr[0];
//        for (int i = 1; i < _xiajiaMuArr.count; i++) {
//            str = [str stringByAppendingString:[NSString stringWithFormat:@",%@", _xiajiaMuArr[i]]];
//        }
//        NSLog(@"重组后 %@", str);
//        
//        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//        [SVProgressHUD showWithStatus:@"添加中..."];
//        _xiajia.userInteractionEnabled = NO;
//        //下架请求
//        NSDictionary *paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":_shopid, @"ids":str};
//        NSLog(@"%@",paramter);
//        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"300109"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//            
//            int retValue = [jsonDic[@"retValue"] intValue];
//            if (retValue > 0){
//                //刷新  如果存在二级分类id
//                if (![_secondSortid isEqualToString:@""]) {
//                    _xiajia.userInteractionEnabled = NO;
//                    [self setupRefresh:_secondSortid];
//                }else{
//                    _xiajia.userInteractionEnabled = NO;
//                    [self setupRefresh:_firstSortArr[_selectCell][@"id"]];
//                }
//            }else{
//                
//            }
//            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
//            _xiajia.userInteractionEnabled = YES;
//            
////            //刷新  如果存在二级分类id
////            if (![_secondSortid isEqualToString:@""]) {
////                _xiajia.userInteractionEnabled = NO;
////                [self setupRefresh:_secondSortid];
////            }else{
////                _xiajia.userInteractionEnabled = NO;
////                [self setupRefresh:_firstSortArr[_selectCell][@"id"]];
////            }
////            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
////           _xiajia.userInteractionEnabled = YES;
//        } failure:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:@"添加失败"];
//            _xiajia.userInteractionEnabled = YES;
//        }];
//      }
//
//}
//
//#pragma mark -- 点击查看更多顺道嘉库说明
//- (void)tapGes
//{
//    TCExplainView *exView = [[TCExplainView alloc] init];
//    [self.view addSubview:exView];
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear: YES];
//    [SVProgressHUD dismiss];
//}
//
//@end

