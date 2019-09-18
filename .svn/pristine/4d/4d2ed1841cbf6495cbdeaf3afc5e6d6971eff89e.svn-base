//
//  TCAboutSDJViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/11.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAboutSDJViewController.h"

@interface TCAboutSDJViewController ()

@end

@implementation TCAboutSDJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCBgColor;
    self.title = @"关于顺道嘉";
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"关于我们-顺道嘉图标"];
    image.frame = CGRectMake((WIDHT - 64)/2, 72, 64, 64);
    [self.view addSubview:image];
    
    //获取版本号
    //获得当前版本
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *label = [UILabel publicLab:[NSString stringWithFormat:@"顺道嘉商家版 V%@",currentVersion] textColor:TCUIColorFromRGB(0x999999) textAlignment:NSTextAlignmentCenter fontWithName:@"PingFangSC-Regular" size:16 numberOfLines:0];
    label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 17, WIDHT, 22);
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
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
