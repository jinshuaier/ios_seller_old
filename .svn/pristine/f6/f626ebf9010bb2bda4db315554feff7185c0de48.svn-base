//
//  TCCreateOffActityViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/24.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCreateOffActityViewController.h"
#define kMaxTextCount 25 //限制的25个字
@interface TCCreateOffActityViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) UILabel *texteLabel;
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCCreateOffActityViewController

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    //创建导航栏的View
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, WIDHT, 64);
    navView.backgroundColor = mainColor;
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, 22, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backBtn];
    //店铺的标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 33, WIDHT, 18);
    if(self.isChange == YES){
        titleLabel.text = @"修改活动";
    }else{
        titleLabel.text = @"创建活动";
    }
    titleLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
   
    self.view.backgroundColor = NEWMAINCOLOR;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    //创建视图
    [self createUI];
    // Do any additional setup after loading the view.
}
//创建视图
-(void)createUI
{
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = CGRectMake(0, 12 + 64, WIDHT, 240);
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    //活动描述
    UILabel *describeLable = [[UILabel alloc] init];
    describeLable.frame = CGRectMake(12, 12, WIDHT, 20);
    describeLable.text = @"活动描述（如：满十减一）";
    describeLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    describeLable.textColor = TCUIColorFromRGB(0x32ACF2);
    describeLable.textAlignment = NSTextAlignmentLeft;
    [mainView addSubview:describeLable];
    //创建textview的view
    UIView *writeView = [[UIView alloc] init];
    writeView.frame = CGRectMake(12, describeLable.frame.size.height + describeLable.frame.origin.y + 12 , WIDHT - 24, 156);
    writeView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    writeView.layer.borderWidth = 1;
    writeView.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
    [mainView addSubview:writeView];
    
    //此处解决从头开始输入
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textview = [[UITextView alloc]init];
    self.textview.frame = CGRectMake(10, 5 , writeView.frame.size.width - 32, 156 - 5);
    self.textview.delegate = self;
    self.textview.textColor = TCUIColorFromRGB(0x333333);
    self.textview.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.textview.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.textview.tintColor = TCUIColorFromRGB(0x32ACF2);
    [writeView addSubview:self.textview];
    //添加label
    self.texteLabel = [[UILabel alloc]init];
    self.texteLabel.frame = CGRectMake(16, 16, writeView.frame.size.width - 32, 22);
    self.texteLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.texteLabel.text = @"填写您的活动内容（限定25字以内）";
    self.texteLabel.textColor = TCUIColorFromRGB(0xC4C4C4);
    [writeView addSubview:self.texteLabel];
    //修改
    if(self.isChange == YES){
        self.textview.text = self.content;
        self.texteLabel.hidden = YES;
    }
    
    //提交的按钮
    //阴影
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(12, mainView.frame.size.height + mainView.frame.origin.y + 64, WIDHT - 24, 48);
    layer.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 0.5;
    layer.cornerRadius = 48/2;
    [self.view.layer addSublayer:layer];
    
    self.publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.publishButton.frame = CGRectMake(12, mainView.frame.size.height + mainView.frame.origin.y + 64, WIDHT - 24, 48);
    //self.publishButton.backgroundColor = TCUIColorFromRGB(0xEDEDED);
    self.publishButton.layer.cornerRadius = 48/2;
    self.publishButton.clipsToBounds = YES;
    self.publishButton.userInteractionEnabled = NO;
    [self.publishButton addTarget:self action:@selector(pubClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.publishButton];
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0xDEDEDE).CGColor, (__bridge id)TCUIColorFromRGB(0xCCCCCC).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
    [self.publishButton.layer addSublayer:gradientLayer];
    
    //button里面的文字
    UILabel *btnLabel = [[UILabel alloc] init];
    btnLabel.frame = CGRectMake(0, 15, self.publishButton.frame.size.width, 18);
    btnLabel.text = @"提交活动";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [self.publishButton addSubview:btnLabel];
    //修改
    if(self.isChange == YES){
        self.publishButton.userInteractionEnabled = YES;
        //渐变颜色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1AC6FF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
        [self.publishButton.layer addSublayer:gradientLayer];
        //button里面的文字
        UILabel *btnLabel = [[UILabel alloc] init];
        btnLabel.frame = CGRectMake(0, 15, self.publishButton.frame.size.width, 18);
        btnLabel.text = @"提交活动";
        btnLabel.textAlignment = NSTextAlignmentCenter;
        btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
        [self.publishButton addSubview:btnLabel];
    }
    //view上加手势，键盘下滑
    UITapGestureRecognizer *viewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:viewtap];
}
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}
#pragma mark -- 键盘下滑的手势
-(void)viewTap{
    [self.textview resignFirstResponder];
}
//textView的代理方法
//判断开始输入
-(void)textViewDidChange:(UITextView *)textView
{
    [self check];
    if(textView.text.length > 0){
        self.texteLabel.hidden = YES;
    }else{
        self.texteLabel.hidden = NO;
    }
    if(textView.text.length >= kMaxTextCount){
        //截取字符串
        textView.text = [textView.text substringToIndex:25];
    }
}
#pragma mark -- 方法
- (void)check{
    if (![self.textview.text isEqualToString:@""]) {
        self.publishButton.userInteractionEnabled = YES;
        //渐变颜色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1AC6FF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
        [self.publishButton.layer addSublayer:gradientLayer];
        //button里面的文字
        UILabel *btnLabel = [[UILabel alloc] init];
        btnLabel.frame = CGRectMake(0, 15, self.publishButton.frame.size.width, 18);
        btnLabel.text = @"提交活动";
        btnLabel.textAlignment = NSTextAlignmentCenter;
        btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
        [self.publishButton addSubview:btnLabel];
    }else{
        self.publishButton.userInteractionEnabled = NO;
        //渐变颜色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0xDEDEDE).CGColor, (__bridge id)TCUIColorFromRGB(0xCCCCCC).CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
        [self.publishButton.layer addSublayer:gradientLayer];
        //button里面的文字
        UILabel *btnLabel = [[UILabel alloc] init];
        btnLabel.frame = CGRectMake(0, 15, self.publishButton.frame.size.width, 18);
        btnLabel.text = @"提交活动";
        btnLabel.textAlignment = NSTextAlignmentCenter;
        btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
        [self.publishButton addSubview:btnLabel];
    }
}
#pragma mark -- 提交活动的点击事件
-(void)pubClick:(UIButton *)sender
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"shopid":[_userdefault valueForKey:@"shopID"],@"content":self.textview.text};
    NSLog(@"%@",paramter);
    //修改进来的
    NSString *tagStr;
    if(self.isChange == YES){
        tagStr =  [TCServerSecret loginAndRegisterSecret:[NSString stringWithFormat:@"%@",@"200031"]];
    }else{
        tagStr =  [TCServerSecret loginAndRegisterSecret:[NSString stringWithFormat:@"%@",@"200029"]];
    }
    [TCAFNetworking postWithURLString:[NSString stringWithFormat:@"%@",tagStr] parameters:paramter success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        NSString *String = [NSString stringWithFormat:@"%@",dic[@"retValue"]];
        if([String intValue] > 0){
            [SVProgressHUD dismiss];
            [TCProgressHUD showMessage:@"活动提交成功，请您耐心等待，审核通过后会通知您并上线活动" duration:3.0f];
            //成功之后发送通知刷新页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"offLineShuaxin" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];

//    [TCProgressHUD showMessage:@"活动提交成功，请您耐心等待，审核通过后会通知您并上线活动审核通过后会通知您并上线活动审核通过后会通知您并上线活动" duration:2.0f];
}
#pragma mark -- 返回按钮
-(void)backBtn{
    if(self.isPush == NO){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
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
