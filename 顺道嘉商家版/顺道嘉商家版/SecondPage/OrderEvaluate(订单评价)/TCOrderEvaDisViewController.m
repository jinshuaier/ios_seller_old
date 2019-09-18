//
//  TCOrderEvaDisViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCOrderEvaDisViewController.h"

@interface TCOrderEvaDisViewController ()
{
    UIView *line_oneView;
    UIView *line_two;
}
@property (nonatomic, strong) NSDictionary *dic;
@end

@implementation TCOrderEvaDisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    self.view.backgroundColor = TCBgColor;
    
    //请求接口
    [self quest];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- 请求接口
- (void)quest
{
//    [BQActivityView showActiviTy];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSDictionary *dic = @{@"Id":self.idStr};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"Id":self.idStr,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"202005"] paramter:dicc success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        self.dic = jsonDic[@"data"];
        //创建View
        [self createUI];
//        [BQActivityView hideActiviTy];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD dismiss];

//        [BQActivityView hideActiviTy];

    }];
}

#pragma mark -- 创建view
- (void)createUI
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    backView.frame = CGRectMake(10, 10, WIDHT - 20, 421);
    [self.view addSubview:backView];
    
    //评价人
    NSArray *manArr = @[@"评价人:",@"评价时间:",@"订单编号:"];
    NSArray *messArr;
    if (self.dic == nil){
        messArr = @[@"暂无",@"暂无",@"暂无"];
    } else {
        messArr = @[self.dic[@"nickname"],self.dic[@"createTime"],self.dic[@"ordersn"]];
    }
    for (int i = 0; i < manArr.count; i ++) {
        UILabel *titleLable = [UILabel publicLab:manArr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        titleLable.frame = CGRectMake(10, 20 + (10+14)*i, 60, 14);
        [backView addSubview:titleLable];
        
        //信息
        UILabel *messLable = [UILabel publicLab:messArr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        messLable.frame = CGRectMake(10 + CGRectGetMaxX(titleLable.frame), 20 + (10+14)*i, WIDHT - 20 - (10 + CGRectGetMaxX(titleLable.frame)), 14);
        [backView addSubview:messLable];
        if (i == 0){
            messLable.textColor = TCUIColorFromRGB(0x333333);
        }
        if (i == 2){
            //线
            line_oneView = [[UIView alloc] init];
            line_oneView.backgroundColor = TCBgColor;
            line_oneView.frame = CGRectMake(10, CGRectGetMaxY(messLable.frame) + 20, WIDHT - 20 - 20, 1);
            [backView addSubview:line_oneView];
        }
    }
        
    //综合评价
    NSArray *evlArr = @[@"综合评分:",@"商家服务:",@"商品质量:",@"物流时间:"];
    NSArray *fenArr;
    if (self.dic == nil){
        fenArr = @[@"0",@"0",@"0",@"0"];
    } else {
        fenArr = @[self.dic[@"score"],self.dic[@"serviceScore"],self.dic[@"goodsScore"],self.dic[@"deliverScore"]];
    }
        for (int i = 0; i < evlArr.count; i ++) {
            UILabel *evlLabel = [UILabel publicLab:evlArr[i] textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
            evlLabel.frame = CGRectMake(10, CGRectGetMaxY(line_oneView.frame) + 20 + (10+14)*i, 60, 14);
            [backView addSubview:evlLabel];
            
            //评分
            UILabel *fenLabel = [UILabel publicLab:fenArr[i] textColor:TCUIColorFromRGB(0xFF5544) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:14 numberOfLines:0];
            fenLabel.frame = CGRectMake(CGRectGetMaxX(evlLabel.frame) + 10, CGRectGetMaxY(line_oneView.frame) + 20 + (10+14)*i, WIDHT - 20 - (CGRectGetMaxX(evlLabel.frame) + 10), 14);
            [backView addSubview:fenLabel];
            if (i == 3){
                //下划线
                line_two = [[UIView alloc] init];
                line_two.frame = CGRectMake(10, CGRectGetMaxY(fenLabel.frame) + 20, WIDHT - 20 - 20, 1);
                [backView addSubview:line_two];
            }
        }
            //评价内容
    UILabel *contitleLabel = [UILabel publicLab:@"评论内容：" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    contitleLabel.frame = CGRectMake(10, CGRectGetMaxY(line_two.frame) + 20, 70, 14);
    [backView addSubview:contitleLabel];
    
    //评价的回
    UIView *garyView = [[UIView alloc] init];
    garyView.backgroundColor = TCUIColorFromRGB(0xF8F8F8);
    garyView.frame = CGRectMake(10, CGRectGetMaxY(contitleLabel.frame) + 10, WIDHT - 20 - 20, 118);
    [backView addSubview:garyView];
    //内容
    UILabel *contentLabel = [UILabel publicLab:nil textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    if ([self.dic[@"comment"] isEqualToString:@""]){
        contentLabel.text = @"暂无";
    } else {
        contentLabel.text = self.dic[@"comment"];
    }
    contentLabel.frame = CGRectMake(10, 10, WIDHT - 20 - 20 - 20, 98);
     CGSize size = [contentLabel sizeThatFits:CGSizeMake(WIDHT - 20 - 20 - 20, MAXFLOAT)];
    contentLabel.frame = CGRectMake(10, 10, WIDHT - 20 - 20 - 20, size.height);
    [garyView addSubview:contentLabel];
    garyView.frame = CGRectMake(10, CGRectGetMaxY(contitleLabel.frame) + 10, WIDHT - 20 - 20, CGRectGetMaxY(contentLabel.frame) + 10);
    backView.frame = CGRectMake(10, 10, WIDHT - 20, CGRectGetMaxY(garyView.frame) + 20);

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
