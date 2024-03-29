//
//  TCZiZhiInfoViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCZiZhiInfoViewController.h"
#import "TCZiZhiTableViewCell.h"
#import "TCLicenseViewController.h"
#import "TCIDViewController.h"
#import "TCSeniorityViewController.h"
#import "TCSetpwdViewController.h"
#import "TCShopinfoViewController.h"
#import "TCMyBankViewController.h"


@interface TCZiZhiInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *fooView;
@property (nonatomic, strong) UIButton *nextbtn;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSString *license;
@property (nonatomic, strong) NSString *id_info;
@property (nonatomic, strong) NSString *qualification;
@property (nonatomic, strong) NSString *bank;

@end

@implementation TCZiZhiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.enterStr isEqualToString:@"1"]) {
        self.title = @"店铺资质管理";
    }else{
         self.title = @"资质信息";
    }
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.titleArr = @[@"营业执照",@"店主手持身份证照",@"资质证明",@"收款信息"];
    self.dataArr = @[@"无营业执照商家需上传特许经营证",@"需上传店主或特许证件申请人手持身份证照，身份证可用其他有效证件替代",@"可用有效证件替代资质证明",@"可用有效证件替代资质证明"];
    self.view.backgroundColor = TCBgColor;
    [self creatState];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, WIDHT, 66)];
    view1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:view1];
    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT - 30, 36)];
    textlabel.numberOfLines = 0;
    textlabel.text = @"填写前，请准备好店主身份证，营业执照，食品流通许可证等证明";
    textlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    textlabel.textColor = TCUIColorFromRGB(0x53C3C3);
    textlabel.textAlignment = NSTextAlignmentLeft;
    CGSize size = [textlabel sizeThatFits:CGSizeMake(WIDHT - 30, MAXFLOAT)];
    textlabel.frame = CGRectMake(15, 15, WIDHT - 30, size.height);
    [view1 addSubview:textlabel];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), WIDHT, HEIGHT - 66 - 5 - 20 - 48) style:(UITableViewStylePlain)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.showsVerticalScrollIndicator = NO;//隐藏分割线
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(licenseyiwancheng) name:@"returnlicense" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idwancheng) name:@"returnid" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zizhiwancheng) name:@"returnzizhi" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bankwancheng) name:@"returnbankcard" object:nil];
}
-(void)creatState{
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"2"};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"2"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201014"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@--%@",jsonDic,jsonStr);
        self.license = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"license"]];
        self.id_info = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"id_info"]];
        self.qualification = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"qualification"]];
        self.bank = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"bank"]];
        [self.mainTableView reloadData];
//        [BQActivityView hideActiviTy];
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)licenseyiwancheng{
    [self creatState];
}
-(void)idwancheng{
     [self creatState];
}
-(void)bankwancheng{
    [self creatState];
}
-(void)zizhiwancheng{
     [self creatState];
}
#pragma mark -- tableViewDelegateMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
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
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UIView*footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDHT, 108)];
        footView.backgroundColor = TCBgColor;
        UIButton *nextbtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 40, WIDHT  - 30, 48)];
        self.nextbtn = nextbtn;
        if ([self.enterStr isEqualToString:@"1"]) {
            [nextbtn setTitle:@"确认提交" forState:(UIControlStateNormal)];
        }else{
            [nextbtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        }
        [nextbtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
        nextbtn.alpha = 1;
        [nextbtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
        [nextbtn addTarget:self action:@selector(clickNext:) forControlEvents:(UIControlEventTouchUpInside)];
        nextbtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        nextbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [footView addSubview:nextbtn];
        return footView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 131;
    }
    return 113;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 108;
    }
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCZiZhiTableViewCell *cell = [[TCZiZhiTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    cell.tag = indexPath.section + 10;
    cell.topLabel.text = self.titleArr[indexPath.section];
    cell.teLabel.text = self.dataArr[indexPath.section];
    if (indexPath.section == 1) {
        cell.grayView.frame = CGRectMake(15, CGRectGetMaxY(cell.topLabel.frame) + 10, WIDHT - 30, 66);
        cell.teLabel.numberOfLines = 0;
        CGSize size = [cell.teLabel sizeThatFits:CGSizeMake(WIDHT - 50, MAXFLOAT)];
        cell.teLabel.frame = CGRectMake(10, 15, WIDHT - 50, size.height);
        if ([self.id_info isEqualToString:@"0"]) {
            cell.stateLabel.text = @"待填写";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        }else if([self.id_info isEqualToString:@"1"]){
            cell.stateLabel.textColor = TCUIColorFromRGB(0x666666);
            cell.stateLabel.text = @"已完成";
        }else if ([self.id_info isEqualToString:@"2"]){
            cell.stateLabel.textColor = TCUIColorFromRGB(0xFF5544);
            cell.stateLabel.text = @"未完成";
        }
        
    }else if (indexPath.section == 0){
        if ([self.license isEqualToString:@"0"]) {
            cell.stateLabel.text = @"待填写";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        }else{
            cell.stateLabel.textColor = TCUIColorFromRGB(0x666666);
            cell.stateLabel.text = @"已完成";
        }
    }else if (indexPath.section == 2){
        if ([self.qualification isEqualToString:@"0"]) {
            cell.stateLabel.text = @"待填写";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        }else{
            cell.stateLabel.text = @"已完成";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x666666);
        }
    }else if (indexPath.section == 3){
        if ([self.bank isEqualToString:@"0"]) {
            cell.stateLabel.text = @"待填写";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x53C3C3);
        }else{
            cell.stateLabel.text = @"已完成";
            cell.stateLabel.textColor = TCUIColorFromRGB(0x666666);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%ld行",(long)indexPath.section);
    if (indexPath.section == 0) {
        TCLicenseViewController *licenseVC = [[TCLicenseViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:licenseVC animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else if (indexPath.section == 1){
        TCIDViewController *idVC = [[TCIDViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:idVC animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else if (indexPath.section == 2){
        TCSeniorityViewController *seniortyVC = [[TCSeniorityViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:seniortyVC animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else{
        if ([self.bank isEqualToString:@"0"]) {
            TCSetpwdViewController *setpwdVC = [[TCSetpwdViewController alloc]init];
            setpwdVC.titleStr = @"验证信息";
            setpwdVC.entranceTypeStr = @"0";
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setpwdVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }else{
            TCMyBankViewController *bankVC = [[TCMyBankViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bankVC animated:YES];
        }
    }
}

-(void)clickNext:(UIButton *)sender{
    
    if ([self.id_info isEqualToString:@"1"] && ![self.license isEqualToString:@"0"] && ![self.qualification isEqualToString:@"0"] && ![self.bank isEqualToString:@"0"]) {
        if ([sender.titleLabel.text isEqualToString:@"确认提交"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认修改店铺信息" message:@"修改您的店铺信息时您的店铺会保留原有信息作展示，客服审核通过后您的店铺将会以修改后的信息做展示。如果您需要快速上线可以联系客服，会加快您的审核进度。" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subView1 = alert.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *title = subView5.subviews[0];
            UILabel *message = subView5.subviews[1];
            message.textAlignment = NSTextAlignmentLeft;
            message.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            message.textColor = TCUIColorFromRGB(0x333333);
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认修改" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"进到下一步");
                TCShopinfoViewController *shopinfoVC  = [[TCShopinfoViewController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopinfoVC animated:YES];
            }];
            [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不修改" style:(UIAlertActionStyleCancel) handler:nil];
            [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
            [alert addAction:sure];
            [alert addAction:cancle];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            NSLog(@"进到下一步");
            TCShopinfoViewController *shopinfoVC  = [[TCShopinfoViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopinfoVC animated:YES];
        }
    } else {
        [TCProgressHUD showMessage:@"请您完善您的信息"];
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
