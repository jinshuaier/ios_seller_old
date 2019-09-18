//
//  TCUpdateView.m
//  顺道嘉(新)
//
//  Created by 某某 on 16/10/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TCUpdateView.h"
#import "AppDelegate.h"

static TCUpdateView *upview = nil;
@interface TCUpdateView()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *lb_verContent;
@end

@implementation TCUpdateView

+ (id)upDateView:(NSArray *)version{
    if (upview == nil) {
        upview = [[TCUpdateView alloc] initMessage:version];
        
    }
    return upview;
}

- (id)initMessage:(NSArray *)version{
    if(self == [super init]){
        [self create:version]; //更新内容
    }
    return self;
}

//更新内容
- (void)create:(NSArray *)version {
    
    //背景颜色
    _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    _backView.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview: _backView];

    //版本图片
    UIImageView *versionImage = [[UIImageView alloc] init];
    versionImage.frame = CGRectMake(70, 166 *HEIGHTSCALE, WIDHT - 140, 96 + 168);
    versionImage.image = [UIImage imageNamed:@"更新提醒"];
    versionImage.userInteractionEnabled = YES;
    [_backView addSubview:versionImage];
    
    //更新的内容
    for (int i = 0; i < version.count; i ++) {
        _lb_verContent = [[UILabel alloc] init];
        _lb_verContent.frame = CGRectMake(15, 96 + 17 + 20 * i, WIDHT - 144 - 46, 18);
        _lb_verContent.text = version[i];
        _lb_verContent.textColor = TCUIColorFromRGB(0x0A0A0A);
        _lb_verContent.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [versionImage addSubview:_lb_verContent];
    }

    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    _leftBtn.backgroundColor = TCUIColorFromRGB(0x6BC3E9);
    _leftBtn.layer.cornerRadius = 5;
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _leftBtn.frame = CGRectMake(20, 96 + 168 - 31 - 16, 88,31);
    [_leftBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [versionImage addSubview: _leftBtn];

    //更新
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_rightBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [_rightBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    _rightBtn.layer.cornerRadius = 5;
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.backgroundColor = TCUIColorFromRGB(0x6BC3E9);
    _rightBtn.frame = CGRectMake(CGRectGetMaxX(_leftBtn.frame)+ 16, 96 + 168 - 31 - 16, 88, 31);
    _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [_rightBtn addTarget:self action:@selector(goVerson) forControlEvents:UIControlEventTouchUpInside];
    [versionImage addSubview: _rightBtn];
}


- (void)quxiao{
    [_backView removeFromSuperview];
}

- (void)goVerson{
    [_backView removeFromSuperview];
    NSString *url = @"https://itunes.apple.com/cn/app/id1151304737?mt=8";
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

@end
