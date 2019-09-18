//
//  TCActiveSetViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/10.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActiveSetViewController.h"

@interface TCActiveSetViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *manField;
@property (nonatomic, strong) UITextField *jianField;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation TCActiveSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"满减优惠活动";
    self.view.backgroundColor = TCBgColor;
    [self creatUI];
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 90)];
    bgView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgView];
    NSArray *arr = @[@"满多少（元）",@"立减（元）"];
    for (int i = 0; i < arr.count; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 45 * i, WIDHT, 45)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [bgView addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 15)];
        titleLabel.text = arr[i];
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        titleLabel.textColor = TCUIColorFromRGB(0x666666);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLabel];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(WIDHT - 15 - WIDHT/2, 15, WIDHT/2, 15)];
        field.placeholder = @"请输入";
        field.delegate = self;
        field.borderStyle = UITextBorderStyleNone;
        field.textAlignment = NSTextAlignmentRight;
        field.textColor = TCUIColorFromRGB(0x333333);
        field.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [field addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
        [view addSubview:field];

        if (i == 0) {
            self.manField = field;
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 44, WIDHT - 15, 1)];
            line.backgroundColor = TCLineColor;
            [view addSubview:line];
        }else{
            self.jianField = field;
        }
    }
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(bgView.frame) + 40, WIDHT - 30, 48)];
    [self.sureBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [self.sureBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    self.sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.userInteractionEnabled = NO;
    self.sureBtn.alpha = 0.6;
    [self.sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.sureBtn];
}
- (void)alueChange:(UITextField *)textField{
    self.sureBtn.enabled = (self.manField.text.length != 0 && self.jianField.text.length != 0);
    if (self.sureBtn.enabled == YES) {
        self.sureBtn.alpha = 1;
        self.sureBtn.userInteractionEnabled = YES;
        [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    }else{
        self.sureBtn.alpha = 0.6;
        self.sureBtn.userInteractionEnabled = NO;
        [self.sureBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    }
}

-(void)clickSure:(UIButton *)sender{
    self.block(self.manField.text, self.jianField.text);
    [self.navigationController popViewControllerAnimated:YES];
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
