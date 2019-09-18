//
//  TCYijianViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCYijianViewController.h"
#define kMaxTextCount 150 //限制的25个字
@interface TCYijianViewController ()<UITextViewDelegate>
{
    UILabel *textNumberLabel;
}
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) UILabel *texteLabel;
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) NSDictionary *paramters;

@end

@implementation TCYijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    self.userdefaults = [NSUserDefaults standardUserDefaults];
    //创建视图
    [self createUI];
    // Do any additional setup after loading the view.
}

//创建视图
-(void)createUI
{
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(12, 12 + StatusBarAndNavigationBarHeight, WIDHT - 24, 190);
    backView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    [self.view addSubview:backView];
    
    self.textview = [[UITextView alloc]init];
    self.textview.frame = CGRectMake(6, 4, WIDHT - 24 - 24, 190 - 24);
    self.textview.delegate = self;
    self.textview.textColor = TCUIColorFromRGB(0x4C4C4C);
    self.textview.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.textview.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    self.textview.tintColor = TCUIColorFromRGB(0x4C4C4C);
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [backView addSubview:self.textview];
    
    //添加label
    self.texteLabel = [[UILabel alloc]init];
    self.texteLabel.frame = CGRectMake(12, 12, WIDHT - 24 - 24, 190 - 24);
    self.texteLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.texteLabel.text = @"请留下您的宝贵意见或建议，我们将努力改进（不少于五个字）";
    self.texteLabel.textColor = TCUIColorFromRGB(0x999999);
    self.texteLabel.numberOfLines = 0;
    [self.texteLabel sizeToFit];
    [backView addSubview:self.texteLabel];
    
    //添加下面计数的label
    textNumberLabel = [[UILabel alloc]init];
    textNumberLabel.frame = CGRectMake(0, 190 - 22, backView.frame.size.width - 10, 14);
    textNumberLabel.textAlignment = NSTextAlignmentRight;
    textNumberLabel.font = [UIFont systemFontOfSize:14];
    textNumberLabel.textColor = TCUIColorFromRGB(0x999999);
    textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
    [backView addSubview:textNumberLabel];
    
    self.publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.publishButton.frame = CGRectMake(12, CGRectGetMaxY(backView.frame) + 40, WIDHT - 24, 48);
    [self.publishButton setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.publishButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.publishButton.userInteractionEnabled = NO;
    self.publishButton.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
    self.publishButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    [self.publishButton addTarget:self action:@selector(publishButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.publishButton];
}
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}
//判断开始输入
-(void)textViewDidChange:(UITextView *)textView
{
    self.publishButton.enabled = (textView.text.length > 4);
    if(self.publishButton.enabled == YES){
        self.publishButton.userInteractionEnabled = YES;
        self.publishButton.backgroundColor = TCUIColorFromRGB(0x53C3C3);
        
    }else{
        self.publishButton.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
        self.publishButton.userInteractionEnabled = NO;
    }
    
    
    if(textView.text.length > 0){
        self.texteLabel.hidden = YES;
    }else{
        self.texteLabel.hidden = NO;
    }
    textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)textView.text.length,kMaxTextCount];
    if(textView.text.length >= kMaxTextCount){
        //截取字符串
        textView.text = [textView.text substringToIndex:150];
        textNumberLabel.text = @"150/150";
    }else{
        
    }
}



#pragma mark -- 点击事件
- (void)publishButton:(UIButton *)sender
{
    if (self.textview.text.length == 0){
        [TCProgressHUD showMessage:@"您还没有输入内容"];
    } else {
        NSLog(@"提交");
        //请求接口
        [self createQuest];
    }
}

#pragma mark -- 请求接口
- (void)createQuest
{
    //请求接口
    NSString *timeStr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userdefaults valueForKey:@"userToken"]];
    NSDictionary *dic = @{@"mid":midStr,@"timestamp":timeStr,@"content":self.textview.text,@"token":tokenStr};
    NSString *signStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"mid":midStr,@"timestamp":timeStr,@"content":self.textview.text,@"token":tokenStr,@"sign":signStr};
    NSLog(@"%@ %@",dic,self.paramters);
   
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201036"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSLog(@"%@,%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]){
            [self.navigationController popViewControllerAnimated:YES];
        }
        [TCProgressHUD showMessage:jsonDic[@"msg"]];
        //成功后返回更新
    } failure:^(NSError *error) {
        nil;
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        //结束编辑时整个试图返回原位
        [UIView beginAnimations:@"down" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame = self.view.bounds;
        [UIView commitAnimations];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textview resignFirstResponder];
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
