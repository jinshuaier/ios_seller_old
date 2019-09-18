//
//  TCActityExplainView.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/5/24.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCActityExplainView.h"

@implementation TCActityExplainView
{
    UIView *shotView;
    UIView *backView;
    UIScrollView *scroll;
}

- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //创建活动说明页面
        [self makeView];
    }
    return self;
}
//创建页面
-(void)makeView
{
    //背景颜色
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    //弹窗
    shotView = [[UIView alloc] init];
    shotView.frame = CGRectMake(24, 83, WIDHT - 48, HEIGHT - 166);
    shotView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    shotView.layer.cornerRadius = 12;
    shotView.layer.masksToBounds = YES;
    [backView addSubview:shotView];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 24, shotView.frame.size.width, 25);
    titleLabel.text = @"活动说明";
    titleLabel.textColor = TCUIColorFromRGB(0x333333);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [shotView addSubview:titleLabel];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(24,titleLabel.frame.size.height + titleLabel.frame.origin.y + 16, shotView.frame.size.width - 48, 310)];
    scroll.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    scroll.showsVerticalScrollIndicator = YES;
    [shotView addSubview:scroll];
    
    //文字内容
    UILabel * disLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, shotView.frame.size.width - 48, 480)];
    disLabel.text = @"1.商家申请活动后，需进行审核，审核通过后活动才能开始，审核情况会以短信、推送通知、APP弹窗通知三种形式进行通知；\n2.商家如需申请banner活动，只需在申请时注明，提交后会有客服人员电话联系商家或商家也可直接致电客服；\n3.每期活动时间均为7天，活动开始后，店铺在活动规定时间内没有办法进行修改，只有等活动结束后才能进行修改，如需紧急下线，请联系客服进行下线；\n4.活动的上线时间为审核通过后，结束时间为第七天24时。例：5月1号13:31:33申请的活动，5月2号10:30:33审核通过的，结束的时间为5月8号24:00:00；\n5.活动结束后，只需将原有的活动进行修改编辑，重新提交审核即可，无需其他操作；\n6.每个店铺只能上线一个线下活动。";
    disLabel.numberOfLines = 0;
    disLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    disLabel.textColor = TCUIColorFromRGB(0x525F66);
    CGSize titlesize = [disLabel sizeThatFits:CGSizeMake(shotView.frame.size.width - 48, MAXFLOAT)];
    disLabel.frame = CGRectMake(0, 0, titlesize.width, titlesize.height);
    if(disLabel.frame.size.height > 310){
        disLabel.frame = CGRectMake(0, 0, shotView.frame.size.width - 48, titlesize.height);
        scroll.frame = CGRectMake(24,titleLabel.frame.size.height + titleLabel.frame.origin.y + 16, shotView.frame.size.width - 48, 310);
        scroll.contentSize = CGSizeMake(titlesize.width, disLabel.frame.size.height + 40);
    }else{
        scroll.contentSize = CGSizeMake(titlesize.width, disLabel.frame.size.height);
        scroll.frame = CGRectMake(24,titleLabel.frame.size.height + titleLabel.frame.origin.y + 16, shotView.frame.size.width - 48,disLabel.frame.size.height + 40);
    }
    [scroll addSubview:disLabel];
    //创建下面的View，便于以后加阴影
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(16, scroll.frame.size.height + scroll.frame.origin.y, shotView.frame.size.width - 32, 92);
    bottomView.backgroundColor = [UIColor whiteColor];
    [shotView addSubview:bottomView];
    //按钮
    UIButton *okButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    okButton.frame = CGRectMake(41, 32, bottomView.frame.size.width - 82, 44);
    okButton.layer.cornerRadius = 22;
    okButton.layer.masksToBounds = YES;
    [okButton addTarget:self action:@selector(okClick:) forControlEvents:(UIControlEventTouchUpInside)];
    //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1AC6FF).CGColor, (__bridge id)TCUIColorFromRGB(0x24A7F2).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, WIDHT, 140);
    [okButton.layer addSublayer:gradientLayer];
    
    //button里面的文字
    UILabel *btnLabel = [[UILabel alloc] init];
    btnLabel.frame = CGRectMake(0, 11, okButton.frame.size.width, 22);
    btnLabel.text = @"知道啦";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    btnLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [okButton addSubview:btnLabel];
    [bottomView addSubview:okButton];
    
    CGFloat h = bottomView.frame.origin.y + bottomView.frame.size.height + 16;
    shotView.frame = CGRectMake(24, HEIGHT / 2 - h / 2, WIDHT - 48, h);
    shotView.transform = CGAffineTransformScale(shotView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shotView.transform = CGAffineTransformIdentity;
        }];
    }];
}
#pragma mark -- okClick
-(void)okClick:(UIButton *)sender
{
    NSLog(@"知道啦");
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shotView.transform = CGAffineTransformScale(shotView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                shotView.transform = CGAffineTransformScale(shotView.transform, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [backView removeFromSuperview];
                backView = nil;
            }];
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
