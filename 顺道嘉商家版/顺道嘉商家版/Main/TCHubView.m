//
//  TCHubView.m
//  类方法
//
//  Created by Macx on 17/1/12.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "TCHubView.h"
@interface TCHubView()

@end
@implementation TCHubView
static TCHubView * Hud = nil;
+(void)showWithText:(NSString *)text WithDurations:(CGFloat)duration
{
    //添加背景
    TCHubView * custom = [[TCHubView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:custom];
    
    //添加提示框
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    label.text = text;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil]];

    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-size.width/2,  [UIScreen mainScreen].bounds.size.height/2-20, size.width + 30, 40);
    label.textColor = [UIColor whiteColor];
    [custom addSubview:label];
    label.layer.masksToBounds=YES;
    label.layer.cornerRadius=10;
    //创建动画
//    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
//    keyAnimaion.keyPath = @"transform.rotation";
//    keyAnimaion.values = @[@(-1 / 180.0 * M_PI),@(1 /180.0 * M_PI),@(-1/ 180.0 * M_PI)];//度数转弧度
//    
//    keyAnimaion.removedOnCompletion = NO;
//    keyAnimaion.fillMode = kCAFillModeForwards;
//    keyAnimaion.duration = 0.3;
//    keyAnimaion.repeatCount = MAXFLOAT;
//    [label.layer addAnimation:keyAnimaion forKey:nil];
    //视图消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [custom removeFromSuperview];
        
        [UIView animateWithDuration:0.3 animations:^{
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                custom.transform = CGAffineTransformScale(custom.transform, 1.05, 1.05);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    custom.transform = CGAffineTransformScale(custom.transform, 0.01, 0.01);
                } completion:^(BOOL finished) {
                    custom.alpha= 0;

                }];
            }];
        }];
    });
}
+(void)dismiss
{
    [Hud removeFromSuperview];
}



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
       // self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
