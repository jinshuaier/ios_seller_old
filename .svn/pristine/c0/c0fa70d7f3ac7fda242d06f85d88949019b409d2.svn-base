//
//  TCAddActiveViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddActiveViewController.h"
#import "TCActiveSetViewController.h"

@interface TCAddActiveViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UITextField *startfield;
@property (nonatomic, strong) UITextField *endfield;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *bgckView;
@property (nonatomic, strong) NSString *settimetitle;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSString *shopID;
@property (nonatomic, strong) NSString *manStr;
@property (nonatomic, strong) NSString *jianStr;

@end

@implementation TCAddActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"满减优惠活动";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 90)];
    bgView1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgView1];
    NSArray *titleArr = @[@"活动名称:",@"优惠设置"];
    for (int i = 0; i < titleArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 45*i, WIDHT, 45)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [bgView1 addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT/2 - 15, 15)];
        titleLabel.text = titleArr[i];
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        titleLabel.textColor = TCUIColorFromRGB(0x666666);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLabel];
        
        if (i == 0) {
            self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT/2, 15, WIDHT/2 - 15, 15)];
            self.nameLabel.text = @"默认为满多少减多少";
            self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.nameLabel.textColor = TCUIColorFromRGB(0xC4C4C4);
            self.nameLabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:self.nameLabel];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 44, WIDHT - 15, 1)];
            line.backgroundColor = TCLineColor;
            [view addSubview:line];
        }else{
            self.setBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 30 - 70, 15, 70, 15)];
            [self.setBtn setTitle:@"点击设置" forState:(UIControlStateNormal)];
            [self.setBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
            [self.setBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
            [self.setBtn addTarget:self action:@selector(clickSet:) forControlEvents:(UIControlEventTouchUpInside)];
            self.setBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.setBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:self.setBtn];
            
            UIImageView *sanimage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 - 5, 18.5, 5, 8)];
            sanimage.image = [UIImage imageNamed:@"进入小三角（灰）"];
            [view addSubview:sanimage];
        }
    }
    UIView *bgView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame) + 10, WIDHT, 90)];
    bgView2.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgView2];
    NSArray *naArr = @[@"开始时间:",@"结束时间:"];
    for (int j = 0; j < naArr.count; j++) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 45*j, WIDHT, 45)];
        view1.tag = 1000 + j;
        //加入手势
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [view1 addGestureRecognizer:tapView];
        view1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [bgView2 addSubview:view1];
        
        UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT/2 - 15, 15)];
        tLabel.text = naArr[j];
        tLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        tLabel.textColor = TCUIColorFromRGB(0x666666);
        tLabel.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:tLabel];
        

        
        if (j == 0) {
            self.startfield = [[UITextField alloc]initWithFrame:CGRectMake(WIDHT - 100 - 15, 15, 100, 15)];
            self.startfield.delegate = self;
            [self.startfield setEnabled:NO];
            
            self.startfield.borderStyle = UITextBorderStyleNone;
            self.startfield.textColor = TCUIColorFromRGB(0x53C3C3);
            self.startfield.textAlignment = NSTextAlignmentRight;
            self.startfield.text = @"点击设置";
            self.startfield.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [self.startfield addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventEditingChanged];
            [view1 addSubview:self.startfield];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 44, WIDHT - 15, 1)];
            line.backgroundColor = TCLineColor;
            [view1 addSubview:line];
        }else{
            self.endfield = [[UITextField alloc]initWithFrame:CGRectMake(WIDHT - 100 - 15, 15, 100, 15)];
            self.endfield.delegate = self;
            [self.endfield setEnabled:NO];
            self.endfield.borderStyle = UITextBorderStyleNone;
            self.endfield.textColor = TCUIColorFromRGB(0x53C3C3);
            self.endfield.textAlignment = NSTextAlignmentRight;
            self.endfield.text = @"点击设置";
            self.endfield.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            [self.endfield addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
            [view1 addSubview:self.endfield];
        }
    }
    UIView *bgView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView2.frame) + 10, WIDHT, 45)];
    bgView3.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgView3];
    UILabel *tiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT/2 - 15, 15)];
    tiLabel.text = @"参与商品";
    tiLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    tiLabel.textColor = TCUIColorFromRGB(0x666666);
    tiLabel.textAlignment = NSTextAlignmentLeft;
    [bgView3 addSubview:tiLabel];
    
    self.allLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT/2, 15, WIDHT/2 - 15, 15)];
    self.allLabel.text = @"全部";
    self.allLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.allLabel.textColor = TCUIColorFromRGB(0x333333);
    self.allLabel.textAlignment = NSTextAlignmentRight;
    [bgView3 addSubview:self.allLabel];
    
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(bgView3.frame) + 40, WIDHT - 30, 48)];
    self.sureBtn.alpha = 1;
    [self.sureBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [self.sureBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5;
    [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [self.sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.sureBtn];
    
}

//创建时间选择器
-(void)creatalphaView{
    self.bgckView = [[UIView alloc] init];
    self.bgckView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgckView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgckView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT - 358,WIDHT, 358)];
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 10;
    [self.bgckView addSubview:contentView];
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 16, 20, 16, 16)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"关闭按钮"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closealphaView) forControlEvents:(UIControlEventTouchUpInside)];
    [contentView addSubview:closeBtn];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 20, WIDHT, 17)];
    titlelabel.text = self.settimetitle;
    titlelabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    titlelabel.textColor = TCUIColorFromRGB(0x525F66);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titlelabel];
    
    
    UIDatePicker *oneDatapicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(titlelabel.frame) + 60, WIDHT - 120, 173)];
    //oneDatapicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM"]; // 设置时区，中国在东八区
    oneDatapicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
    oneDatapicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
    
    
    oneDatapicker.datePickerMode = UIDatePickerModeDate; // 设置样式
    // 以下为全部样式
    // typedef NS_ENUM(NSInteger, UIDatePickerMode) {
    //    UIDatePickerModeTime,           // 只显示时间
    //    UIDatePickerModeDate,           // 只显示日期
    //    UIDatePickerModeDateAndTime,    // 显示日期和时间
    //    UIDatePickerModeCountDownTimer  // 只显示小时和分钟 倒计时定时器
    // };
    
    //如果未选择时，这是默认的，切记切记
    NSDate *date=[NSDate date];
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date];
    self.startTime = dateAndTime;
    self.endTime = dateAndTime;
    
    [oneDatapicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    [contentView addSubview:oneDatapicker];
    
    UIButton *SuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneDatapicker.frame) + 40, WIDHT, 48)];
    [SuBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [SuBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    [SuBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [SuBtn addTarget:self action:@selector(clickSU:) forControlEvents:(UIControlEventTouchUpInside)];
    SuBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    SuBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:SuBtn];
}

#pragma mark - 实现oneDatePicker的监听方法
- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    if (_isStart == YES) {
        self.startTime = dateAndTime;
        
    }else{
        self.endTime = dateAndTime;
        
    }
    
}
- (void)alueChange:(UITextField *)textField{
    if ([self.startfield.text isEqualToString:@"点击设置"]) {
        
    }else if([self.endfield.text isEqualToString:@"点击设置"]){
        
    }else if ([self.nameLabel.text isEqualToString:@"默认为满多少减多少"]){
        
    }else{
        self.sureBtn.alpha = 1;
        self.sureBtn.userInteractionEnabled = YES;
    }
}

-(void)clickSU:(UIButton *)sender{
    [self closealphaView];
    if (_isStart == YES) {
        self.startfield.text = self.startTime;
        self.startfield.textColor = TCUIColorFromRGB(0x999C9E);
        
    }else{
        self.endfield.text = self.endTime;
        self.endfield.textColor = TCUIColorFromRGB(0x999C9E);
    }
}




-(void)closealphaView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
}

-(void)tapView:(UITapGestureRecognizer *)tapvi{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)tapvi;
    
    if ([tap view].tag == 1000){
        NSLog(@"设置开始时间");
        self.isStart = YES;
        self.settimetitle = @"设置开始时间";
    }else{
        NSLog(@"设置结束时间");
        self.isStart = NO;
        self.settimetitle = @"设置结束时间";
    }
    [self creatalphaView];
}

    


-(void)clickSet:(UIButton *)sender{
    NSLog(@"点击设置满减数额");
    TCActiveSetViewController *activeSet = [[TCActiveSetViewController alloc]init];
    activeSet.hidesBottomBarWhenPushed = YES;
    activeSet.block = ^(NSString *str, NSString *str2) {
        NSString *manjian = [NSString stringWithFormat:@"满%@减%@",str,str2];
        self.nameLabel.text = manjian;
        self.nameLabel.textColor = TCUIColorFromRGB(0x333333);
        self.manStr = str;
        self.jianStr = str2;
        if ([self.nameLabel.text isEqualToString:@"默认为满多少减多少"]) {
            
        }else{
            [self.setBtn setTitle:@"点击修改" forState:(UIControlStateNormal)];
        }
    };
    [self.navigationController pushViewController:activeSet animated:YES];
}
-(void)clickSure:(UIButton *)sender{
    NSLog(@"点击");
    if ([self.startfield.text isEqualToString:@"点击设置"]) {
        [TCProgressHUD showMessage:@"您还没有设置开始时间"];
    }else if([self.endfield.text isEqualToString:@"点击设置"]){
        [TCProgressHUD showMessage:@"您还没有设置结束时间"];
    }else if ([self.nameLabel.text isEqualToString:@"默认为满多少减多少"]){
        [TCProgressHUD showMessage:@"您还没有优惠设置"];
    }else{
        NSLog(@"点击清秋借口");
        [self creatRequest];
    }
}


-(void)creatRequest{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":self.shopID,@"content":self.nameLabel.text,@"startTime":self.startTime,@"endTime":self.endTime,@"achieve":self.manStr,@"reduce":self.jianStr,@"activityid":@"0"};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":mid,@"token":token,@"shopid":self.shopID,@"content":self.nameLabel.text,@"startTime":self.startTime,@"endTime":self.endTime,@"achieve":self.manStr,@"reduce":self.jianStr,@"activityid":@"0"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201016"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *str = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([str isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"returndis" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
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
