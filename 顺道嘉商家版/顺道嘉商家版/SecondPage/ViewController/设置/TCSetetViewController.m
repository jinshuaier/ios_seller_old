//
//  TCSetetViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSetetViewController.h"
#import "TCSetetTableViewCell.h"
#import "TCSystemViewController.h" //声音信息
#import "TCAboutSDJViewController.h"
#import "TCYijianViewController.h"
#import "TCLoginViewController.h"

@interface TCSetetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *maintableView;
@property (nonatomic, strong) NSUserDefaults *userdefaults;

@end

@implementation TCSetetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"设置";
    self.userdefaults = [NSUserDefaults standardUserDefaults];
    //创建View
    [self createUI];
    // Do any additional setup after loading the view.
}


//创建View
- (void)createUI
{
    //创建tableView
    self.maintableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 45 * 5 + 20) style:(UITableViewStyleGrouped)];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    self.maintableView.showsVerticalScrollIndicator = NO;
    self.maintableView.backgroundColor = TCBgColor;
    self.maintableView.scrollEnabled = NO;
    self.maintableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.maintableView];
    
    //退出登录
    UIButton *tuiBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    tuiBtn.frame = CGRectMake(15, CGRectGetMaxY(self.maintableView.frame) + 40, WIDHT - 30, 46);
    tuiBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    tuiBtn.layer.cornerRadius = 5;
    tuiBtn.layer.masksToBounds = YES;
    [tuiBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [tuiBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    tuiBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [tuiBtn addTarget:self action:@selector(tuiAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tuiBtn];
}

//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 4;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCSetetTableViewCell *cell = [[TCSetetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    NSArray *arr = @[@"消息设置提醒",@"关于顺道嘉",@"给我们评价",@"意见反馈"];
    if (indexPath.section == 0){
        cell.titleLabel.text = arr[indexPath.row];
    } else {
        cell.goImage.hidden = YES;
        cell.titleLabel.text = @"免费客服电话：4000-111-228";
        cell.titleLabel.frame = CGRectMake(0, 0, WIDHT, 45);
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self fuwenbenLabel:cell.titleLabel FontNumber:[UIFont fontWithName:@"PingFangSC-Regular" size:12] AndRange:NSMakeRange(7, 12) AndColor:TCUIColorFromRGB(0x0276FF)];
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            NSLog(@"消息提醒");
            NSURL * url = [NSURL  URLWithString: UIApplicationOpenSettingsURLString];
            
            if ( [[UIApplication sharedApplication] canOpenURL: url] ) {
                
                NSURL*url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                [[UIApplication sharedApplication] openURL:url];
                
            }
        } else if (indexPath.row == 1){
            NSLog(@"关于顺道嘉");
            TCAboutSDJViewController *aboutVC = [[TCAboutSDJViewController alloc] init];
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
            aboutVC.hidesBottomBarWhenPushed = NO;
            
        } else if (indexPath.row == 2){
            NSLog(@"给我们评价");
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             @"1151304737"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        } else if (indexPath.row == 3){
            NSLog(@"意见反馈");
            TCYijianViewController *tijianVC = [[TCYijianViewController alloc] init];
            tijianVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tijianVC animated:YES];
            tijianVC.hidesBottomBarWhenPushed = NO;
        }
    }
    
    if (indexPath.section == 1){
        //拨打电话
        NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000-111-228"];
        // NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

//设置不同字体颜色
-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    labell.attributedText = str;
}

#pragma mark -- 退出登录
- (void)tuiAction:(UIButton *)sedner
{
    NSLog(@"退出");
    //先要设定hud的显示样式   注销.....
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"退出中..."];
    
    //请求接口
    NSString *timeStr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"timestamp":timeStr,@"token":tokenStr};
    NSString *signStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"mid":midStr,@"timestamp":timeStr,@"token":tokenStr,@"sign":signStr};
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202014"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@,%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            
            //移除userdefault中的内容
            [self.userdefaults removeObjectForKey:@"userID"];
            [self.userdefaults removeObjectForKey:@"showQR"];
            [self.userdefaults removeObjectForKey:@"userToken"];
            [self.userdefaults removeObjectForKey:@"shopID"];
            [self.userdefaults removeObjectForKey:@"userMobile"];
//            [self.userdefaults removeObjectForKey:@"registrationID"];
            
            //设置登录状态为否
            [self.userdefaults setValue:@"no" forKey:@"isLogin"];
            
//            [JPUSHService setTags:[NSSet set] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//                NSLog(@"没玩");
//            }];
            
            //关掉推送
            TCLoginViewController *loginVC = [[TCLoginViewController alloc]init];
            loginVC.isbool = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        [SVProgressHUD dismiss];
        [TCProgressHUD showMessage:jsonDic[@"msg"]];
        //成功后返回更新
    } failure:^(NSError *error) {
        nil;
    }];
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
