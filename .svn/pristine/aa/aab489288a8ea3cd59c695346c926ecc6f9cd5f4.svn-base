//
//  TCShopActiveController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopActiveController.h"
#import "TCFullCutViewController.h"

@interface TCShopActiveController ()<UIGestureRecognizerDelegate>

@end

@implementation TCShopActiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺活动管理";
    self.view.backgroundColor = TCBgColor;
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDHT, 55)];
    view1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:view1];
    //加入手势
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [view1 addGestureRecognizer:tapView];
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, WIDHT/2, 15)];
    textLabel.text = @"满减优惠";
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    textLabel.textColor = TCUIColorFromRGB(0x333333);
    textLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:textLabel];
    
    UIImageView *sanImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 15 - 5, 23.5, 5, 8)];
    sanImage.image = [UIImage imageNamed:@"进入小三角（灰）"];
    [view1 addSubview:sanImage];
    

}

-(void)tapView{
    NSLog(@"进入店铺活动");
    TCFullCutViewController *fullcutVC = [[TCFullCutViewController alloc]init];
    fullcutVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fullcutVC animated:YES];
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
