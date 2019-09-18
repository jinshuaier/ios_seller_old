//
//  TCShopinfoViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopinfoViewController.h"
#import "TCChooseAddressViewController.h"
#import "TCShopImageViewController.h"
#import "TCApplyViewController.h"
#import "TCHtmlViewController.h"

@interface TCShopinfoViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *myScrollerView;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *addressView;
@property (nonatomic, strong) UIButton *peiBtn;
@property (nonatomic, strong) UITextField *startpf;
@property (nonatomic, strong) UITextField *peipf;
@property (nonatomic, strong) UITextField *peitimef;
@property (nonatomic, strong) UITextField *shopareaf;
@property (nonatomic, strong) UIButton *startTBtn;
@property (nonatomic, strong) UIButton *endTBtn;
@property (nonatomic, strong) UIButton *chuanBtn;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *chooseLabel;
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong) NSString *latitude;//纬度
@property (nonatomic, strong) NSString *address;//详细地址
@property (nonatomic, strong) NSString *locaddress;//定位地址
@property (nonatomic, strong) UIView *bgckView;
@property (nonatomic, strong) NSString *choosetimetitle;//时间选择器title
@property (nonatomic, strong) NSArray *hourArr;
@property (nonatomic, strong) NSArray *minArr;
@property (nonatomic, strong) UIPickerView *hourpicker;
@property (nonatomic, strong) UIPickerView *minpicker;
@property (nonatomic, assign)  BOOL isStart;
@property (nonatomic, strong) NSString *starttime;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *shopID;

@end

@implementation TCShopinfoViewController

-(void)viewWillAppear:(BOOL)animated{
   // [self request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.enterStr isEqualToString:@"1"]) {
        self.title = @"店铺信息管理";
    }else{
        self.title = @"店铺信息";
    }
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(picwancheng) name:@"returnshopinfo" object:nil];
    self.view.backgroundColor = TCBgColor;
    [self creatUI];
    [self request];
    // Do any additional setup after loading the view.
}
-(void)picwancheng{
    [self request];
}

-(void)request{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":self.shopID,@"type":@"3"};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *parameters = @{@"timestamp":Timestr,@"sign":singStr,@"mid":mid,@"token":token,@"shopid":self.shopID,@"type":@"3"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201014"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@-----%@",jsonDic,jsonDic);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            self.sureBtn.userInteractionEnabled = YES;
            self.sureBtn.alpha = 1;
            NSString *shopPic = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"shopPic"]];
            if ([shopPic isEqualToString:@"0"]) {
                [self.chuanBtn setTitle:@"立即上传" forState:(UIControlStateNormal)];
            }else{
                [self.chuanBtn setTitle:@"修改图片" forState:(UIControlStateNormal)];
            }
            NSString *areaStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"area"]];
            if ([areaStr isEqualToString:@"0"]) {
                
            }else{
            self.chooseLabel.text = [NSString stringWithFormat:@"%@%@",jsonDic[@"data"][@"locaddress"],jsonDic[@"data"][@"address"]];
            self.chooseLabel.textColor = TCUIColorFromRGB(0x333333);
            self.chooseLabel.numberOfLines = 0;
            self.chooseLabel.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [self.chooseLabel sizeThatFits:CGSizeMake(WIDHT - 120, MAXFLOAT)];
            self.chooseLabel.frame = CGRectMake(85, 15, WIDHT - 120, size.height);
            self.addressView.frame = CGRectMake(0, 10, WIDHT, CGRectGetMaxY(self.chooseLabel.frame) + 15);
            self.longitude = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"longtitude"]];
            self.latitude = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"latitude"]];
            self.address = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"address"]];
            self.locaddress = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"locaddress"]];
            self.startpf.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"startPrice"]];
            self.peipf.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"distributionPrice"]];
            self.peitimef.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"deliverTime"]];
            self.shopareaf.text = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"area"]];
            [self.startTBtn setTitle:[NSString stringWithFormat:@"%@",jsonDic[@"data"][@"startTime"]] forState:(UIControlStateNormal)];
            [self.endTBtn setTitle:[NSString stringWithFormat:@"%@",jsonDic[@"data"][@"endTime"]] forState:(UIControlStateNormal)];
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)creatUI{
    self.myScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    self.myScrollerView.contentSize = CGSizeMake(WIDHT, HEIGHT *1.2);
    self.myScrollerView.backgroundColor = TCBgColor;
    self.myScrollerView.showsVerticalScrollIndicator = false;
    self.myScrollerView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:self.myScrollerView];
    
    self.addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDHT, 50)];
    self.addressView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapText:)];
    [self.addressView addGestureRecognizer:tapText];
    [self.myScrollerView addSubview:self.addressView];
    
    UILabel *shopaddress = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 20)];
    shopaddress.text = @"店铺位置";
    shopaddress.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    shopaddress.textColor = TCUIColorFromRGB(0x666666);
    shopaddress.textAlignment = NSTextAlignmentLeft;
    [self.addressView addSubview:shopaddress];
    
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shopaddress.frame) + 10, 15, WIDHT- 120, 20)];
    self.chooseLabel = chooseLabel;
    chooseLabel.text = @"选择店铺位置";
    chooseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    chooseLabel.textColor = TCUIColorFromRGB(0xC4C4C4);
    chooseLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressView addSubview:chooseLabel];
    
    UIImageView *sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 - 5, 21, 5, 8)];
    sanImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
    [self.addressView addSubview:sanImage];
    
    UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.addressView.frame) + 10, WIDHT, 275)];
    bgView1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.myScrollerView addSubview:bgView1];
    
    UILabel *peiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 20)];
    peiLabel.text = @"配送方式";
    peiLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    peiLabel.textColor = TCUIColorFromRGB(0x666666);
    peiLabel.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:peiLabel];
    
    UILabel *mypeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(peiLabel.frame) + 10, 15, WIDHT - 135, 20)];
    mypeiLabel.text = @"我自己可以配送";
    mypeiLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    mypeiLabel.textColor = TCUIColorFromRGB(0x333333);
    mypeiLabel.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:mypeiLabel];
    
    self.peiBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 -20, 15, 20, 20)];
    [self.peiBtn setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:(UIControlStateNormal)];
    self.peiBtn.userInteractionEnabled = NO;
    [bgView1 addSubview:self.peiBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(85, CGRectGetMaxY(self.peiBtn.frame) + 14, WIDHT - 15, 1)];
    line1.backgroundColor = TCLineColor;
    [bgView1 addSubview:line1];
    
    UILabel *daojiapei = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(peiLabel.frame) + 13, CGRectGetMaxY(line1.frame) + 15, WIDHT/2, 20)];
    daojiapei.text = @"申请顺道嘉配送";
    daojiapei.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    daojiapei.textColor = TCUIColorFromRGB(0x999E9C);
    daojiapei.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:daojiapei];
    
    UILabel *expectLaebl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(peiLabel.frame) + 13,CGRectGetMaxY(daojiapei.frame) + 5, WIDHT - 88 - 15, 12)];
    expectLaebl.text = @"即将开展顺道嘉配送业务，敬请期待";
    expectLaebl.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    expectLaebl.textColor = TCUIColorFromRGB(0xC4C4C4);
    expectLaebl.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:expectLaebl];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(expectLaebl.frame) + 15, WIDHT - 15, 1)];
    line2.backgroundColor = TCLineColor;
    [bgView1 addSubview:line2];
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line2.frame) + 15, 90, 15)];
    startLabel.text = @"起送价(元)";
    startLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    startLabel.textColor = TCUIColorFromRGB(0x666666);
    startLabel.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:startLabel];
    
    self.startpf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLabel.frame) + 10, CGRectGetMaxY(line2.frame) + 15, WIDHT - 130, 15)];
    self.startpf.delegate = self;
    self.startpf.placeholder = @"输入价格";
    self.startpf.borderStyle = UITextBorderStyleNone;
    self.startpf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.startpf.textAlignment = NSTextAlignmentRight;
     [self.startpf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    [bgView1 addSubview:self.startpf];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(startLabel.frame) + 14, WIDHT - 15, 1)];
    line3.backgroundColor = TCLineColor;
    [bgView1 addSubview:line3];
    
    UILabel *peifee = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line3.frame) + 15, 90, 15)];
    peifee.text = @"配送费(元)";
    peifee.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    peifee.textColor = TCUIColorFromRGB(0x666666);
    peifee.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:peifee];
    
    self.peipf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(peifee.frame) + 10, CGRectGetMaxY(line3.frame) + 15, WIDHT - 130, 15)];
    self.peipf.delegate = self;
    self.peipf.placeholder = @"输入价格";
    self.peipf.borderStyle = UITextBorderStyleNone;
    self.peipf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.peipf.textAlignment = NSTextAlignmentRight;
     [self.peipf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    [bgView1 addSubview:self.peipf];
    
    UILabel *tisLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(peifee.frame) + 10, WIDHT - 30, 12)];
    tisLabel.text = @"如配送超时，平台会扣除您的配送费";
    tisLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    tisLabel.textColor = TCUIColorFromRGB(0x999E9C);
    tisLabel.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:tisLabel];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(tisLabel.frame) + 14, WIDHT -15, 1)];
    line4.backgroundColor = TCLineColor;
    [bgView1 addSubview:line4];
    
    UILabel *peitimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line4.frame) + 15, 120, 15)];
    peitimeLabel.text = @"配送时间(分钟)";
    peitimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    peitimeLabel.textColor = TCUIColorFromRGB(0x666666);
    peitimeLabel.textAlignment = NSTextAlignmentLeft;
    [bgView1 addSubview:peitimeLabel];
    
    self.peitimef = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(peitimeLabel.frame) + 10, CGRectGetMaxY(line4.frame) + 15, WIDHT - 160, 15)];
    self.peitimef.delegate = self;
    self.peitimef.placeholder = @"设置配送的时间";
    self.peitimef.borderStyle = UITextBorderStyleNone;
    self.peitimef.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.peitimef.textAlignment = NSTextAlignmentRight;
     [self.peitimef addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
    [bgView1 addSubview:self.peitimef];
    
    
    UIView *bgview2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame) + 10, WIDHT, 115)];
    bgview2.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.myScrollerView addSubview:bgview2];
    
    NSArray *titArr = @[@"营业时间",@"店铺面积(㎡)"];
    for (int i = 0; i < titArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 70 * i, WIDHT, 70)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [bgview2 addSubview:view];
        UILabel *tiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (view.frame.size.height - 15)/2, 100, 15)];
        tiLabel.text = titArr[i];
        tiLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        tiLabel.textColor = TCUIColorFromRGB(0x666666);
        tiLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:tiLabel];
        if (i == 0) {
            self.startTBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 245, 17.5, 90, 35)];
            [self.startTBtn setTitle:@"08:00" forState:(UIControlStateNormal)];
            self.startTBtn.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
            self.startTBtn.layer.borderWidth = 1;
            [self.startTBtn setTitleColor:TCUIColorFromRGB(0x333333) forState:(UIControlStateNormal)];
            [self.startTBtn addTarget:self action:@selector(clickStart:) forControlEvents:(UIControlEventTouchUpInside)];
            self.startTBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.startTBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:self.startTBtn];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.startTBtn.frame) + 10, 35, 30, 1)];
            line.backgroundColor = TCUIColorFromRGB(0xDEDEDE);
            [view addSubview:line];
            
            self.endTBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 15 - 90, 17.5, 90, 35)];
            [self.endTBtn setTitle:@"24:00" forState:(UIControlStateNormal)];
            [self.endTBtn setTitleColor:TCUIColorFromRGB(0x333333) forState:(UIControlStateNormal)];
            self.endTBtn.layer.borderWidth = 1;
            self.endTBtn.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
            [self.endTBtn addTarget:self action:@selector(clickEnd:) forControlEvents:(UIControlEventTouchUpInside)];
            self.endTBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.endTBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:self.endTBtn];
            
            UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.startTBtn.frame) + 16.5, WIDHT -15, 1)];
            line5.backgroundColor = TCLineColor;
            [view addSubview:line5];
            
        }else{
            view.frame = CGRectMake(0, 70, WIDHT, 45);
            tiLabel.frame = CGRectMake(15, 15, 100, 15);
            self.shopareaf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tiLabel.frame) + 10, 15, WIDHT - 115 - 10 - 15, 15)];
            self.shopareaf.delegate = self;
            self.shopareaf.placeholder = @"输入您的店铺面积";
            self.shopareaf.borderStyle = UITextBorderStyleNone;
            self.shopareaf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            self.shopareaf.textAlignment = NSTextAlignmentRight;
            [self.shopareaf addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
            [view addSubview:self.shopareaf];
            
        }
    }

    UIView *shopPicView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgview2.frame) + 10, WIDHT, 50)];
    shopPicView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.myScrollerView addSubview:shopPicView];
    
    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 17.5, 120, 20)];
    picLabel.text = @"店铺照片";
    picLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    picLabel.textColor = TCUIColorFromRGB(0x666666);
    picLabel.textAlignment = NSTextAlignmentLeft;
    [shopPicView addSubview:picLabel];
    
    self.chuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT- 15 - 5 - 15 - 60, 17.5, 60, 15)];
    [self.chuanBtn setTitle:@"立即上传" forState:(UIControlStateNormal)];
    [self.chuanBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [self.chuanBtn addTarget:self action:@selector(chuanPic:) forControlEvents:(UIControlEventTouchUpInside)];
    self.chuanBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.chuanBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [shopPicView addSubview:self.chuanBtn];
    
    UIImageView *sanjiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 -5, 21, 5, 8)];
    sanjiaoImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
    [shopPicView addSubview:sanjiaoImage];
    
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(shopPicView.frame) + 11, 16, 16)];
    self.checkBtn.selected = YES;
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"小选中框"] forState:(UIControlStateSelected)];
    [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"选中框（灰）"] forState:(UIControlStateNormal)];
    [self.checkBtn addTarget:self action:@selector(clickCheck:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.myScrollerView addSubview:self.checkBtn];
    
    UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkBtn.frame) + 5, CGRectGetMaxY(shopPicView.frame) + 13, 24, 12)];
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    agreeLabel.textColor = TCUIColorFromRGB(0x333333);
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    [self.myScrollerView addSubview:agreeLabel];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(agreeLabel.frame), CGRectGetMaxY(shopPicView.frame) + 13, 100, 12)];
    [serviceBtn setBackgroundColor:TCBgColor];
    [serviceBtn setTitle:@"《商家入驻协议》" forState:(UIControlStateNormal)];
    [serviceBtn setTitleColor:TCUIColorFromRGB(0x4CA6FF) forState:(UIControlStateNormal)];
    [serviceBtn addTarget:self action:@selector(clickService:) forControlEvents:(UIControlEventTouchUpInside)
     ];
    serviceBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    serviceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.myScrollerView addSubview:serviceBtn];


    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(serviceBtn.frame) + 40, WIDHT -30, 48)];
    self.sureBtn.alpha = 0.6;
    self.sureBtn.userInteractionEnabled = NO;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 4;
    [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [self.sureBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    if ([self.enterStr isEqualToString:@"1"]) {
        [self.sureBtn setTitle:@"确认提交" forState:(UIControlStateNormal)];
    }else{
        [self.sureBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    }
    
    [self.sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    self.sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.myScrollerView addSubview:self.sureBtn];
}

- (void)alueChange:(UITextField *)textField{
    self.sureBtn.enabled = (_startpf.text.length != 0 && _peipf.text.length != 0 && _peitimef.text.length != 0 && _shopareaf.text.length != 0);
    if (self.sureBtn.enabled == YES) {
        self.sureBtn.alpha = 1;
        self.sureBtn.userInteractionEnabled = YES;
        
    }else{
        self.sureBtn.alpha = 0.6;
        self.sureBtn.userInteractionEnabled = NO;
    }
}

-(void)clickSure:(UIButton *)sender{
    NSLog(@"点击完成");
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
            if (self.peitimef.text.length > 0 && self.shopareaf.text.length > 0 && self.startpf.text.length > 0 && self.peipf.text.length > 0) {
                [self creatRequest];
            } else {
                [TCProgressHUD showMessage:@"请您完善信息"];
            }
        }];
        [sure setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"暂不修改" style:(UIAlertActionStyleCancel) handler:nil];
        [cancle setValue:TCUIColorFromRGB(0x53C3C3) forKey:@"_titleTextColor"];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if (self.peitimef.text.length > 0 && self.shopareaf.text.length > 0 && self.startpf.text.length > 0 && self.peipf.text.length > 0) {
            [self creatRequest];
        } else {
            [TCProgressHUD showMessage:@"请您完善信息"];
        }
    }
}

-(void)creatRequest{
//    [BQActivityView showActiviTy];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"address":self.address,@"locaddress":self.locaddress,@"latitude":self.latitude,@"longtitude":self.longitude,@"shopTimeStart":self.startTBtn.titleLabel.text,@"shopTimeEnd":self.endTBtn.titleLabel.text,@"deliverTime":self.peitimef.text,@"area":self.shopareaf.text,@"startPrice":self.startpf.text,@"distributionPrice":self.peipf.text};
    NSString *signStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"address":self.address,@"locaddress":self.locaddress,@"latitude":self.latitude,@"longtitude":self.longitude,@"shopTimeStart":self.startTBtn.titleLabel.text,@"shopTimeEnd":self.endTBtn.titleLabel.text,@"deliverTime":self.peitimef.text,@"area":self.shopareaf.text,@"startPrice":self.startpf.text,@"distributionPrice":self.peipf.text,@"sign":signStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201008"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
            TCApplyViewController *applyVC = [[TCApplyViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:applyVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
//        [BQActivityView hideActiviTy];
    } failure:^(NSError *error) {
        nil;
    }];
    
}
//点击用户服务协议
-(void)clickService:(UIButton*)sender{
    NSLog(@"点击了用户服务协议");
    TCHtmlViewController *htmlVC = [[TCHtmlViewController alloc] init];
    htmlVC.hidesBottomBarWhenPushed = YES;
    htmlVC.html = @"https://h5.moumou001.com/help/seller/protocol.html";
    htmlVC.title = @"服务协议";
    [self.navigationController pushViewController:htmlVC animated:YES];
    htmlVC.hidesBottomBarWhenPushed = NO;
}

-(void)clickCheck:(UIButton *)sender{
    sender.selected = !sender.selected;
}
-(void)tapText:(UITapGestureRecognizer *)tap{
    NSLog(@"进入地图选择位置");
    TCChooseAddressViewController *chooseAddressVC = [[TCChooseAddressViewController alloc]init];
    chooseAddressVC.diBlock = ^(NSString *address, NSString *locaddress, NSString *longtitude, NSString *latitude) {
        self.chooseLabel.text = [NSString stringWithFormat:@"%@%@",locaddress,address];
        self.chooseLabel.textColor = TCUIColorFromRGB(0x333333);
        self.chooseLabel.numberOfLines = 0;
        self.chooseLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [self.chooseLabel sizeThatFits:CGSizeMake(WIDHT - 120, MAXFLOAT)];
        self.chooseLabel.frame = CGRectMake(85, 15, WIDHT - 120, size.height);
        self.addressView.frame = CGRectMake(0, 10, WIDHT, CGRectGetMaxY(self.chooseLabel.frame) + 15);
        self.longitude = longtitude;
        self.latitude = latitude;
        self.address = address;
        self.locaddress = locaddress;
    };

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseAddressVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}
-(void)clickStart:(UIButton *)sender{
    NSLog(@"弹出时间选择器，营业时间");
    self.isStart = YES;
    self.choosetimetitle = @"选择开始时间";
    [self creatalphaView];
}
-(void)clickEnd:(UIButton *)sender{
    NSLog(@"弹出时间选择器，休息时间");
    self.isStart = NO;
    self.choosetimetitle = @"选择关闭时间";
    [self creatalphaView];
}
//创建时间选择器
-(void)creatalphaView{
    self.bgckView = [[UIView alloc] init];
    self.bgckView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgckView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgckView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT - 437,WIDHT, 437)];
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 10;
    [self.bgckView addSubview:contentView];
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 10 - 16, 10, 16, 16)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"关闭按钮"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closealphaView) forControlEvents:(UIControlEventTouchUpInside)];
    [contentView addSubview:closeBtn];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(closeBtn.frame) + 8, WIDHT, 17)];
    titlelabel.text = self.choosetimetitle;
    titlelabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    titlelabel.textColor = TCUIColorFromRGB(0x525F66);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titlelabel];
    
    
    UIDatePicker *oneDatapicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(titlelabel.frame) + 20, WIDHT - 120, 286)];
    oneDatapicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM"]; // 设置时区，中国在东八区
    oneDatapicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
    oneDatapicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
    


    oneDatapicker.datePickerMode = UIDatePickerModeTime; // 设置样式
    // 以下为全部样式
    // typedef NS_ENUM(NSInteger, UIDatePickerMode) {
    //    UIDatePickerModeTime,           // 只显示时间
    //    UIDatePickerModeDate,           // 只显示日期
    //    UIDatePickerModeDateAndTime,    // 显示日期和时间
    //    UIDatePickerModeCountDownTimer  // 只显示小时和分钟 倒计时定时器
    // };
    [oneDatapicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    [contentView addSubview:oneDatapicker];
    
    UIButton *SuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneDatapicker.frame) + 20, WIDHT, 48)];
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
    selectDateFormatter.dateFormat = @"HH:mm"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    if (_isStart == YES) {
        self.starttime = dateAndTime;
       
    }else{
        self.endtime = dateAndTime;
        
    }
    
}

-(void)clickSU:(UIButton *)sender{
    [self closealphaView];
    if (_isStart == YES) {
         [self.startTBtn setTitle:_starttime forState:(UIControlStateNormal)];
    }else{
        [self.endTBtn setTitle:_endtime forState:(UIControlStateNormal)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.startpf resignFirstResponder];
    [self.peipf resignFirstResponder];
    [self.peitimef resignFirstResponder];
    [self.shopareaf resignFirstResponder];
}


-(void)closealphaView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
}


-(void)chuanPic:(UIButton *)sender{
    NSLog(@"去串店铺图片界面w");
    TCShopImageViewController *shopImageVC = [[TCShopImageViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopImageVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
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
