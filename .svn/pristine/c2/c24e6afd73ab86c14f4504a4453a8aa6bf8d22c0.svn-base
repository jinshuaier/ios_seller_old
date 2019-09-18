//
//  TCDeleCateListView.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCDeleCateListView.h"

@implementation TCDeleCateListView
{
    UIView *backView;
    UIView *_showView;
    UILabel *hintLabel;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
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
    //创建背景
    backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hah)];
    [backView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(15, HEIGHT / 2 - 70, WIDHT - 30, 140)];
    _showView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    _showView.layer.cornerRadius = 4;
    _showView.layer.masksToBounds = YES;
    _showView.userInteractionEnabled = YES;
    [backView addSubview: _showView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, _showView.frame.size.width - 70, 80)];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = TCUIColorFromRGB(0x666666);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:titleLabel];
    
    //下划线
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 80, WIDHT - 30, 1);
    lineView.backgroundColor = TCUIColorFromRGB(0xE1E1E1);
    [_showView addSubview:lineView];
    
    //左边的按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitle:@"确认删除" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:UIControlStateNormal];
    _leftBtn.frame = CGRectMake(0,CGRectGetMaxY(lineView.frame), _showView.frame.size.width / 2 - 1, 60);
    _leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [_leftBtn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview: _leftBtn];
    
    //线
    UIView *twoView = [[UIView alloc] init];
    twoView.frame = CGRectMake(CGRectGetMaxX(_leftBtn.frame), CGRectGetMaxY(lineView.frame), 1, 60);
    twoView.backgroundColor = TCUIColorFromRGB(0xE1E1E1);
    [_showView addSubview:twoView];
    
    //右边的按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:UIControlStateNormal];
    [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    _rightBtn.frame = CGRectMake(_leftBtn.frame.origin.x + _leftBtn.frame.size.width + 1, _leftBtn.frame.origin.y, _leftBtn.frame.size.width, _leftBtn.frame.size.height);
    _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [_rightBtn addTarget:self action:@selector(mis) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview: _rightBtn];
    
    _showView.transform = CGAffineTransformScale(_showView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        _showView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _showView.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)hah{
    
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _showView.transform = CGAffineTransformScale(_showView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _showView.transform = CGAffineTransformScale(_showView.transform, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [backView removeFromSuperview];
                backView = nil;
            }];
        }];
    }];
}

- (void)mis
{
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _showView.transform = CGAffineTransformScale(_showView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _showView.transform = CGAffineTransformScale(_showView.transform, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [backView removeFromSuperview];
                backView = nil;
            }];
        }];
    }];
}

- (void)go:(UIButton *)sender
{
    NSLog(@"确认删除");
    
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _showView.transform = CGAffineTransformScale(_showView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _showView.transform = CGAffineTransformScale(_showView.transform, 0.01, 0.01);
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
