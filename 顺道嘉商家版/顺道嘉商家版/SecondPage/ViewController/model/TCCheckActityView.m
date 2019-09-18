//
//  TCCheckActityView.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/24.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCCheckActityView.h"
#import "TCOffLineActivityViewController.h"
#import "TCCreateOffActityViewController.h"
#import "UIApplication+GYApplication.h"
@implementation TCCheckActityView
{
    UIView *backView;
    UIView *shoperView;
    UILabel *hintLabel;
}

-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)title andMessage:(NSString *)message{
    self = [super init];
    if(self){
        [self createUI:title andmessage:message];
    }
    return self;
}
#pragma mark -- 创建UI
-(void)createUI:(NSString *)title andmessage:(NSString *)message{
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    backView.tag = 100001;
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //自定义的弹窗
    shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake(36, 209, WIDHT - 72, 200);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 12;
    shoperView.layer.masksToBounds= YES;
    [backView addSubview:shoperView];
   //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 15, shoperView.frame.size.width, 18);
    titleLabel.text = message;
    titleLabel.textColor = TCUIColorFromRGB(0x525F66);
    titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [shoperView addSubview:titleLabel];
    //输入原因的view
    UIView *resonView = [[UIView alloc] init];
    resonView.frame = CGRectMake(12, titleLabel.frame.size.height + titleLabel.frame.origin.y + 28, shoperView.frame.size.width - 24, 100);
    resonView.backgroundColor = TCUIColorFromRGB(0xF3F3F3);
    [shoperView addSubview:resonView];
    //原因的文字
    UILabel *resonLabel = [[UILabel alloc] init];
    resonLabel.frame = CGRectMake(8, 16, resonView.frame.size.width - 8 - 16, 38);
    resonLabel.textColor = TCUIColorFromRGB(0x333333);
    resonLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    resonLabel.numberOfLines = 0;
    resonLabel.textAlignment = NSTextAlignmentLeft;
   // resonLabel.text = title;
    
    
//    CGSize titlesize = [resonLabel sizeThatFits:CGSizeMake(resonView.frame.size.width - 8 - 16, MAXFLOAT)];
//    resonLabel.frame = CGRectMake(8, 16, titlesize.width, titlesize.height);
//    resonView.frame = CGRectMake(12, titleLabel.frame.size.height + titleLabel.frame.origin.y + 28, shoperView.frame.size.width - 24, titlesize.height + 46);
    
    NSString *LabelString = title;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:LabelString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".PingFangSC-Regular" size:16] range:NSMakeRange(0, 0)];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [LabelString length])];
    [resonLabel setAttributedText:attributedString];
    [resonLabel sizeToFit];
    resonView.frame = CGRectMake(12, titleLabel.frame.size.height + titleLabel.frame.origin.y + 28, shoperView.frame.size.width - 24, resonLabel.frame.size.height + 46);
    //[shoperView addSubview:hintLabel];

    [resonView addSubview:resonLabel];
    //放弃的按钮
    UIButton *waiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    waiveBtn.frame = CGRectMake(0, 29 + resonView.frame.size.height + resonView.frame.origin.y, shoperView.frame.size.width/2, 48);
    [waiveBtn setTitle:@"放弃" forState:(UIControlStateNormal)];
    [waiveBtn setTitleColor:TCUIColorFromRGB(0xC4C4C4) forState:(UIControlStateNormal)];
    waiveBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    [waiveBtn addTarget:self action:@selector(waiveClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:waiveBtn];
    
    //重新申请
    UIButton *againBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    againBtn.frame = CGRectMake(shoperView.frame.size.width/2, 29 + resonView.frame.size.height + resonView.frame.origin.y, shoperView.frame.size.width/2, 48);
    [againBtn setTitle:@"重新申请" forState:(UIControlStateNormal)];
    [againBtn setTitleColor:TCUIColorFromRGB(0x24A7F2) forState:(UIControlStateNormal)];
    againBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    [againBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:againBtn];

    CGFloat h = againBtn.frame.origin.y + againBtn.frame.size.height;
    shoperView.frame = CGRectMake(36, HEIGHT / 2 - h / 2, WIDHT - 72, h);
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)againBtnClick:(UIButton *)sender
{
    NSLog(@"重新申请");
    [backView removeFromSuperview];
    backView = nil;
    TCCreateOffActityViewController *createVC = [[TCCreateOffActityViewController alloc]init];
    createVC.isChange = YES;
    createVC.isPush = YES;
    createVC.content = self.contentActity;
    //判断是哪一个vc
    UINavigationController *navi = [[UIApplication sharedApplication] visibleNavigationController];
    [navi presentViewController:createVC animated:YES completion:nil];
}
//*************************** 开启 ******************************//
-(instancetype)initWithFrame:(CGRect)frame andmessage:(NSString *)message{
    self = [super init];
    if(self){
        if(backView){
            [backView removeFromSuperview];
            [self createMessage:message];
        }else{
            [self createMessage:message];
        }
    }
    return self;
}
#pragma mark -- 创建UI
-(void)createMessage:(NSString *)message{
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    backView.tag = 100002;
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //自定义的弹窗
    shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake(40, 240, WIDHT - 80, 98 + 48);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 12;
    shoperView.layer.masksToBounds= YES;
    [backView addSubview:shoperView];
    //活动开启的文字
    UILabel *begainLabel = [[UILabel alloc] init];
    begainLabel.frame = CGRectMake(68, 32, shoperView.frame.size.width - 136, 18);
    begainLabel.textColor = TCUIColorFromRGB(0x2EA8E5);
    begainLabel.textAlignment = NSTextAlignmentCenter;
    begainLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:18];
    begainLabel.numberOfLines = 0;
    begainLabel.text = message;
    CGSize titlesize = [begainLabel sizeThatFits:CGSizeMake(shoperView.frame.size.width - 136, MAXFLOAT)];
    begainLabel.frame = CGRectMake(68, 32, shoperView.frame.size.width - 136, titlesize.height);
    
//    NSString *LabelString = message;
//    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:LabelString];
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".PingFangSC-Regular" size:16] range:NSMakeRange(0, 0)];
//    [paragraphStyle setLineSpacing:4];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [LabelString length])];
//    [resonLabel setAttributedText:attributedString];
//    [resonLabel sizeToFit];
    [shoperView addSubview:begainLabel];
    
    //放弃的按钮
    UIButton *waiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    waiveBtn.frame = CGRectMake(0,  begainLabel.frame.size.height + begainLabel.frame.origin.y + 48, shoperView.frame.size.width/2, 48);
    [waiveBtn setTitle:@"知道了" forState:(UIControlStateNormal)];
    [waiveBtn setTitleColor:TCUIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
    waiveBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:18];
    [waiveBtn addTarget:self action:@selector(waiveClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:waiveBtn];
    
    //重新申请
    UIButton *againBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    againBtn.frame = CGRectMake(shoperView.frame.size.width/2, begainLabel.frame.size.height + begainLabel.frame.origin.y + 48, shoperView.frame.size.width/2, 48);
    [againBtn setTitle:@"去查看" forState:(UIControlStateNormal)];
    [againBtn setTitleColor:TCUIColorFromRGB(0x4D4D4D) forState:(UIControlStateNormal)];
    againBtn.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:18];;
    [againBtn addTarget:self action:@selector(lookBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:againBtn];
    
    CGFloat h = againBtn.frame.origin.y + againBtn.frame.size.height;
    shoperView.frame = CGRectMake(40, HEIGHT / 2 - h / 2, WIDHT - 80, h);
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark -- 去查看
-(void)lookBtnClick:(UIButton *)sender
{
    [backView removeFromSuperview];
    backView = nil;
    
    TCOffLineActivityViewController *offVC = [[TCOffLineActivityViewController alloc]init];
    offVC.isPush = YES;
    UINavigationController *navi = [[UIApplication sharedApplication] visibleNavigationController];
    [navi presentViewController:offVC animated:YES completion:nil];
    //发送通知刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offLineShuaxin" object:nil];
}

#pragma mark -- 按钮的点击事件
-(void)waiveClick:(UIButton *)sender
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

/****************** 保证金 *********************/
-(instancetype)initWithFrame:(CGRect)frame andTtiles:(NSString *)titles andMessages:(NSString *)messages
{
    self = [super init];
    if(self){
        [self createUI:titles andmessages:messages];
    }
    return self;
}
#pragma mark -- 创建UI
-(void)createUI:(NSString *)titles andmessages:(NSString *)messages{
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    backView.tag = 100005;
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //自定义的弹窗
    shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake(12, 209, WIDHT - 24, 200);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 12;
    shoperView.layer.masksToBounds= YES;
    [backView addSubview:shoperView];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 16, shoperView.frame.size.width, 22);
    titleLabel.text = messages;
    titleLabel.textColor = TCUIColorFromRGB(0x24A7F2);
    titleLabel.font = [UIFont fontWithName:@".PingFangSC-Medium" size:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [shoperView addSubview:titleLabel];
    //输入原因的view
    UIView *resonView = [[UIView alloc] init];
    resonView.frame = CGRectMake(12, titleLabel.frame.size.height + titleLabel.frame.origin.y + 28, shoperView.frame.size.width - 24, 100);
    resonView.backgroundColor = TCUIColorFromRGB(0xF3F3F3);
    [shoperView addSubview:resonView];
    //原因的文字
    UILabel *resonLabel = [[UILabel alloc] init];
    resonLabel.frame = CGRectMake(8, 16, resonView.frame.size.width - 8 - 16, 38);
    resonLabel.textColor = TCUIColorFromRGB(0x333333);
    resonLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    resonLabel.numberOfLines = 0;
    resonLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString *LabelString = titles;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:LabelString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@".PingFangSC-Regular" size:16] range:NSMakeRange(0, 0)];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [LabelString length])];
    [resonLabel setAttributedText:attributedString];
    [resonLabel sizeToFit];
    resonView.frame = CGRectMake(12, titleLabel.frame.size.height + titleLabel.frame.origin.y + 28, shoperView.frame.size.width - 24, resonLabel.frame.size.height + 46);
    
    [resonView addSubview:resonLabel];
    //按钮
    UIButton *okButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    okButton.frame = CGRectMake(20, resonView.frame.size.height + resonView.frame.origin.y + 48, shoperView.frame.size.width - 40, 46);
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1AC6FF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
    [okButton.layer addSublayer:gradientLayer];
    okButton.layer.cornerRadius = 46/2;
    okButton.layer.masksToBounds = YES;
    [okButton setTitle:@"知道了" forState:(UIControlStateNormal)];
    okButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [okButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [okButton addTarget:self action:@selector(waiveClick:) forControlEvents:(UIControlEventTouchUpInside)];
    okButton.backgroundColor = [UIColor redColor];
    [shoperView addSubview:okButton];
    
    CGFloat h = okButton.frame.origin.y + okButton.frame.size.height + 32;
    shoperView.frame = CGRectMake(12, HEIGHT / 2 - h / 2, WIDHT - 24, h);
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
