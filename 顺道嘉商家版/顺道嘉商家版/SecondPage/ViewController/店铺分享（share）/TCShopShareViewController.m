//
//  TCShopShareViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopShareViewController.h"
#import "TCLoading.h"
@interface TCShopShareViewController ()<UIScrollViewDelegate,UIWebViewDelegate,UIActionSheetDelegate>
{
    UIButton *lastButton;
    UIView *lineView;
    UIView *headView;
    UIImageView *imageView;
    NSURL *urlStr;
    NSURL *urlImageStr; //图片的url
    UIView *mainView;
}

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UIWebView *webviews;
@property (nonatomic, strong) TCLoading *loading;



@end

@implementation TCShopShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"店铺分享";
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, WIDHT, 54);
    headView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:headView];
    
    NSArray *titleArr = @[@"推荐普通会员",@"推荐商家会员"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WIDHT / titleArr.count * i, 0, WIDHT / titleArr.count, 54);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [btn setTitleColor:TCUIColorFromRGB(0X666666) forState:UIControlStateNormal];
        [btn setTitleColor:TCUIColorFromRGB(0x333333) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeSelect:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [headView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            lastButton = btn;
        }
    }
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake((WIDHT/2 - 20)/2, 54 - 4, 20, 4)];
    lineView.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    lineView.tag = 2000;
    [headView addSubview:lineView];
    
    //请求接口
    [self shopShare];

    // Do any additional setup after loading the view.
}


#pragma mark -- 请求接口
- (void)shopShare
{
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[self.userDefaults valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[self.userDefaults valueForKey:@"userToken"]];
    
    
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dicc];
    NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
    
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201004"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        
        self.dic = jsonDic[@"data"];
        urlStr = [NSURL URLWithString:self.dic[@"user_url"]];
        [self createUI];
        
          } failure:^(NSError *error) {
        nil;
    }];
}


#pragma mark -- 创建View
- (void)createUI
{
    //webView
    
    _webviews = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), WIDHT, HEIGHT - (CGRectGetMaxY(headView.frame) + 64))];
    _webviews.delegate = self;
    [_webviews setUserInteractionEnabled:YES];//是否支持交互
    //[_webviews setOpaque:NO];//opaque是不透明的意思
    [_webviews setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:_webviews];
    _webviews.backgroundColor = [UIColor clearColor];
    _webviews.opaque = NO;
    
    // 添加额外的滚动附近区域的内容
    _webviews.scrollView.contentInset = UIEdgeInsetsMake(426, 0, 0, 0);
    
    // 在webView上添加一个imgView 在 imgView上添加一个label
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, WIDHT - 24, 426);
    view.backgroundColor = TCBgColor;
    view.frame = CGRectMake(0, -426, _webviews.frame.size.width, 426);
    [_webviews.scrollView addSubview:view];
    
    //UIVIEW
    mainView = [[UIView alloc] init];
    mainView.backgroundColor = TCUIColorFromRGB(0xF99E20);
    mainView.frame = CGRectMake(12, 12, WIDHT - 24, 426 - 12);
    
    //初始化一个长按手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    
    //长按等待时间
    longPressGest.minimumPressDuration = 1;
    
    //长按时候,手指头可以移动的距离
    longPressGest.allowableMovement = 20;
    [mainView addGestureRecognizer:longPressGest];
    
    [view addSubview:mainView];
    
    
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(24, 24, WIDHT - 24 - 48, 288);
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"user"]] placeholderImage:nil];
    urlImageStr = [NSURL URLWithString:self.dic[@"user"]];
    [mainView addSubview:imageView];
    
    //图片
    UIImageView *imagechang = [[UIImageView alloc] init];
    imagechang.image = [UIImage imageNamed:@"长按"];
    imagechang.frame = CGRectMake((WIDHT - 24 - 48)/2, CGRectGetMaxY(imageView.frame) + 16, 48, 48);
    [mainView addSubview:imagechang];
    
    //文字
    UILabel *changLabel = [UILabel publicLab:@"长按二维码分享!" textColor:TCUIColorFromRGB(0xFFFFFF) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    changLabel.frame = CGRectMake(0, CGRectGetMaxY(imagechang.frame) + 8, WIDHT - 24, 18);
    [mainView addSubview:changLabel];

    
    //加载网页的方式
    //1.创建并加载远程网页
   
//    [_webviews loadHTMLString:self.dic[@"user_url"] baseURL:nil];
    
    
    _loading  = [[TCLoading alloc]init];
           //1.创建并加载远程网页
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlStr];
        [_webviews loadRequest: request];
    
        [_loading Start];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_loading Start];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_loading Stop];
    [self.view addSubview: _webviews];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_loading Stop];
}
    

- (void)typeSelect:(UIButton *)button {
    lastButton.selected = NO;
    button.selected = YES;
    lastButton = button;
    
    CGRect frame = lineView.frame;
    switch (button.tag) {
        case 1000: {
            frame.origin.x = (WIDHT/2 - 20)/2;
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"user"]] placeholderImage:nil];
            urlImageStr = [NSURL URLWithString:self.dic[@"user"]];

            urlStr = [NSURL URLWithString:self.dic[@"user_url"]];

            mainView.backgroundColor = TCUIColorFromRGB(0xF99E20);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlStr];
            [_webviews loadRequest: request];
            
            [_loading Start];

        }
            break;
        case 1001: {
            frame.origin.x = (WIDHT/2 - 20)/2 + WIDHT/2;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"seller"]] placeholderImage:nil];
            urlImageStr = [NSURL URLWithString:self.dic[@"seller"]];

            urlStr = [NSURL URLWithString:self.dic[@"seller_url"]];

            mainView.backgroundColor = TCUIColorFromRGB(0x53C3C3);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlStr];
            [_webviews loadRequest: request];
            
            [_loading Start];
            
        }
            break;
        default:
            break;
    }
     lineView.frame = frame;
}

#pragma mark -- 长按手势
-(void)longPressView:(UILongPressGestureRecognizer *)sender{
    NSLog(@"长按手势识别到了");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 添加 AlertAction 事件回调（三种类型：默认，取消，警告）
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok");
        [SVProgressHUD showWithStatus:@"保存中..."];
        //保存图片
        [self saveImageToPhotos:[UIImage imageWithData:[NSData dataWithContentsOfURL:urlImageStr]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
//    UIAlertAction *errorAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"error");
////        //弹出分享框
////        [self createShareView];
//    }];
    
    // cancel类自动变成最后一个，警告类推荐放上面
//    [alertController addAction:errorAction];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    // 出现
    [self presentViewController:alertController animated:YES completion:^{
        NSLog(@"presented");
    }];
    
}

//保存
- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if(error != NULL){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
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
