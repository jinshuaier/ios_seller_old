//
//  TCDealOrderViewController.m
//  商家版线下活动付款
//
//  Created by 胡高广 on 2017/5/25.
//  Copyright © 2017年 胡高广. All rights reserved.
//

#import "TCDealOrderViewController.h"
#import "TCServiceExplainViewController.h"

@interface TCDealOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *dealTableView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *chargeMoneyArr;
@end

@implementation TCDealOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.userdefault = [NSUserDefaults standardUserDefaults];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; 
    self.chargeMoneyArr = [NSArray array];
    //创建视图
    [self createUI];
    //请求接口
    [self createQuest];
    // Do any additional setup after loading the view.
}
//请求接口
-(void)createQuest
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"oid":self.oidStr};
    NSLog(@"%@",paramter);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200006"] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if (dic[@"data"]) {
            self.dic = dic[@"data"];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
        [self.dealTableView reloadData];
    } failure:^(NSError *error) {
        nil;
    }];
}

//创建视图
-(void)createUI
{
    //顶部返回
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, WIDHT, 64);
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"关闭按钮（导航上的）"] forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(5, 18, 48.1, 48.1);
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backBtn];
    //标题
    UILabel *navTitleLabel = [[UILabel alloc] init];
    navTitleLabel.frame = CGRectMake(0, 33, WIDHT, 18);
    navTitleLabel.text = @"交易订单";
    navTitleLabel.textColor = TCUIColorFromRGB(0x525F66);
    navTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:navTitleLabel];
    
    //创建tableView
    self.dealTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navTitleLabel.frame.size.height + navTitleLabel.frame.origin.y + 13, WIDHT, HEIGHT - 64) style:(UITableViewStylePlain)];
    self.dealTableView.dataSource = self;
    self.dealTableView.delegate = self;
    self.dealTableView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.dealTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.dealTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1){
        return 3;
    }else if (section == 2){
        return 6;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.section == 0){
        //上标题
        UIView *stateView = [[UIView alloc] init];
        stateView.frame = CGRectMake(0, 0, WIDHT, 32);
        stateView.backgroundColor = [TCUIColorFromRGB(0x24A7F2) colorWithAlphaComponent:0.2];
        [cell.contentView addSubview:stateView];
        //订单状态的头
        UILabel *stateTitleLabel = [[UILabel alloc] init];
        stateTitleLabel.frame = CGRectMake(12, 9, 56, 16);
        stateTitleLabel.text = @"订单状态";
        stateTitleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:13];
        stateTitleLabel.textColor = TCUIColorFromRGB(0x525F66);
        [stateView addSubview:stateTitleLabel];
        //状态
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.frame = CGRectMake(stateTitleLabel.frame.size.width + stateTitleLabel.frame.origin.x + 4, 9, WIDHT - 56 - 12 - 4, 16);
        stateLabel.text = @"已完成";
        stateLabel.textColor = TCUIColorFromRGB(0xFF2850);
        stateLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:13];
        stateLabel.textAlignment = NSTextAlignmentLeft;
        [stateView addSubview:stateLabel];
        //订单单号
        UILabel *orderNumberslabel = [[UILabel alloc] init];
        orderNumberslabel.frame = CGRectMake(12, stateView.frame.size.height + stateView.frame.origin.y + 16, WIDHT/2 + 40*WIDHTSCALE, 14*HEIGHTSCALE);
        orderNumberslabel.text = [NSString stringWithFormat:@"订货单号： %@",self.dic[@"ordersn"]];
        orderNumberslabel.textAlignment = NSTextAlignmentLeft;
        orderNumberslabel.textColor = TCUIColorFromRGB(0x999999);
        orderNumberslabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14*HEIGHTSCALE];
        [cell.contentView addSubview:orderNumberslabel];
        //下单时间
        UILabel *orderTimeLabel = [[UILabel alloc] init];
        orderTimeLabel.frame = CGRectMake(orderNumberslabel.frame.origin.x + orderNumberslabel.frame.origin.x , stateView.frame.size.height + stateView.frame.origin.y + 17, WIDHT - 12 - (orderNumberslabel.frame.origin.x + orderNumberslabel.frame.origin.x)*WIDHTSCALE , 12*HEIGHTSCALE);
        
        NSString*timeString = self.dic[@"payTime"];
        timeString = [timeString substringToIndex:10];//截取掉下标7之后的字符串
        orderTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",timeString];
        orderTimeLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:12*HEIGHTSCALE];
        orderTimeLabel.textColor = TCUIColorFromRGB(0x999999);
        orderTimeLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:orderTimeLabel];
        //支付方式
        UILabel *paymentTitleLable = [[UILabel alloc] init];
        paymentTitleLable.frame = CGRectMake(12, orderNumberslabel.frame.size.height + orderNumberslabel.frame.origin.y + 12, WIDHT - 24, 14);
        paymentTitleLable.textColor = TCUIColorFromRGB(0x999999);
        paymentTitleLable.font = [UIFont fontWithName:@".PingFangSC-Medium" size:14];
        NSString *paymentStr;
        if(![self.dic[@"payTime"] isEqualToString:@"0000-00-00 00:00:00"]){
            if([[NSString stringWithFormat:@"%@",self.dic[@"payType"]] isEqualToString:@"1"]){
                paymentStr = @"银行卡支付";
            }else if ([[NSString stringWithFormat:@"%@",self.dic[@"payType"]] isEqualToString:@"2"]){
                paymentStr = @"支付宝支付";
            }else if ([[NSString stringWithFormat:@"%@",self.dic[@"payType"]] isEqualToString:@"3"]){
                paymentStr = @"微信支付";
            }else if ([[NSString stringWithFormat:@"%@",self.dic[@"payType"]] isEqualToString:@"100"]){
                paymentStr = @"余额支付";
            }else if ([[NSString stringWithFormat:@"%@",self.dic[@"payType"]] isEqualToString:@"105"]){
                paymentStr = @"额度支付";
            }
        }else{
            paymentStr = @"未支付";
        }

        paymentTitleLable.text = [NSString stringWithFormat:@"支付方式：%@",paymentStr];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:paymentTitleLable.text];
        //设置颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName value:TCUIColorFromRGB(0x24A7F2) range:NSMakeRange(5, paymentStr.length)];
        paymentTitleLable.attributedText = attributedStr;
        [cell.contentView addSubview:paymentTitleLable];
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
            //店铺的名称
            UILabel *shopNameTitleLabel = [[UILabel alloc] init];
            shopNameTitleLabel.frame = CGRectMake(12, 12, 80, 20);
            shopNameTitleLabel.text = @"店铺名称：";
            shopNameTitleLabel.textColor = TCUIColorFromRGB(0x666666);
            shopNameTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            [cell.contentView addSubview:shopNameTitleLabel];
            //
            UILabel *shopNameLabel = [[UILabel alloc] init];
            shopNameLabel.frame = CGRectMake(shopNameTitleLabel.frame.size.width + shopNameTitleLabel.frame.origin.x + 4, 12, WIDHT - 24 - 4 - 80, 20);
            shopNameLabel.text = self.dic[@"shopname"];
            shopNameLabel.textColor = TCUIColorFromRGB(0x666666);
            shopNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            shopNameLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:shopNameLabel];
        }else if (indexPath.row == 1){
            //店铺的电话
            UILabel *shopTelTitleLabel = [[UILabel alloc] init];
            shopTelTitleLabel.frame = CGRectMake(12, 12, 80, 20);
            shopTelTitleLabel.text = @"店铺电话：";
            shopTelTitleLabel.textColor = TCUIColorFromRGB(0x666666);
            shopTelTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            [cell.contentView addSubview:shopTelTitleLabel];
            //
            UILabel *shopTelLabel = [[UILabel alloc] init];
            shopTelLabel.frame = CGRectMake(shopTelTitleLabel.frame.size.width + shopTelTitleLabel.frame.origin.x + 4, 12, WIDHT - 24 - 4 - 80, 20);
            shopTelLabel.text = self.dic[@"shoptel"];
            shopTelLabel.textColor = TCUIColorFromRGB(0x666666);
            shopTelLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            shopTelLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:shopTelLabel];
        }else if (indexPath.row == 2){
            //店铺的电话
            UILabel *shopadressTitleLabel = [[UILabel alloc] init];
            shopadressTitleLabel.frame = CGRectMake(12, 12, 80, 20);
            shopadressTitleLabel.text = @"店铺地址：";
            shopadressTitleLabel.textColor = TCUIColorFromRGB(0x666666);
            shopadressTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            [cell.contentView addSubview:shopadressTitleLabel];
            //
            UILabel *shopadressLabel = [[UILabel alloc] init];
            shopadressLabel.frame = CGRectMake(shopadressTitleLabel.frame.size.width + shopadressTitleLabel.frame.origin.x + 4, 12, WIDHT - 24 - 4 - 80, 20);
            shopadressLabel.text = self.dic[@"shopadd"];
            shopadressLabel.textColor = TCUIColorFromRGB(0x666666);
            shopadressLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            shopadressLabel.textAlignment = NSTextAlignmentLeft;
            shopadressLabel.numberOfLines = 0;
            CGSize titlesize = [shopadressLabel sizeThatFits:CGSizeMake(WIDHT - 24 - 4 - 80, MAXFLOAT)];
            shopadressLabel.frame = CGRectMake(shopadressTitleLabel.frame.size.width + shopadressTitleLabel.frame.origin.x + 4, 12, titlesize.width, titlesize.height);
            [cell.contentView addSubview:shopadressLabel];
            self.cellHeight = shopadressLabel.frame.size.height + 24;
        }
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            //实收的标题
            UILabel *officialTitleLabel = [[UILabel alloc] init];
            officialTitleLabel.frame = CGRectMake(12, 12, 72, 22);
            officialTitleLabel.text = @"店铺实收";
            officialTitleLabel.textColor = TCUIColorFromRGB(0x666666);
            officialTitleLabel.textAlignment = NSTextAlignmentLeft;
            officialTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            [cell.contentView addSubview:officialTitleLabel];
            //实收的钱
            UILabel *officialLabel = [[UILabel alloc] init];
            officialLabel.frame = CGRectMake(officialTitleLabel.frame.size.width + officialTitleLabel.frame.origin.x, 12, WIDHT - 12 - 12 - 72, 22);
            NSString *shopPayStr = [NSString stringWithFormat:@"%0.2f",[self.dic[@"shopGet"] floatValue]];
             //                       - [self.dic[@"fuwu"] floatValue]];
            officialLabel.text = [NSString stringWithFormat:@"¥%@",shopPayStr];
            officialLabel.textColor = TCUIColorFromRGB(0x333333);
            officialLabel.textAlignment = NSTextAlignmentRight;
            officialLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            [cell.contentView addSubview:officialLabel];
            //实收的描述
            UILabel *disOfficialLabel = [[UILabel alloc] init];
            disOfficialLabel.frame = CGRectMake(12, officialTitleLabel.frame.size.height + officialTitleLabel.frame.origin.y + 4, WIDHT - 24, 22);
            disOfficialLabel.text = @"(店铺实收=用户实付+优惠券+积分抵扣-服务费)";
            disOfficialLabel.textColor = TCUIColorFromRGB(0x999999);
            disOfficialLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            disOfficialLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:disOfficialLabel];
        }else{
            NSArray *chargeArr = @[@"订单金额",@"优惠券",@"积分抵扣",@"用户实付",@"服务费"];

            //收费标题
            UILabel *chargeTitleLabel = [[UILabel alloc] init];
            chargeTitleLabel.frame = CGRectMake(12, 12, WIDHT/2, 20);
            chargeTitleLabel.text = chargeArr[indexPath.row - 1];
            chargeTitleLabel.textColor = TCUIColorFromRGB(0x666666);
            chargeTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            chargeTitleLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:chargeTitleLabel];
            NSLog(@"%@",self.chargeMoneyArr);
            //收费
            if(self.dic){
                NSString *userPayStr = [NSString stringWithFormat:@"%0.2f", [self.dic[@"userPay"] floatValue]];
               self.chargeMoneyArr = @[self.dic[@"price"],self.dic[@"cpId"],self.dic[@"score"],userPayStr,self.dic[@"fuwu"]];
            }else{
               self.chargeMoneyArr = @[@"0",@"0",@"0",@"0",@"0"];
            }
            UILabel *chargeMoneyLabel = [[UILabel alloc] init];
            chargeMoneyLabel.frame = CGRectMake(WIDHT/2, 12, WIDHT/2 - 12, 20);
            chargeMoneyLabel.text = [NSString stringWithFormat:@"¥%@", self.chargeMoneyArr[indexPath.row - 1]];
        
            chargeMoneyLabel.textColor = TCUIColorFromRGB(0x666666);
            chargeMoneyLabel.textAlignment = NSTextAlignmentRight;
            chargeMoneyLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            [cell.contentView addSubview:chargeMoneyLabel];
        }
    }else if (indexPath.section == 3){
        
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 3){
        UIView *headView = [[UIView alloc]init];
        headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 104);
        //服务费说明
        UIButton *chargeExplainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chargeExplainBtn.frame = CGRectMake(WIDHT - 12 - 100, 5, 100, 20);
        [chargeExplainBtn setTitle:@"服务费说明" forState:UIControlStateNormal];
        [chargeExplainBtn setTitleColor:TCUIColorFromRGB(0x24A7F2) forState:(UIControlStateNormal)];
        [chargeExplainBtn setImage:[UIImage imageNamed:@"问号"] forState:(UIControlStateNormal)];
        [chargeExplainBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        chargeExplainBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [chargeExplainBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 0)];
        [chargeExplainBtn addTarget:self action:@selector(clickchargeExplai:) forControlEvents:(UIControlEventTouchUpInside)];
        //问题
        UILabel *questLabel = [[UILabel alloc]init];
        questLabel.frame = CGRectMake(24, 62, WIDHT - 48, 34);
        questLabel.textAlignment = NSTextAlignmentLeft;
        questLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        questLabel.textColor = TCUIColorFromRGB(0x666666);
        NSString *questStr = @"4000-111-228";
        questLabel.text = [NSString stringWithFormat:@"如有问题请及时和用户协商处理，如有其它问题请致电顺道嘉客服热线：%@",questStr];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:questLabel.text];
        //设置颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName value:TCUIColorFromRGB(0x24A7F2) range:NSMakeRange(32, questStr.length)];
        questLabel.attributedText = attributedStr;
        
        questLabel.numberOfLines = 0;
        CGSize titlesize = [questLabel sizeThatFits:CGSizeMake(WIDHT - 48, MAXFLOAT)];
        questLabel.frame = CGRectMake(24, 62, titlesize.width, titlesize.height);
        [headView addSubview:questLabel];
        [headView addSubview:chargeExplainBtn];
        return  headView;
      }
       return nil;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if(section == 2){
//        UIView *headView = [[UIView alloc]init];
//        headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 104);
//        //服务费说明
//        UIButton *chargeExplainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        chargeExplainBtn.frame = CGRectMake(262 + 10, 5, WIDHT - 262 - 12, 20);
//        [chargeExplainBtn setTitle:@"服务费说明" forState:UIControlStateNormal];
//        [chargeExplainBtn setTitleColor:TCUIColorFromRGB(0x24A7F2) forState:(UIControlStateNormal)];
//        [chargeExplainBtn setImage:[UIImage imageNamed:@"问号"] forState:(UIControlStateNormal)];
//        [chargeExplainBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//        chargeExplainBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//        [chargeExplainBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 8)];
//        [chargeExplainBtn addTarget:self action:@selector(clickchargeExplai:) forControlEvents:(UIControlEventTouchUpInside)];
//        //问题
//        UILabel *questLabel = [[UILabel alloc]init];
//        questLabel.frame = CGRectMake(24, 62, WIDHT - 48, 34);
//        questLabel.textAlignment = NSTextAlignmentLeft;
//        questLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//        questLabel.textColor = TCUIColorFromRGB(0x666666);
//        NSString *questStr = @"4000-111-228";
//        questLabel.text = [NSString stringWithFormat:@"如有问题请及时和用户协商处理，如有其它问题请致电顺道嘉客服热线：%@",questStr];
//        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:questLabel.text];
//        //设置颜色
//        [attributedStr addAttribute:NSForegroundColorAttributeName value:TCUIColorFromRGB(0x24A7F2) range:NSMakeRange(32, questStr.length)];
//        questLabel.attributedText = attributedStr;
//        
//        questLabel.numberOfLines = 0;
//        CGSize titlesize = [questLabel sizeThatFits:CGSizeMake(WIDHT - 48, MAXFLOAT)];
//        questLabel.frame = CGRectMake(24, 62, titlesize.width, titlesize.height);
//        [headView addSubview:questLabel];
//        [headView addSubview:chargeExplainBtn];
//        return  headView;
//    }
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 104;
    }else if (indexPath.section == 1){
        if(indexPath.row == 2 && self.dic){
           return self.cellHeight;
        }else{
           return 44;
        }
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            return 72;
        }else{
            return 44;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 3){
        return 104;
    }else{
        return 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if(section == 2){
//        return 104;
//    }
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
    [self.dealTableView deselectRowAtIndexPath:indexPath animated:YES];
 
}
#pragma mark -- 返回
-(void)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 收费说明
-(void)clickchargeExplai:(UIButton *)sener
{
    NSLog(@"说明");
    TCServiceExplainViewController *ServiceVC = [[TCServiceExplainViewController alloc] init];
    [self presentViewController:ServiceVC animated:YES completion:nil];
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
