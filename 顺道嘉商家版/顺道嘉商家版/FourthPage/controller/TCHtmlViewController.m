//
//  TCHtmlViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/3/3.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCHtmlViewController.h"
#import "TCLoading.h"
#import "AppDelegate.h"

@interface TCHtmlViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webviews;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) TCLoading *loading;
@end

@implementation TCHtmlViewController


- (void)viewWillAppear:(BOOL)animated
{
    //记录返回按钮
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.isBack = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    //记录返回按钮
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.isBack = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家入驻协议";
    _loading  = [[TCLoading alloc]init];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    _webviews = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _webviews.delegate = self;
    [_webviews setUserInteractionEnabled:YES];//是否支持交互
    //[_webviews setOpaque:NO];//opaque是不透明的意思
    [_webviews setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:_webviews];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:_html];
    [_webviews loadRequest:[NSURLRequest requestWithURL:url]];
    [_loading Start];
    //接受返回的通知，用来控制返回按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isBack) name:@"tongzhifanhui" object:nil];
}

//通知事件
- (void)isBack
{
    if ([_webviews canGoBack]) {
        [_webviews goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
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


@end
