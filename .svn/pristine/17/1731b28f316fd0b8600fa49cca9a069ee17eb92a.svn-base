//
//  TCYuePayHub.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/3/6.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCYuePayHub.h"

static TCYuePayHub *payhub = nil;

@interface TCYuePayHub()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *fix;
@property (nonatomic, strong) NSString *mes;
@end

@implementation TCYuePayHub

+ (instancetype)ShowTip:(NSString *)mes andChickCommit:(chickCommit)commit{
    if (payhub == nil) {
        payhub = [[TCYuePayHub alloc]init:mes andchick:commit];
    }
    return payhub;
}

- (id)init:(NSString *)mes andchick:(chickCommit)commit{
    if (self == [super init]) {
        _mes = mes;
        _chickcommit = commit;
        [self create];
    }
    return self;
}

- (void)create{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview: _backView];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(40, HEIGHT / 2 -  131 / 2, WIDHT - 80, 131)];
    _showView.backgroundColor = [UIColor whiteColor];
    _showView.layer.cornerRadius = 8;
    _showView.layer.masksToBounds = YES;
    [_backView addSubview: _showView];
    
    
    UILabel *meslb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _showView.frame.size.width, 82)];
    meslb.textAlignment = NSTextAlignmentCenter;
    meslb.text = _mes;
    meslb.font = [UIFont systemFontOfSize:18];
    meslb.textColor = TCUIColorFromRGB(0xb94141);
    [_showView addSubview: meslb];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, meslb.frame.origin.y + meslb.frame.size.height, meslb.frame.size.width, 1)];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [_showView addSubview: line];
    
    _cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, meslb.frame.origin.y + meslb.frame.size.height + 1, _showView.frame.size.width / 2, 48)];
    [_cancel setTitle:@"否" forState:UIControlStateNormal];
    [_cancel setTitleColor:TCUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    _cancel.backgroundColor = [UIColor whiteColor];
    [_cancel addTarget:self action:@selector(cancels) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview: _cancel];
    
    _fix = [[UIButton alloc]initWithFrame:CGRectMake(_showView.frame.size.width / 2, _cancel.frame.origin.y, _cancel.frame.size.width, 50)];
    _fix.backgroundColor = [UIColor whiteColor];
    [_fix setTitleColor:TCUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [_fix setTitle:@"是" forState:UIControlStateNormal];
    [_fix addTarget:self action:@selector(fixs) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview: _fix];
    
    
}

- (void)cancels{
    [_backView removeFromSuperview];
    payhub = nil;
}

- (void)fixs{
    _chickcommit();
    [_backView removeFromSuperview];
    payhub = nil;
}















@end
