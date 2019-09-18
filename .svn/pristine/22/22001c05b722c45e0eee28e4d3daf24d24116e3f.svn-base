//
//  TCCreateActiveController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCreateActiveController.h"

@interface TCCreateActiveController ()<UITextFieldDelegate>
{
    UILabel *placeholdLabel; //初始化一个label标签
    UITextView *avtiveTextView;
    CGFloat hightSize;
    UIView *view;//整体View
    UIView *active_content;//活动内容
    UIView *active_time;//活动时长
    UIView *active_beginTime; //开始的时间
    UIView *preferential; // 优惠
    //活动的名称
    UIView *active_name;
    UIButton *activeBtn;//活动的按钮
    NSDictionary *parmer;
}
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *backView; //背景颜色
@end

@implementation TCCreateActiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.ischange == YES){
        self.title = @"修改活动";
    }else{
        self.title = @"创建活动";
    }
    self.view.backgroundColor = ViewColor;
    _userdefault = [NSUserDefaults standardUserDefaults];
    //创建textfield
    [self createView];
    
    //添加创建活动的按钮
    activeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    activeBtn.frame = CGRectMake((WIDHT - 280*WIDHTSCALE)/2, view.frame.origin.y + view.frame.size.height + 40*HEIGHTSCALE, 280*WIDHTSCALE, 48*HEIGHTSCALE);
    if(self.ischange == YES){
        [activeBtn setTitle:@"修改活动" forState:(UIControlStateNormal)];
    }else{
    [activeBtn setTitle:@"创建活动" forState:(UIControlStateNormal)];
    }
    [activeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    activeBtn.backgroundColor = ColorLine;
    activeBtn.layer.cornerRadius = 5.0;
    activeBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    activeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    activeBtn.clipsToBounds = YES;
    [activeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    activeBtn.userInteractionEnabled = NO;
    [self.view addSubview:activeBtn];
    // Do any additional setup after loading the view.
}
//创建View
-(void)createView
{
    view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, WIDHT,260 *HEIGHTSCALE);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //活动内容
    active_content = [[UIView alloc]init];
    active_content.frame = CGRectMake(0, 12 *HEIGHTSCALE , WIDHT, 30 *HEIGHTSCALE);
    active_content.backgroundColor = [UIColor whiteColor];
    UILabel *label_content = [[UILabel alloc]init];
    label_content.frame = CGRectMake( 12 *WIDHTSCALE,  0 , 80 *WIDHTSCALE, 30*HEIGHTSCALE);
    label_content.text = @"活动名称";
    label_content.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_content.textAlignment = NSTextAlignmentRight;
    //创建
    UITextField *textField_avtive = [[UITextField alloc]init];
    textField_avtive.delegate = self;
    textField_avtive.tag = 10005;
    textField_avtive.frame = CGRectMake(label_content.frame.origin.x + label_content.frame.size.width + 12 *WIDHTSCALE, 0, WIDHT - (label_content.frame.origin.x + label_content.frame.size.width + 24 *WIDHTSCALE)  , 30*HEIGHTSCALE);
    if(self.ischange == YES){
        textField_avtive.text = [self.beginTimeStr substringToIndex:10];
    }
    //设置样式
    textField_avtive.borderStyle = UITextBorderStyleRoundedRect;
    textField_avtive.placeholder = @"如:满100减10 （限定10个字）";
    textField_avtive.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    textField_avtive.textAlignment = NSTextAlignmentLeft;
    [textField_avtive setValue:[UIFont boldSystemFontOfSize:14 *HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];
    if(self.ischange == YES){
        textField_avtive.text = self.contentStr;
    }
    [active_content addSubview:textField_avtive];
    //活动时长
    active_time = [[UIView alloc]init];
    active_time.frame = CGRectMake(0, textField_avtive.frame.origin.y + textField_avtive.frame.size.height  + 24*HEIGHTSCALE, WIDHT, 30 *HEIGHTSCALE);
    active_time.backgroundColor = [UIColor whiteColor];
    UILabel *label_time = [[UILabel alloc]init];
    label_time.frame = CGRectMake( 12 *WIDHTSCALE,0, 80 *WIDHTSCALE, 30*HEIGHTSCALE);
    label_time.text = @"开始时间";
    label_time.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_time.textAlignment = NSTextAlignmentRight;
    
    UITextField *textField_time = [[UITextField alloc]init];
    textField_time.delegate = self;
    textField_time.tag = 10001;
    textField_time.frame = CGRectMake(label_time.frame.origin.x + label_time.frame.size.width + 12 *WIDHTSCALE, 0, 120*WIDHTSCALE , 30*HEIGHTSCALE);
    if(self.ischange == YES){
        textField_time.text = [self.beginTimeStr substringToIndex:10];
    }
    //设置样式
    textField_time.borderStyle = UITextBorderStyleRoundedRect;
    textField_time.placeholder = @"如2016-01-01";
    textField_time.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    textField_time.textAlignment = NSTextAlignmentCenter;
    [textField_time setValue:[UIFont boldSystemFontOfSize:14 *HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];
    
    //开始的时间
    active_beginTime = [[UIView alloc]init];
    active_beginTime.frame = CGRectMake(0, active_time.frame.origin.y + active_time.frame.size.height + 12*HEIGHTSCALE , WIDHT, 30 *HEIGHTSCALE);
    active_beginTime.backgroundColor = [UIColor whiteColor];
    UILabel *label_beginTime = [[UILabel alloc]init];
    label_beginTime.frame = CGRectMake( 12 *WIDHTSCALE,0, 80 *WIDHTSCALE, 30*HEIGHTSCALE);
    label_beginTime.text = @"结束时间";
    label_beginTime.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_beginTime.textAlignment = NSTextAlignmentRight;
    
    UITextField *textField_beginTime = [[UITextField alloc]init];
    textField_beginTime.delegate = self;
    textField_beginTime.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    textField_beginTime.tag = 10002;
    textField_beginTime.frame = CGRectMake(label_beginTime.frame.origin.x + label_beginTime.frame.size.width + 12 *WIDHTSCALE, 0, 120*WIDHTSCALE , 30*HEIGHTSCALE);
    if(self.ischange == YES){
        textField_beginTime.text = [self.finshTimeStr substringToIndex:10];
    }
    //设置样式
    textField_beginTime.borderStyle = UITextBorderStyleRoundedRect;
    textField_beginTime.placeholder = @"如2016-01-30";
    textField_beginTime.textAlignment = NSTextAlignmentCenter;
    [textField_beginTime setValue:[UIFont boldSystemFontOfSize:14 *HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];
    
    //优惠
    preferential = [[UIView alloc]init];
    preferential.frame = CGRectMake(0, active_beginTime.frame.origin.y + active_beginTime.frame.size.height + 20*HEIGHTSCALE , WIDHT, 30 *HEIGHTSCALE);
    preferential.backgroundColor = [UIColor whiteColor];
    UILabel *label_preferential = [[UILabel alloc]init];
    label_preferential.frame = CGRectMake( 12 *WIDHTSCALE,0, 80 *WIDHTSCALE, 30*HEIGHTSCALE);
    label_preferential.text = @"满";
   
    label_preferential.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_preferential.textAlignment = NSTextAlignmentRight;
    
    UITextField *textField_preferential= [[UITextField alloc]init];
//    textField_preferential.delegate = self;
    textField_preferential.tag = 10003;
    textField_preferential.keyboardType = UIKeyboardTypeDecimalPad ;
    textField_preferential.frame = CGRectMake(label_preferential.frame.origin.x + label_preferential.frame.size.width + 12 *WIDHTSCALE, 0, 90*WIDHTSCALE , 30*HEIGHTSCALE);
    //设置样式
    if(self.ischange == YES){
        textField_preferential.text = self.manMoneyStr;
    }
    textField_preferential.borderStyle = UITextBorderStyleRoundedRect;
    textField_preferential.placeholder = @"金额";
    textField_preferential.textAlignment = NSTextAlignmentCenter;
    [textField_preferential setValue:[UIFont boldSystemFontOfSize:14 *HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];

    UILabel *label_cut = [[UILabel alloc]init];
    label_cut.text = @"减";
    label_cut.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_cut.frame = CGRectMake(textField_preferential.frame.origin.x + textField_preferential.frame.size.width + 8*WIDHTSCALE, 0, 20*WIDHTSCALE, 30*HEIGHTSCALE);
    
    UITextField *textField_cut= [[UITextField alloc]init];
//    textField_cut.delegate = self;
    textField_cut.tag = 10004;
    textField_cut.keyboardType = UIKeyboardTypeDecimalPad;
    textField_cut.frame = CGRectMake(label_cut.frame.origin.x + label_cut.frame.size.width +  8*WIDHTSCALE, 0, 90*WIDHTSCALE, 30*HEIGHTSCALE);
    //设置样式
    textField_cut.borderStyle = UITextBorderStyleRoundedRect;
    textField_cut.placeholder = @"金额";
    if(self.ischange == YES){
        textField_cut.text = self.cutMoneyStr;
    }
    textField_cut.textAlignment = NSTextAlignmentCenter;
    [textField_cut setValue:[UIFont boldSystemFontOfSize:14 *HEIGHTSCALE] forKeyPath:@"_placeholderLabel.font"];
    
    UILabel *label_money = [[UILabel alloc]init];
    label_money.text = @"元";
    label_money.font = [UIFont systemFontOfSize:15*HEIGHTSCALE];
    label_money.frame = CGRectMake(textField_cut.frame.origin.x + textField_cut.frame.size.width + 8*WIDHTSCALE, 0, 20*WIDHTSCALE, 30*HEIGHTSCALE);
    //优惠
    [preferential addSubview:label_preferential];
    [preferential addSubview:textField_preferential];
    [preferential addSubview:label_cut];
    [preferential addSubview:textField_cut];
    [preferential addSubview:label_money];
    [view addSubview:preferential];
    //开始的时间
    [active_beginTime addSubview:label_beginTime];
    [active_beginTime addSubview:textField_beginTime];
    [view addSubview:active_beginTime];
    //时长
    [active_time addSubview:label_time];
    [active_time addSubview:textField_time];
    [view addSubview:active_time];

    //名称
    [active_name addSubview:label_time];
    [active_name addSubview:label_time];
    [view addSubview:active_name];
    
    //内容
    [active_content addSubview:label_content];
   // [active_content addSubview:avtiveTextView];
    [view addSubview:active_content];
    
    
    UITextField *textFie_name = (UITextField *)[self.view viewWithTag:10000];
    UITextField *textFie_time = (UITextField *)[self.view viewWithTag:10001];
    UITextField *textFie_beginTime = (UITextField *)[self.view viewWithTag:10002];
    UITextField *textFie_preferential = (UITextField *)[self.view viewWithTag:10003];
    UITextField *textFie_cut = (UITextField *)[self.view viewWithTag:10004];
    UITextField *textFie_nameactive = (UITextField *)[self.view viewWithTag:10005];
    //创建通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textFie_name];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textFie_time];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textFie_beginTime];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textFie_preferential];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textFie_cut];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextViewTextDidChangeNotification object:textFie_nameactive];

}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UITextField *textFie_time = (UITextField *)[self.view viewWithTag:10001];
    UITextField *textFie_beginTime = (UITextField *)[self.view viewWithTag:10002];
    UITextField *textFie_preferential = (UITextField *)[self.view viewWithTag:10003];
    UITextField *textFie_cut = (UITextField *)[self.view viewWithTag:10004];
    UITextField *textFie_name = (UITextField *)[self.view viewWithTag:10005];
    [textFie_preferential resignFirstResponder];
    [textFie_cut resignFirstResponder];
    [textFie_name resignFirstResponder];
    if(textField== textFie_name){
        return YES;
    }else{
       //背景色
       _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
       _backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0  blue:178/255.0 alpha:1.0];
       _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
       UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
       window.windowLevel = UIWindowLevelNormal;
      [window addSubview:_backView];
    
      UITapGestureRecognizer * tapBackView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
      [_backView addGestureRecognizer:tapBackView];
   
    if (textField == textFie_time) {

        //创建DatePickerView
        _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:250];
        _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
        
        textFie_time.text = choseDate;
            
        };
        //设置textfield的键盘 替换为我们的自定义view
        textFie_time.inputView = _datePickerView;
        [_backView addSubview:_datePickerView];
        _datePickerView.cannelBlock = ^(){
            
            [_backView removeFromSuperview];
            
        };
        return NO;
        
    }else if (textField == textFie_beginTime){
        
        _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:250];
        _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
            
            textFie_beginTime.text = choseDate;
        };
        
        _datePickerView.cannelBlock = ^(){
            
            [_backView removeFromSuperview];
            
        };
        
        //设置textfield的键盘 替换为我们的自定义view
        textFie_beginTime.inputView = _datePickerView;
        [_backView addSubview:_datePickerView];
    }
    }
        return NO;
}
#pragma mark -- 手势
-(void)clickTap
{
    [_backView removeFromSuperview];
}
#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    UITextField *textFie_name = (UITextField *)[self.view viewWithTag:10005];
    UITextField *textFie_time = (UITextField *)[self.view viewWithTag:10001];
    UITextField *textFie_beginTime = (UITextField *)[self.view viewWithTag:10002];
    UITextField *textFie_preferential = (UITextField *)[self.view viewWithTag:10003];
    UITextField *textFie_cut = (UITextField *)[self.view viewWithTag:10004];
    if(_ischange){
        NSLog(@"修改了");
    }
    activeBtn.enabled = ( textFie_time.text.length != 0 && textFie_beginTime.text.length != 0 && textFie_preferential.text.length != 0 && textFie_cut.text.length != 0  && textFie_name.text.length != 0);
    if(activeBtn.enabled == YES){
        activeBtn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
        activeBtn.userInteractionEnabled = YES;
    }else{
        activeBtn.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0];;
    }
}

//#pragma mark -- textView的代理方法
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//     placeholdLabel.text = @"";
//    
//    return YES;
//}
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    if(avtiveTextView.text.length == 0){
//        placeholdLabel.text = @"简单介绍一下活动的内容";
//    }else{
//        placeholdLabel.text = @"";
//    }
//}

//点击空白处
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
#pragma 创建活动的点击事件
-(void)clickBtn:(UIButton *)sender
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
    UITextField *textFie_time = (UITextField *)[self.view viewWithTag:10001];
    UITextField *textFie_beginTime = (UITextField *)[self.view viewWithTag:10002];
    UITextField *textFie_preferential = (UITextField *)[self.view viewWithTag:10003];
    UITextField *textFie_cut = (UITextField *)[self.view viewWithTag:10004];
    UITextField *textFie_name = (UITextField *)[self.view viewWithTag:10005];
    if(self.ischange == YES){
        parmer = @{@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"content":textFie_name.text, @"startTime":textFie_time.text, @"endTime":textFie_beginTime.text, @"man":textFie_preferential.text, @"cut":textFie_cut.text,@"type":@"1",@"aid":self.activeId};
    }else{

        parmer = @{@"shopid":[_userdefault valueForKey:@"shopID"], @"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"content":textFie_name.text, @"startTime":textFie_time.text, @"endTime":textFie_beginTime.text, @"man":textFie_preferential.text, @"cut":textFie_cut.text,@"type":@"1"};
    }
    NSLog(@"%@",parmer);
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200018"] parameters:parmer success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@" %@",dic);
        
        NSString *String = [NSString stringWithFormat:@"%@",dic[@"retValue"]];
        if([String intValue] > 0){
             [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
             [self.navigationController popViewControllerAnimated:YES];
//            //发送通知 要求刷新页面

        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
        }
        [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
        
        NSLog(@"%@",dic[@"retMessage"]);
    } failure:^(NSError *error) {
        nil;
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *textFie_name = (UITextField *)[self.view viewWithTag:10005];
    if (range.length == 1 && string.length == 0) {
        return YES;
    }else if ([textField isEqual:textFie_name]){
        return textField.text.length < 11;
    }
    return YES;
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
