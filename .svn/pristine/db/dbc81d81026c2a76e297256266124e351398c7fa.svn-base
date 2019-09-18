
//
//  TCCodeCheckView.m
//  商家版线下活动付款
//
//  Created by 胡高广 on 2017/5/25.
//  Copyright © 2017年 胡高广. All rights reserved.
//

#import "TCCodeCheckView.h"
#import "TCDealOrderViewController.h"
#import "TCOffLineActivityViewController.h"
#import "UIApplication+GYApplication.h"
// 屏幕适配时需要的宏
#define WIDHT [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define TCUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
//@interface TCCodeCheckView ()
//@property (nonatomic, strong) UIView *backView;
//@property (nonatomic, strong) UIView *shoperView;
//
//@end

@implementation TCCodeCheckView
{
    UIView *backView;
    UIView *shoperView;
    UILabel *hintLabel;
}

-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)title andtime:(NSString *)time{
    self = [super init];
    if(self){
        [self createUI:title andtime:time];
    }
    return self;
}
#pragma mark -- 创建UI
-(void)createUI:(NSString *)title andtime:(NSString *)time{
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    backView.tag = 100000;
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //自定义的弹窗
    shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake(36, 180.9, WIDHT - 72, 278);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 12;
    shoperView.layer.masksToBounds= YES;
    [backView addSubview:shoperView];
    //引导的图
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(0, 0, shoperView.frame.size.width, 68);
    titleImage.image = [UIImage imageNamed:@"圆弧蓝色背景"];
    titleImage.userInteractionEnabled = YES;
    [shoperView addSubview:titleImage];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 16, shoperView.frame.size.width, 21);
    titleLabel.text = @"您有一笔收款";
    titleLabel.font = [UIFont fontWithName:@".PingFangSC-Semibold" size:16];
    titleLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleImage addSubview:titleLabel];
    //返回的按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(shoperView.frame.size.width - 13 - 24, 13, 24, 24);
    [backButton setImage:[UIImage imageNamed:@"扫码关闭按钮"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backbtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [titleImage addSubview:backButton];
    //金钱框
    UIView *moneyView = [[UIView alloc] init];
    moneyView.backgroundColor = TCUIColorFromRGB(0xF7F7F7);
    moneyView.layer.cornerRadius = 4;
    moneyView.clipsToBounds = YES;
    moneyView.frame = CGRectMake(76, titleImage.frame.size.height + titleImage.frame.origin.y + 24, 137, 40);
    [shoperView addSubview:moneyView];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.textColor = TCUIColorFromRGB(0x333333);
    moneyLabel.text = title;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [moneyLabel setFont:[UIFont fontWithName:@".PingFangSC-Semibold" size:30]];
    CGSize size = [moneyLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:moneyLabel.font,NSFontAttributeName, nil]];
    moneyLabel.frame = CGRectMake((shoperView.frame.size.width/2 - size.width/2) - 24,  titleImage.frame.size.height + titleImage.frame.origin.y + 24, size.width + 48, 40);
    moneyView.frame = CGRectMake((shoperView.frame.size.width/2 - size.width/2) - 24, titleImage.frame.size.height + titleImage.frame.origin.y + 24, size.width + 48, 40);
    [shoperView addSubview:moneyLabel];
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = time;
    timeLabel.frame = CGRectMake(0, moneyLabel.frame.size.height + moneyLabel.frame.origin.y + 24, shoperView.frame.size.width, 14);
    timeLabel.textColor = TCUIColorFromRGB(0x666666);
    timeLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:12];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [shoperView addSubview:timeLabel];
    //查看详情的按钮
    
    UIButton *lookBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lookBtn.frame = CGRectMake(54, timeLabel.frame.size.height + timeLabel.frame.origin.y + 32,shoperView.frame.size.width - 108, 44);
    //[lookBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
   // lookBtn.layer.cornerRadius=44/2;
    [lookBtn addTarget:self action:@selector(lookBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    lookBtn.layer.shadowColor=[TCUIColorFromRGB(0x24A7F2) colorWithAlphaComponent:0.5].CGColor;
    lookBtn.layer.shadowOffset=CGSizeMake(4, 4);
    lookBtn.layer.shadowOpacity=0.5;
    lookBtn.layer.shadowRadius= 5;
    
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x5FCAFF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, shoperView.frame.size.width - 108, 44);
    gradientLayer.cornerRadius = 44/2;
    [lookBtn.layer addSublayer:gradientLayer];
    [shoperView addSubview:lookBtn];
    
    UILabel *btnLabel = [[UILabel alloc] init];
    btnLabel.frame = CGRectMake(0, 14, lookBtn.frame.size.width, 16);
    btnLabel.text = @"查看详情";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [lookBtn addSubview:btnLabel];

    
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)backbtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformScale(shoperView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [backView removeFromSuperview];
                backView = nil;
            }];
        }];
    }];

}
//获取View所在的Viewcontroller方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
#pragma mark -- 查看详情
-(void)lookBtn:(UIButton *)sender
{
    [backView removeFromSuperview];
    backView = nil;
    
    TCDealOrderViewController *DealOrderVC = [[TCDealOrderViewController alloc]init];
    DealOrderVC.oidStr = self.CodeCheckOid;

    UINavigationController *navi = [[UIApplication sharedApplication] visibleNavigationController];
    [navi presentViewController:DealOrderVC animated:YES completion:nil];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
