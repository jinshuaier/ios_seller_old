//
//  TCAlertView.m
//  顺道嘉商家版
//
//  Created by Macx on 17/2/17.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAlertView.h"

@implementation TCAlertView
{
    UIView *backView;
    UIView *shoperView;
    UILabel *hintLabel;
}
-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)title{
    self = [super init];
    if(self){
        if(backView){
            [backView removeFromSuperview];
            [self createUI:title];
        }else{
            [self createUI:title];
        }
    }
    return self;
}
#pragma mark -- 创建UI
-(void)createUI:(NSString *)title{
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //自定义的弹窗
    shoperView = [[UIView alloc]init];
    shoperView.frame = CGRectMake(40/2, (backView.frame.size.height - 450/2)/2, WIDHT - 40, 450/2);
    shoperView.backgroundColor = [UIColor whiteColor];
    shoperView.layer.cornerRadius = 16;
    shoperView.layer.masksToBounds= YES;
    [backView addSubview:shoperView];
    
    //警告的文字
    hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(40/2, 72/2, shoperView.frame.size.width - 80/2, 170/2)];
    hintLabel.tag = 100;
    hintLabel.numberOfLines = 0;
    hintLabel.textColor = TCUIColorFromRGB(0x666666);
    hintLabel.font = [UIFont systemFontOfSize:15];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *LabelString = title;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:LabelString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14] range:NSMakeRange(0, 0)];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [LabelString length])];
    [hintLabel setAttributedText:attributedString];
    [hintLabel sizeToFit];
    [shoperView addSubview:hintLabel];
    //确定的按钮
    UIButton *trueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [trueBtn setTitle:@"知道了" forState:(UIControlStateNormal)];
    trueBtn.frame = CGRectMake((shoperView.frame.size.width - 400/2)/2, hintLabel.frame.size.height + hintLabel.frame.origin.y + 20, 400/2, 80/2);
    [trueBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    trueBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    trueBtn.backgroundColor = TCUIColorFromRGB(0x25DADA);
    trueBtn.layer.cornerRadius = 48/2;
    trueBtn.layer.masksToBounds = YES;
    [trueBtn addTarget:self action:@selector(cilcik) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:trueBtn];
    
    CGFloat h = trueBtn.frame.origin.y + trueBtn.frame.size.height + 20;
    shoperView.frame = CGRectMake(WIDHT / 2 - 672 / 4 *WIDHTSCALE, HEIGHT / 2 - h / 2, 672/2 *WIDHTSCALE, h);
    
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}
-(void)cilcik{
    
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


@end
