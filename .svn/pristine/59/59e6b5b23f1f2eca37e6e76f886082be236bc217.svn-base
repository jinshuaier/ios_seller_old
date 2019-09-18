//
//  TCPersonalCommitView.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/4/12.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCPersonalCommitView.h"

static TCPersonalCommitView *commitview = nil;

@interface TCPersonalCommitView()
@property (nonatomic, strong) UIView *backview;
@end

@implementation TCPersonalCommitView

+ (instancetype)showCommitView:(NSString *)title andCommit:(commit)commit andCancel:(cancel)cacel{
    if (commitview == nil) {
        commitview = [[TCPersonalCommitView alloc]initCommit:commit andCancel:cacel];
    }
    return commitview;
}

- (id)initCommit:(commit)commit andCancel:(cancel)cacel{
    if (self == [super init]) {
        _commit = commit;
        _cancel = cacel;
        [self create];
    }
    return self;
}

- (void)create{
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview: _backview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(36, HEIGHT / 2 - 170 / 2, WIDHT - 72, 170)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [_backview addSubview: view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 32, view.frame.size.width - 48, 66)];
    label.text = @"提交后我们将在1~2个工作日内审核您的信息，提交后的信息将不能修改，请仔细确认检查后提交！";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = TCUIColorFromRGB(0x666666);
    label.numberOfLines = 0;
    [view addSubview: label];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.size.height - 48 - 1, view.frame.size.width, 1)];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [view addSubview: line];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, line.frame.origin.y + 1, line.frame.size.width / 2, 48);
    [btn1 setTitle:@"返回修改" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [view addSubview: btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn1.frame.origin.x + btn1.frame.size.width, btn1.frame.origin.y, btn1.frame.size.width, btn1.frame.size.height);
    [btn2 setTitle:@"提交" forState:UIControlStateNormal];
    [btn2 setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(commits) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: btn2];

}

- (void)back{
//    _cancel();
    [_backview removeFromSuperview];
    commitview = nil;
}

- (void)commits{
    _commit();
    [_backview removeFromSuperview];
    commitview = nil;
    
}









@end
