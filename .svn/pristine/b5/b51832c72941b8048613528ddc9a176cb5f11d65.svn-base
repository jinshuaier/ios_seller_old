//
//  TCApplyViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCApplyViewController.h"
#import "TCShopViewController.h"
#import "TCTabBarViewController.h"

@interface TCApplyViewController ()
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSUserDefaults *userdefault;

@end

@implementation TCApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请完成";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.mobile = [_userdefault valueForKey:@"userMobile"];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self creatUI];
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 164)];
    view1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:view1];
    
    UIImageView *gouImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 48)/2, 30, 48, 48)];
    gouImage.image = [UIImage imageNamed:@"提交成功"];
    gouImage.layer.masksToBounds = YES;
    gouImage.layer.cornerRadius = 24;
    [view1 addSubview:gouImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(gouImage.frame) + 20, WIDHT - 30, 20)];
    label.text = @"恭喜，申请已完成";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    label.textColor = TCUIColorFromRGB(0x999999);
    label.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label];
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) + 10, WIDHT - 30, 16)];
    grayLabel.text = @"审核通过后即可上线";
    grayLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    grayLabel.textColor = TCUIColorFromRGB(0x999999);
    grayLabel.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:grayLabel];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame) + 10, WIDHT, 252)];
    view2.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:view2];
    
    UIImageView *tijiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 230)/2, 20, 60, 60)];
    tijiaoImage.image = [UIImage imageNamed:@"提交店铺信息图标"];
    tijiaoImage.layer.masksToBounds = YES;
    tijiaoImage.layer.cornerRadius = 30;
    [view2 addSubview:tijiaoImage];
    
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tijiaoImage.frame) + 110, 20, 60, 60)];
    lineImage.image = [UIImage imageNamed:@"审核上线图标"];
    lineImage.layer.masksToBounds = YES;
    lineImage.layer.cornerRadius = 30;
    [view2 addSubview:lineImage];
    
    UILabel *tijiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
    tijiaoLabel.center = CGPointMake((WIDHT - 230)/2 + 30, CGRectGetMaxY(tijiaoImage.frame) + 20);
    tijiaoLabel.text = @"提交店铺信息";
    tijiaoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tijiaoLabel.textColor = TCUIColorFromRGB(0x666666);
    tijiaoLabel.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:tijiaoLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    lineLabel.center = CGPointMake(lineImage.center.x, CGRectGetMaxY(lineImage.frame) + 20);
    lineLabel.text = @"审核上线";
    lineLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    lineLabel.textColor = TCUIColorFromRGB(0x666666);
    lineLabel.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:lineLabel];
    
    NSString *str = [self.mobile substringWithRange:NSMakeRange(0, 3)];
    NSString *str1 = [self.mobile substringWithRange:NSMakeRange(7, 4)];
    NSString *str2 = [[str stringByAppendingString:@"****"] stringByAppendingString:str1];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineLabel.frame) + 30, WIDHT - 30, 72)];
    textLabel.text = [NSString stringWithFormat:@"审核过程中业务员会联系您%@手机号，请注意接听来自北京010开头的电话，审核通过后您可以进行上线营业，您可以先上传您的商品体验一下您的商铺",str2];
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    textLabel.textColor = TCUIColorFromRGB(0x666666);
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [textLabel sizeThatFits:CGSizeMake(WIDHT - 30, MAXFLOAT)];//根据文字的长度返回一个最佳宽度和高度
    textLabel.frame = CGRectMake(15, CGRectGetMaxY(lineLabel.frame) + 30, WIDHT - 30, size.height);
    [view2 addSubview:textLabel];
    
    UIButton *wancBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT - 48 - 64, WIDHT/2, 48)];
    wancBtn.layer.borderColor = TCUIColorFromRGB(0x53C3C3).CGColor;
    wancBtn.layer.borderWidth = 1;
    [wancBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [wancBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:(UIControlStateNormal)];
    [wancBtn setBackgroundColor:TCUIColorFromRGB(0xFFFFFF)];
    [wancBtn addTarget:self action:@selector(clickwan:) forControlEvents:(UIControlEventTouchUpInside)];
    wancBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    wancBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [self.view addSubview:wancBtn];
    
    UIButton *goshopBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT/2, HEIGHT - 48 - 64,WIDHT/2, 48)];
    [goshopBtn setTitle:@"去上传商品" forState:(UIControlStateNormal)];
    [goshopBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [goshopBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [goshopBtn addTarget:self action:@selector(clickshop:) forControlEvents:(UIControlEventTouchUpInside)];
    goshopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    goshopBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [self.view addSubview:goshopBtn];




}

-(void)clickwan:(UIButton *)sender{
    NSLog(@"点击完成 进入我的店铺");
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[TCShopViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)clickshop:(UIButton *)sender{
    NSLog(@"跳到商品管理界面");
    TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
    tab.selectedIndex = 2;
    [self presentViewController:tab animated:YES completion:nil];
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
