//
//  GYTipView.m
//  tableview的视差效果
//
//  Created by GeYang on 2017/4/14.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYTipView.h"

#define GYWIDTH [UIScreen mainScreen].bounds.size.width
#define GYHEIGHT [UIScreen mainScreen].bounds.size.height

static GYTipView *tipview = nil;

@interface GYTipView()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *showView;
@end

@implementation GYTipView

+ (instancetype)ShowTipView:(NSString *)message{
    if (tipview == nil) {
        tipview = [[GYTipView alloc]initMessage:message];
    }
    return tipview;
}

- (id)initMessage:(NSString *)title {
    if (self == [super init]) {
        [self createUI:title andButtonTitle:@"我知道了"];
    }
    return self;
}

//普通布局
- (void)createUI:(NSString *)title andButtonTitle:(NSString *)btnTitle{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GYWIDTH, GYHEIGHT)];
    _backView.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview: _backView];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(36, GYHEIGHT / 2 - 292 / 2, GYWIDTH - 72, 292)];
    _showView.backgroundColor = [UIColor whiteColor];
    _showView.layer.cornerRadius = 12;
    _showView.layer.masksToBounds = YES;
    [_backView addSubview: _showView];
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _showView.frame.size.width, 110)];
    topview.backgroundColor = TCUIColorFromRGB(0x24a7f2);
    [_showView addSubview: topview];
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(_showView.frame.size.width / 2 - 149 / 2, 20, 149, 86)];
    _imageview.image = [UIImage imageNamed:@"保证金通过认证图.png"];
    [topview addSubview: _imageview];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(24, topview.frame.origin.y + topview.frame.size.height + 24, _showView.frame.size.width - 48, 66)];
    _title.text = title;
    _title.textColor = TCUIColorFromRGB(0x525f66);
    _title.font = [UIFont boldSystemFontOfSize:15];
    _title.numberOfLines = 0;
    CGSize size = [_title sizeThatFits:CGSizeMake(_showView.frame.size.width - 48, MAXFLOAT)];
    _title.frame = CGRectMake(24, _imageview.frame.origin.y + _imageview.frame.size.height + 24, size.width, size.height);
    [_showView addSubview: _title];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(21, _showView.frame.size.height - 32 - 40, _showView.frame.size.width - 21 * 2, 40);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)TCUIColorFromRGB(0x1ac6ff).CGColor, (__bridge id)TCUIColorFromRGB(0x24a7f2).CGColor];
    gradientLayer.locations = @[@0.3, @0.6, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = _leftBtn.bounds;
    gradientLayer.shadowOpacity = 0.3;//阴影透明度
    gradientLayer.shadowColor = TCUIColorFromRGB(0x24a7f2).CGColor;//颜色
    gradientLayer.shadowRadius = 3;//扩散范围
    gradientLayer.shadowOffset = CGSizeMake(1, 2);//范围
    gradientLayer.cornerRadius = 20;
    [_leftBtn.layer addSublayer: gradientLayer];
    [_leftBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_leftBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview: _leftBtn];
    
}


- (void)cancel{
    [_backView removeFromSuperview];
    tipview = nil;
}














@end
