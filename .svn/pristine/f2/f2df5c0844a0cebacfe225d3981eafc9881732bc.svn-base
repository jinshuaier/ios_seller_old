//
//  TCAddAssistantController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddAssistantController.h"

@interface TCAddAssistantController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSString *index; //是否启用
@property (nonatomic, strong) UIView *backView; //背景颜色
@property (nonatomic, strong) NSMutableArray *shopArr; // 此数组用来保存下面返回商铺的数组

@property (nonatomic, strong) UIView *shoperView;

@property (nonatomic, strong) UIButton * starButton;

@property (nonatomic, strong) UISegmentedControl *startSeg;
@property (nonatomic, strong) NSDictionary *paramter;
@end

@implementation TCAddAssistantController
-(void)loadView{
    [super loadView];
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:(UIOffsetMake(0, -60)) forBarMetrics:(UIBarMetricsDefault)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //去除边框影响
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if(_isChange == YES){
        self.title = @"修改店员";
        
    }else{
        self.title = @"添加店员";
    }
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = ViewColor;
    
    _shopArr = [[NSMutableArray alloc]init];
    //创建textfield
    [self createTextfield];
    
}
#pragma mark -- 创建店员的textfield
-(void)createTextfield
{
    UIView *view = [[UIView alloc]init];
    view.tag = 100;
    //    view.frame = CGRectMake(0, 64, WIDHT, 400);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSArray *informationArr = @[@"添加店员姓名",@"店员手机号",@"设置店员登录密码",@"选择店员角色",@"选择店员所在店铺"];
    for (int i = 0; i < informationArr.count; i++) {
        UITextField *textField = [[UITextField alloc]init];
        textField.frame = CGRectMake(0, 36 + 44*i, WIDHT, 20);
        textField.delegate = self;
        textField.tag = 1000 + i;
        [textField addTarget:self action:@selector(chang:) forControlEvents:UIControlEventEditingDidEnd];
        textField.placeholder = informationArr[i];
        [textField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [view addSubview:textField];
        //把输入的文本居中显示
        textField.textAlignment = NSTextAlignmentCenter;
        UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
        UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
        UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
        UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
        UITextField *textField_shopName = (UITextField *)[self.view viewWithTag:1004];
        if([[_userdefault valueForKey:@"userRole"] isEqualToString:@"店长"]){
            textField_role.textColor = ColorLine;
            textField_shopName.textColor = ColorLine;
            textField_role.userInteractionEnabled = NO;
            textField_shopName.userInteractionEnabled = NO;
            
            textField_role.text = @"员工";
            textField_shopName.text = self.shopName;
        }
        
        if(_isChange == YES){
            textField_name.text = self.name;
            textField_phone.text = self.phoneNum;
            textField_pass.text = @"";
            textField_role.text = self.role;
            textField_shopName.text = self.shopName;
            
        }
        
        //创建通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_name];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_phone];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_pass];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_role];
        [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:textField_shopName];
        
        //画线
        UILabel *labelLine = [[UILabel alloc]init];
        labelLine.tag = 100 + i;
        labelLine.frame = CGRectMake((WIDHT - 240 *WIDHTSCALE)/2,textField_name.frame.origin.y + textField_name.frame.size.height  + 2 + 44*i  , 240 *WIDHTSCALE, 0.5);
        labelLine.backgroundColor = [UIColor colorWithRed:102.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
        [view addSubview:labelLine];
        
    }
    
    UILabel *line = (UILabel *)[self.view viewWithTag:104];
    //添加是否启用的文字
    UILabel *label = [[UILabel alloc]init];
    label.text = @"是否启用？";
    label.font = [UIFont systemFontOfSize:15 *HEIGHTSCALE];
    label.textColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1.0];
    label.frame = CGRectMake(0, line.frame.origin.y + line.frame.size.height + 20 *HEIGHTSCALE, WIDHT, 20*HEIGHTSCALE);
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    //是否启用店员
    NSArray *arr = @[@"启用", @"不启用"];
    _startSeg = [[UISegmentedControl alloc]initWithItems:arr];
    _startSeg.frame = CGRectMake((WIDHT - 120 *WIDHTSCALE)/2, label.frame.origin.y + label.frame.size.height + 20 *HEIGHTSCALE, 120 * WIDHTSCALE , 30 *HEIGHTSCALE);
    [_startSeg setTintColor:Color];
    //设置监听事件
    [_startSeg addTarget:self action:@selector(startseg:) forControlEvents:UIControlEventValueChanged];
    //修改字体
    UIFont *font = [UIFont boldSystemFontOfSize:14.0f  *HEIGHTSCALE];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [_startSeg setTitleTextAttributes:attributes
                             forState:UIControlStateNormal];
    
    if(_isChange == YES){
        if([self.endle isEqualToString:@"1"]){
            _startSeg.selectedSegmentIndex = 0;
            
        }else{
            _startSeg.selectedSegmentIndex = 1;
        }
    }else{
        _startSeg.selectedSegmentIndex = 0;
        self.index = @"1";
    }
    view.frame = CGRectMake(0, 0, WIDHT,_startSeg.frame.origin.y + _startSeg.frame.size.height + 36 *HEIGHTSCALE);
    [view addSubview:_startSeg];
    
    
    //创建添加店员的按钮
    UIButton *addAssistantBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addAssistantBtn.frame = CGRectMake( (WIDHT - 280*WIDHTSCALE)/2,HEIGHT -( 48 *HEIGHTSCALE + 80 *HEIGHTSCALE), 280 *WIDHTSCALE, 48 *HEIGHTSCALE);
    addAssistantBtn.tag = 10000;
    if(_isChange == YES){
        [addAssistantBtn setTitle:@"修改店员" forState:(UIControlStateNormal)];
    }else{
        [addAssistantBtn setTitle:@"添加店员" forState:(UIControlStateNormal)];
    }
    
    [addAssistantBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    addAssistantBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    addAssistantBtn.layer.cornerRadius = 5;
    addAssistantBtn.clipsToBounds = YES;
    addAssistantBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addAssistantBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    if(_isChange == YES){
        addAssistantBtn.userInteractionEnabled = YES;
        addAssistantBtn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }else{
        addAssistantBtn.userInteractionEnabled = NO;
    }
    addAssistantBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHTSCALE];
    [self.view addSubview:addAssistantBtn];
    
}
#pragma mark -- textfield的代理方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
    UITextField *textField_shopName = (UITextField *)[self.view viewWithTag:1004];
    
    
    //选择店员
    if(textField == textField_role){
        //背景色
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
        _backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
        _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
        window.windowLevel = UIWindowLevelNormal;
        [window addSubview:_backView];
        //自定义的弹窗
        UIView *shoperView = [[UIView alloc]init];
        shoperView.frame = CGRectMake((WIDHT - 260*WIDHTSCALE)/2, (_backView.frame.size.height - 120 *HEIGHTSCALE)/2, 260*WIDHTSCALE, 120*HEIGHTSCALE);
        shoperView.backgroundColor = [UIColor whiteColor];
        shoperView.layer.cornerRadius = 5;
        shoperView.layer.borderWidth = 0.1;
        [_backView addSubview:shoperView];
        
        //创建2个button店长和店员
        NSArray *shoperArr = @[@"店长",@"员工"];
        //店长 \ 店员
        
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(0, (120 - 84)/2*HEIGHTSCALE + (30 + 24)*HEIGHTSCALE *i , shoperView.frame.size.width, 30*HEIGHTSCALE);
            [btn setTitle:shoperArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0 / 255.0 green:136 / 255.0 blue:204 / 255.0 alpha:1] forState:UIControlStateSelected];
            [btn setTintColor:[UIColor whiteColor]];
            btn.tag = 1001 + i;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            //            if(i == 0){
            //                btn.selected = NO;
            //                self.starButton = btn;
            //            }
            
            [shoperView addSubview:btn];
            
            
            //画一条线
            if(i == 0){
                UIView *lineView = [[UIView alloc]init];
                lineView.frame = CGRectMake((shoperView.frame.size.width - 200 *WIDHTSCALE)/2, btn.frame.origin.y + btn.frame.size.height + 12*HEIGHTSCALE, 200 *WIDHTSCALE, 1);
                lineView.backgroundColor = ColorLine;
                [shoperView addSubview:lineView];
            }
        }
        [textField_name resignFirstResponder];
        [textField_phone resignFirstResponder];
        [textField_pass resignFirstResponder];
        return NO;
    }
    //选择员工所在店铺
    if(textField == textField_shopName){
        //背景色
        //进行网络请求
        [self createShopQuest];
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
        _backView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
        _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
        window.windowLevel = UIWindowLevelNormal;
        [window addSubview:_backView];
        
        
        //自定义的弹窗
        _shoperView = [[UIView alloc]init];
        _shoperView.frame = CGRectMake(12 *WIDHTSCALE, (_backView.frame.size.height - 410 *HEIGHTSCALE /2)/2, WIDHT - 24*WIDHTSCALE, 410/2*HEIGHTSCALE);
        _shoperView.backgroundColor = [UIColor whiteColor];
        _shoperView.layer.cornerRadius = 5;
        _shoperView.layer.borderWidth = 0.1;
        [_backView addSubview:_shoperView];
        
        
        [textField_name resignFirstResponder];
        [textField_phone resignFirstResponder];
        [textField_pass resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shopArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _shopArr[indexPath.row][@"name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35 *HEIGHTSCALE;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITextField *textField_shopName = (UITextField *)[self.view viewWithTag:1004];
    textField_shopName.text = _shopArr[indexPath.row][@"name"];
    _shopID = _shopArr[indexPath.row][@"id"];
    [_backView removeFromSuperview];
}

#pragma mark -- 监听文本框的值的改变
- (void)textValueChanged:(NSNotification *)notice
{
    
    UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
//    UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
//    UITextField *textField_shopName = (UITextField *)[self.view viewWithTag:1004];
    if (textField_phone) {
        if (textField_phone.text.length > 11) {
            textField_phone.text = [textField_phone.text substringToIndex:11];
        }
    }

    
    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    if(_isChange == YES){
        btn.enabled = YES;
        btn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        btn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
        btn.userInteractionEnabled = YES;
    }else{
    
    btn.enabled = (textField_name.text.length != 0 && textField_phone.text.length != 0 && textField_pass.text.length != 0  );
    if(btn.enabled == YES){
        btn.backgroundColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
        btn.userInteractionEnabled = YES;
    }else{
        btn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    }
}
#pragma mark -- 分段选择器
-(void)startseg:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if(index == 0){
        self.index = @"1";
    }else{
        self.index = @"-1";
    }
    
    NSLog(@"%@",self.index);
}
#pragma mark -- 添加店员的点击事件
-(void)click:(UIButton *)sender
{
//    if(_isChange == YES){
//        //请求修改店员的接口
//        [self reviseQuest];
//        
//    }else{
//        
        //请求添加店员的接口
        [self createAddQuest];
   // }
}
#pragma mark -- 选择店员角色的按钮
- (void)btnClicked:(UIButton *)button {
    
    [_backView removeFromSuperview];
    if(button!=self.starButton){
        
        self.starButton.selected=NO;
        
        self.starButton=button;
    }
    self.starButton.selected=YES;
    
    if (button.tag == 1001) {
        UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
        textField_role.text = button.titleLabel.text;
        
    } else if (button.tag == 1002) {
        UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
        textField_role.text = button.titleLabel.text;
   // }
    }
}

//只能输入数字
#define NUMBERS @"0123456789\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    NSCharacterSet *cs;
    if(textField == textField_phone)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}

#pragma mark -- 修改店员的请求接口
-(void)createAddQuest{
    UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
    if(textField_phone.text.length < 11){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号"
                                                       delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        //判断选择器的状态
        if (self.startSeg.selectedSegmentIndex == 0) {
            self.index = @"1";
        }else{
            self.index = @"-1";
        }
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        if(_isChange == YES ){
            if( [[_userdefault valueForKey:@"userRole"] isEqualToString:@"商家"]){
                
                _paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"uid":self.idStr, @"mobile":textField_phone.text,@"name":textField_name.text,@"password":textField_pass.text,@"role":textField_role.text,@"shopid":self.shopID,@"enabled":self.index};
                NSLog(@"%@",_paramter);
            }else{
                if(_shopArr.count == 0){
                    _shopID = @"0";
                }
                
                _paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"uid":self.idStr, @"mobile":textField_phone.text,@"name":textField_name.text,@"password":textField_pass.text,@"role":textField_role.text,@"shopid":_shopID,@"enabled":self.index};
                NSLog(@"%@",_paramter);
            }
            
            [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100112"] parameters:_paramter success:^(id responseObject) {
                NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"添加成员返回信息%@", str);
                
                [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                [self.navigationController popViewControllerAnimated:YES];
                //发送通知 要求刷新页面
                [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
            } failure:^(NSError *error) {
                
            }];
            
        }else{
            if(_shopArr.count == 0){
                _shopID = @"0";
            }
            
            NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"], @"mobile":textField_phone.text,@"name":textField_name.text,@"password":textField_pass.text,@"role":textField_role.text,@"shopid":_shopID,@"enabled":self.index};
            NSLog(@"%@",paramter);
            
            [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100112"] parameters:paramter success:^(id responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@" %@",dic);
                
                [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                [self.navigationController popViewControllerAnimated:YES];
                //发送通知 要求刷新页面
                [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
            } failure:^(NSError *error) {
                
            }];
        }
    }
}
#pragma mark -- 点击店铺选择请求接口
-(void)createShopQuest
{
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"200013"] parameters:@{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"]} success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" %@",dic);
        if(dic){
            _shopArr = dic[@"data"];
            
        }
        //创建所在商铺的tableView
        UITableView *shopTable = [[UITableView alloc]init];
        shopTable = [[UITableView alloc] initWithFrame:CGRectMake(1, 12*HEIGHTSCALE, WIDHT - 24*WIDHTSCALE - 1,410/2*HEIGHTSCALE - 24*HEIGHTSCALE) style:UITableViewStylePlain];
        shopTable.dataSource = self;
        shopTable.delegate = self;
        shopTable.scrollEnabled = YES;
        shopTable.tableFooterView = [[UIView alloc]init];
        [_shoperView addSubview:shopTable];
        
        //        [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
        
    } failure:^(NSError *error) {
        
    }];
    
}
//#pragma mark -- 添加店员的接口
//-(void)createAddQuest
//{
//    UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
//    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
//    UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
//    UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
//    if(textField_phone.text.length < 11){
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号"
//                                                       delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        
//    }else{
//
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD showWithStatus:@"加载中..."];
//    
//    if([[_userdefault valueForKey:@"userRole"] isEqualToString:@"店长"]){
//         _shopID = @"0";
//        NSDictionary *paramter = @{@"id":@"97", @"token":[_userdefault valueForKey:@"userToken"],@"mobile":textField_phone.text,@"name":textField_name.text,@"password":textField_pass.text,@"role":textField_role.text,@"shopid":_shopID,@"enabled":self.index};
//        NSLog(@"%@",paramter);
//    }else{
//    if(_shopArr.count == 0){
//        _shopID = @"0";
//    }
//    }
//    NSDictionary *paramter = @{@"id":[_userdefault valueForKey:@"userID"], @"token":[_userdefault valueForKey:@"userToken"],@"mobile":textField_phone.text,@"name":textField_name.text,@"password":textField_pass.text,@"role":textField_role.text,@"shopid":_shopID,@"enabled":self.index};
//    NSLog(@"%@",paramter);
//    
//    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"100112"] parameters:paramter success:^(id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" %@",dic);
//        
//        [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
//        [self.navigationController popViewControllerAnimated:YES];
//        //发送通知 要求刷新页面
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
//    } failure:^(NSError *error) {
//        
//    }];
//    
//}
//}

-(void)chang:(UITextField *)sender
{
    [sender resignFirstResponder];
}
#pragma mark -- 点击空白 下滑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITextField *textField_name = (UITextField *)[self.view viewWithTag:1000];
    UITextField *textField_phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField_pass = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textField_role = (UITextField *)[self.view viewWithTag:1003];
    UITextField *textField_shopName = (UITextField *)[self.view viewWithTag:1004];
    
    
    [textField_name resignFirstResponder];
    [textField_phone resignFirstResponder];
    [textField_pass resignFirstResponder];
    [textField_role resignFirstResponder];
    [textField_shopName resignFirstResponder];
}


-(void)dismissContactView
{
    
    [_backView removeFromSuperview];
    
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
