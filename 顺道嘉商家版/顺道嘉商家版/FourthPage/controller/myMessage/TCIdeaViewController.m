//
//  TCIdeaViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCIdeaViewController.h"

@interface TCIdeaViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@end

@implementation TCIdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = backGgray;
     _userdefaults = [NSUserDefaults standardUserDefaults];
    //创建view
    [self createView];
    // Do any additional setup after loading the view.
}
//创建view
-(void)createView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0,0,WIDHT, (20 + 40 + 20 + 140 + 32)*HEIGHTSCALE);
    [self.view addSubview:view];
    
    //创建label
    UILabel *proLabel = [[UILabel alloc]init];
    proLabel.frame = CGRectMake(12*WIDHTSCALE, 20*HEIGHTSCALE, WIDHT - 24*WIDHTSCALE, 40*HEIGHTSCALE);
    proLabel.text = @"为了更便捷于对您服务，请输入您宝贵的建议和意见，我们将不断进行改进。";
    proLabel.numberOfLines = 0;
    proLabel.textColor = SmallTitleColor;
    proLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    [view addSubview:proLabel];
    
    //创建textView
    self.contentView = [[UITextView alloc]init];
    self.contentView.frame = CGRectMake(12*WIDHTSCALE, 80*HEIGHTSCALE, WIDHT - 24*WIDHTSCALE, 140*HEIGHTSCALE);
    self.contentView.delegate = self;
    self.contentView.textAlignment = NSTextAlignmentLeft;
    self.contentView.textColor = [UIColor blackColor];
    self.contentView.font = [UIFont systemFontOfSize:15.0f*HEIGHTSCALE];
    self.contentView.editable = YES;
    self.contentView.scrollEnabled = YES;
    self.contentView.backgroundColor = [UIColor colorWithRed:232/255.0 green:236/255.0 blue:237/255.0 alpha:1.0];
    
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.borderWidth = 2;
    self.contentView.text = self.contentStr;
    self.contentView.layer.borderColor = ViewColor.CGColor;
    
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(12*WIDHTSCALE, 25/2*HEIGHTSCALE, CGRectGetWidth(self.contentView.frame) - 24*WIDHTSCALE, 14*HEIGHTSCALE)];
    _placeholderLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];

    _placeholderLabel.text = @"请输入您的宝贵建议 (300字以内)";

    _placeholderLabel.font = self.contentView.font;
    [self.contentView addSubview:_placeholderLabel];
    //创建通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //注册通知
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextViewTextDidChangeNotification object:self.contentView];

    [view addSubview:self.contentView];
    
    //创建下面的确认提交按钮
    UIButton *trueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    trueBtn.frame = CGRectMake((WIDHT - 240*WIDHTSCALE)/2, view.frame.size.height + view.frame.origin.y + 40*HEIGHTSCALE, 240*WIDHTSCALE, 48*HEIGHTSCALE);
    trueBtn.backgroundColor = ColorLine;
    trueBtn.tag = 10000;
    trueBtn.userInteractionEnabled = NO;
    [trueBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [trueBtn setTitle:@"确认提交" forState:(UIControlStateNormal)];
    trueBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    trueBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [trueBtn addTarget:self action:@selector(trueBtn) forControlEvents:(UIControlEventTouchUpInside)];
    trueBtn.layer.cornerRadius = 4;
    trueBtn.clipsToBounds = YES;
    [self.view addSubview:trueBtn];
}
#pragma mark -- 提交按钮的点击事件
-(void)trueBtn
{
    //[self.contentView resignFirstResponder];
    if(self.contentStr.length < 5){
        //创建灰色背景
        [self createBackView];
    }else{
        //请求接口
        [self createQuest];
    }
}
#pragma mark -- 提交的接口
-(void)createQuest
{
    NSDictionary *dic = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"content":self.contentStr};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"200016"] paramter:dic success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (!([[jsonDic valueForKey:@"retValue"]integerValue] == 5)) {
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
         NSLog(@" 错误 %@", error);
    }];
}


//背景颜色
-(void)createBackView{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:_backView];
    //自定义的弹窗
    UIView *shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake((WIDHT - 596*WIDHTSCALE/2)/2, (_backView.frame.size.height - 140 *HEIGHTSCALE)/2, 596/2*WIDHTSCALE, 140*HEIGHTSCALE);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 5;
    shoperView.layer.borderWidth = 0.1;
    [_backView addSubview:shoperView];
    
    //描述文字
    UILabel *disLabel = [[UILabel alloc]init];
    disLabel.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    disLabel.textColor = FontColor;
    disLabel.frame = CGRectMake(0, 0, 596/2*WIDHTSCALE, 140*HEIGHTSCALE);
    disLabel.text = @"反馈内容最少五个字，再多给点建议吧！";
    disLabel.textAlignment = NSTextAlignmentCenter;
    [shoperView addSubview:disLabel];
    
    //创建❌号
    UIButton *deleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    deleBtn.frame = CGRectMake(WIDHT - 32*WIDHTSCALE - 28*WIDHTSCALE, (_backView.frame.size.height - 140 *HEIGHTSCALE)/2 - 12*HEIGHTSCALE - 28*WIDHTSCALE, 28*WIDHTSCALE, 28*WIDHTSCALE);
    [deleBtn setBackgroundImage:[UIImage imageNamed:@"叉号"] forState:(UIControlStateNormal)];
    [deleBtn addTarget:self action:@selector(deleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:deleBtn];
}
#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    btn.enabled = (self.contentView.text.length != 0 );
    if(btn.enabled == YES){
        btn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
        btn.userInteractionEnabled = YES;
    }else{
        btn.backgroundColor = ColorLine;
    }
}
#pragma mark -- 点击空白处，键盘下滑
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView resignFirstResponder];
}
#pragma mark -- 点击删除的按钮
-(void)deleBtn
{
    [_backView removeFromSuperview];
}
//开始编辑
-(void)textViewDidBeginEditing:(UITextView *)textView{
    _placeholderLabel.text = @"";
}
//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(self.contentView.text.length == 0){
        _placeholderLabel.text = @"请输入您的宝贵建议 (300字以内)";
    }else{
        _placeholderLabel.text = @"";
        self.contentStr = textView.text;
    }
}
//如果输入超过规定的字数300，就不再让输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
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
    } else {
        if (range.location >= 300)
        {
            return  NO;
        }
        else
        {
            return YES;
        }
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
