//
//  TCExplainView.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2017/9/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCExplainView.h"

@implementation TCExplainView

{
    UIView *shotView;
    UIView *backView;
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
    shotView.frame = CGRectMake(12, (HEIGHT - 417)/2 * HEIGHTSCALE, WIDHT - 24, 417*HEIGHTSCALE);
    shotView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    shotView.layer.cornerRadius = 12;
    shotView.layer.masksToBounds = YES;
    [backView addSubview:shotView];
    
    //标题左右的图片
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(114*WIDHTSCALE, 32*HEIGHTSCALE, 132*WIDHTSCALE, 22*HEIGHTSCALE);
    titleLabel.text = @"顺道嘉库使用说明";
    titleLabel.textColor = TCUIColorFromRGB(0x333333);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16*HEIGHTSCALE];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [shotView addSubview:titleLabel];
    
    //左
    UIImageView *leftIamge = [[UIImageView alloc] init];
    leftIamge.frame = CGRectMake(titleLabel.frame.origin.x - 11 - 35, 40*HEIGHTSCALE, 35, 7);
    leftIamge.image = [UIImage imageNamed:@"线-左"];
    [shotView addSubview:leftIamge];
    
    //右
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 11, 40*HEIGHTSCALE, 35, 7);
    rightImage.image = [UIImage imageNamed:@"线 -右"];
    [shotView addSubview:rightImage];
    
    //文字内容
    UILabel * disLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 16  , shotView.frame.size.width - 32, 60)];
    disLabel.text = @"顺道嘉库是顺道嘉平台为方便商家上传商品准备了海量的商品信息，找到您想要上传的商品添加到下架商品。";
    disLabel.numberOfLines = 0;
    disLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*HEIGHTSCALE];
    disLabel.textColor = TCUIColorFromRGB(0x999999);
//    CGSize titlesize = [disLabel sizeThatFits:CGSizeMake(shotView.frame.size.width - 32, MAXFLOAT)];
    [shotView addSubview:disLabel];
    
    //流程的图片
    UIImageView *dotImage = [[UIImageView alloc] init];
    dotImage.frame = CGRectMake(16, CGRectGetMaxY(disLabel.frame) + 17, 16, 16);
    dotImage.image = [UIImage imageNamed:@"点01"];
    [shotView addSubview:dotImage];
    
    //流程1文字说明
    UILabel *dotOneLabel = [[UILabel alloc] init];
    dotOneLabel.frame = CGRectMake(CGRectGetMaxX(dotImage.frame) + 8, CGRectGetMaxY(disLabel.frame) + 16, shotView.frame.size.width - 16 - 40, 21);
    dotOneLabel.numberOfLines = 0;
    dotOneLabel.text = @"1.选中上传的商品，点击添加到下架商品中";
    dotOneLabel.textColor = TCUIColorFromRGB(0x333333);
    dotOneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*HEIGHTSCALE];
    dotOneLabel.textAlignment = NSTextAlignmentLeft;
    [shotView addSubview:dotOneLabel];
    
    //流程2
    UIImageView *dotTwoImage = [[UIImageView alloc] init];
    dotTwoImage.frame = CGRectMake(16, CGRectGetMaxY(dotImage.frame) + 27, 16, 16);
    dotTwoImage.image = [UIImage imageNamed:@"点01"];
    [shotView addSubview:dotTwoImage];
    
    //文字2的说明
    UILabel *dotTwoLabel = [[UILabel alloc] init];
    dotTwoLabel.frame = CGRectMake(CGRectGetMaxX(dotTwoImage.frame) + 5, CGRectGetMaxY(dotOneLabel.frame) + 16, shotView.frame.size.width - 16 - 40, 55);
    dotTwoLabel.numberOfLines = 0;
    dotTwoLabel.text = @"2.在下架商品中可以对该商品进行编辑上架。";
    dotTwoLabel.textColor = TCUIColorFromRGB(0x333333);
    dotTwoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*HEIGHTSCALE];
    dotTwoLabel.textAlignment = NSTextAlignmentLeft;
    [shotView addSubview:dotTwoLabel];
    
    //下面注意的事项
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.frame = CGRectMake(16, CGRectGetMaxY(dotTwoLabel.frame) + 24, shotView.frame.size.width - 32, 40);
    attentionLabel.text = @"注意：添加后的商品没有直接上架，需在下架商品中进行编辑上架";
    attentionLabel.numberOfLines = 0;
    attentionLabel.textColor = TCUIColorFromRGB(0xFF2850);
    attentionLabel.font = [UIFont systemFontOfSize:14*HEIGHTSCALE];
    [shotView addSubview:attentionLabel];
    

    //知道啦按钮
    UIButton *okButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    okButton.frame = CGRectMake((shotView.frame.size.width - 272)/2 , CGRectGetMaxY(attentionLabel.frame) + 40, 336 - 64, 48);
    [okButton setTitle:@"知道了" forState:(UIControlStateNormal)];
    [okButton setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    okButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    okButton.backgroundColor = TCUIColorFromRGB(0x24A7F2);
    okButton.layer.cornerRadius = 24;
    okButton.layer.masksToBounds = YES;
    [okButton addTarget:self action:@selector(okClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shotView addSubview:okButton];
    
    //大小
    CGFloat h = okButton.frame.origin.y + okButton.frame.size.height + 40;
//    shotView.frame = CGRectMake(12, HEIGHT / 2 - h / 2, WIDHT - 24, h);
    
    shotView.frame = CGRectMake(12, HEIGHT / 2 - h / 2, WIDHT - 24, h);
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
