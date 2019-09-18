//
//  TCPersonalCommitView.h
//  顺道嘉商家版
//
//  Created by GeYang on 2017/4/12.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^commit)();
typedef void(^cancel)();

@interface TCPersonalCommitView : UIView
@property (nonatomic, copy)commit commit;
@property (nonatomic, copy)cancel cancel;

+ (instancetype)showCommitView:(NSString *)title andCommit:(commit)commit andCancel:(cancel)cacel;


@end
