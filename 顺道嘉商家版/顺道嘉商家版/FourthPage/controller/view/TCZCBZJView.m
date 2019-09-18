//
//  TCZCBZJView.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCZCBZJView.h"

static TCZCBZJView *views = nil;

@interface TCZCBZJView ()
@property (nonatomic, strong) NSUserDefaults *defaults;

@end
@implementation TCZCBZJView

+ (instancetype)ShowViewShopid:(NSString *)shopid andcommit:(commit)commit{
    
    if (views == nil) {
        views = [[TCZCBZJView alloc]initWithcommit:commit andshopid:shopid];
        
    }
    return views;
}

- (instancetype)initWithcommit:(commit)commit andshopid:(NSString *)shopid{
    if (self == [super init]) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        _shopID = shopid;
        _commit = commit;
        [self create];
    }
    return self;
}
-(void)getID:(NSNotification *)not
{
    self.shopID = not.userInfo[@"shenqingID"];
}
- (void)create{
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview: _backview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(WIDHT / 2 - 288 / 2, HEIGHT / 2 - 196 / 2, 288, 148 + 48)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 12;
    view.layer.masksToBounds = YES;
    view.clipsToBounds = YES;
    [_backview addSubview: view];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(24, 40, 240, 80)];
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = TCUIColorFromRGB(0x333333);
    title.numberOfLines = 0;
    title.text = @"注意：申请转出保证金后，平台需先将终端机收回，并且暂停您获得广告收益的权利，终端机确保无误后返还您全部保证金";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:title.text];
    [string addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 3)];
    title.attributedText = string;
    [view addSubview: title];
    
    
    //line
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.size.height - 49, view.frame.size.width, 1)];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [view addSubview: line];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, view.frame.size.height - 48, view.frame.size.width / 2, 48);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    [cancel setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: cancel];
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(view.frame.size.width / 2, cancel.frame.origin.y, cancel.frame.size.width, 48);
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    [commit setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    commit.backgroundColor = [UIColor whiteColor];
    commit.titleLabel.font = [UIFont systemFontOfSize:16];
    [commit addTarget:self action:@selector(commits) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: commit];
}


- (void)cancel{
    [_backview removeFromSuperview];
    views = nil;
}

- (void)commits{
    //转出保证金
     [self createOutQuest];
}

//转出保证金的接口
-(void)createOutQuest{
    [SVProgressHUD showWithStatus:@"转出中..."];
    NSDictionary *paramter = @{@"id":[_defaults valueForKey:@"userID"], @"token":[_defaults valueForKey:@"userToken"], @"shopid":self.shopID};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecret:@"900042"] paramter:paramter success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if([jsonDic[@"retValue"] integerValue] > 0){
            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retMessage"]];
            _commit();
            [_backview removeFromSuperview];
            views = nil;
        }else{
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retMessage"]];
        }
    } failure:^(NSError *error) {
        nil;
        [SVProgressHUD showErrorWithStatus:@"检查网络"];
    }];
}




@end
