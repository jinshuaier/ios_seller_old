//
//  TCShuomingViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShuomingViewController.h"

@interface TCShuomingViewController ()

@end

@implementation TCShuomingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGgray;
    self.title = @"提现说明";

    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 100 * HEIGHTSCALE)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: view1];
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDHT - 20, 100 * HEIGHTSCALE)];
    lb1.text = @"为了您的财产安全，请您提现前仔细确认是否绑定您有效的银行卡，确认无误后方可提现。";
    lb1.numberOfLines = 0;
    lb1.font = [UIFont systemFontOfSize:15];
    lb1.textColor = [UIColor redColor];
    [view1 addSubview: lb1];

    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y + view1.frame.size.height + 10, WIDHT, 150 * HEIGHTSCALE)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: view2];
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDHT - 20, 25)];
    lb2.text = @"如何提现?";
    [view2 addSubview: lb2];
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, lb2.frame.size.height, WIDHT - 80 * WIDHTSCALE, 25)];
    lb3.text = @"第一步：首先请确定您账户是否有可提现的余额";
    lb3.font = [UIFont systemFontOfSize:13];
    [view2 addSubview: lb3];
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, lb3.frame.size.height + lb3.frame.origin.y, WIDHT - 80 * WIDHTSCALE, 25)];
    lb4.text = @"第二步：其次请确定您已经绑定的有效银行卡";
    lb4.font = [UIFont systemFontOfSize:13];
    [view2 addSubview: lb4];
    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, lb4.frame.size.height + lb4.frame.origin.y, WIDHT - 80 * WIDHTSCALE, 25)];
    lb5.text = @"第三步：转出金额";
    lb5.font = [UIFont systemFontOfSize:13];
    [view2 addSubview: lb5];
    UILabel *lb6 = [[UILabel alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, lb5.frame.size.height + lb5.frame.origin.y, WIDHT - 80 * WIDHTSCALE, 25)];
    lb6.text = @"第四步：等待金额到账";
    lb6.font = [UIFont systemFontOfSize:13];
    [view2 addSubview: lb6];
    view2.frame = CGRectMake(0, view1.frame.origin.y + view1.frame.size.height + 10, WIDHT, lb6.frame.origin.y + lb6.frame.size.height + 5);




    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y + view2.frame.size.height + 10, WIDHT, 150 * HEIGHTSCALE)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: view3];
    UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDHT - 20, 25)];
    lb7.text = @"提现到账日期";
    [view3 addSubview: lb7];
    UILabel *lb8 = [[UILabel alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, lb7.frame.size.height, WIDHT - 55 * WIDHTSCALE, 100 * HEIGHTSCALE)];
    lb8.text = @"【顺道嘉】平台提现实行工作日内24小时到账机制。（节假日除外）如遇节假日提现时间顺延。";
    lb8.numberOfLines = 0;
    lb8.font = [UIFont systemFontOfSize:13];
    [view3 addSubview: lb8];



}



























@end
