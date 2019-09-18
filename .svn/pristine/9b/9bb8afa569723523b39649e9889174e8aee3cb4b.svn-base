//
//  TCTerminalViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTerminalViewController.h"
#import "TCLookTermInaViewController.h" //查看保证金
#import "TCRechargeTerViewController.h" //充值保证金
@interface TCTerminalViewController ()
{
    UIButton *agreenButton;
}

@end

@implementation TCTerminalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"终端机保证金";
    self.view.backgroundColor = TCBgColor;
    
    //创建View
    [self createUI];
    // Do any additional setup after loading the view.
}

//创建view
- (void)createUI
{
    //创建view
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 10, WIDHT, 90);
    headView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:headView];
    
    NSArray *arr = @[@"本店终端机状态",@"服务人员编码"];
    NSArray *disArr = @[@"正在使用",@"12113321"];
    for (int i = 0; i < arr.count; i ++) {
        UILabel *tileLabel = [UILabel publicLab:arr[i] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
        tileLabel.frame = CGRectMake(15, 45*i, WIDHT/2, 45);
        [headView addSubview:tileLabel];
        //详情
        UILabel *disLabel = [UILabel publicLab:disArr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
        disLabel.frame = CGRectMake(WIDHT/2, 45*i, WIDHT/2 - 15, 45);
        [headView addSubview:disLabel];
        if (i == 0){
            //线
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(0, 45, WIDHT, 1);
            lineView.backgroundColor = TCLineColor;
            [headView addSubview:lineView];
        }
    }
    
    agreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agreenButton.frame = CGRectMake(15, CGRectGetMaxY(headView.frame) + 10, 15, 15);
    agreenButton.layer.masksToBounds = YES;
    agreenButton.layer.cornerRadius = 4;
    agreenButton.layer.borderWidth = 1;
    agreenButton.layer.borderColor = TCUIColorFromRGB(0x979797).CGColor;
    [agreenButton setTitle:@"√" forState:UIControlStateSelected];
    [agreenButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:87 / 255.0 blue:0 / 255.0 alpha:1] forState:UIControlStateSelected];
    [agreenButton addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [agreenButton setTitle:nil forState:UIControlStateNormal];
    [self.view addSubview:agreenButton];
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(agreenButton.frame) + 5, CGRectGetMaxY(headView.frame) + 12,WIDHT/2, 12)];
    agreeLabel.text = @"同意《用户服务协议》";
    agreeLabel.font = [UIFont systemFontOfSize:12];
    agreeLabel.textColor = TCUIColorFromRGB(0x333333);
    [self.view addSubview:agreeLabel];
    
       //创建Button
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15, CGRectGetMaxY(headView.frame) + 128, WIDHT - 30, 45);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [button setTitle:@"查看保证金" forState:(UIControlStateNormal)];
    button.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}


#pragma mark -- 是否同意
- (void)agree:(UIButton *)button {
    button.selected = !button.selected;
}

#pragma mark -- 查看保证金
- (void)buttonAction:(UIButton *)sender
{
    
    /********************** 根据状态判断 查看还是充值 ****************/
//    TCLookTermInaViewController *lookTermVC = [[TCLookTermInaViewController alloc] init];
//    lookTermVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:lookTermVC animated:YES];
    TCRechargeTerViewController *lookTermVC = [[TCRechargeTerViewController alloc] init];
    lookTermVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lookTermVC animated:YES];
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
