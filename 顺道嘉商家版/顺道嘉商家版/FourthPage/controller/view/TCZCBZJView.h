//
//  TCZCBZJView.h
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^commit)(void);

@interface TCZCBZJView : UIView
@property (nonatomic, copy) commit commit;
@property (nonatomic, strong) UIView *backview;
@property (nonatomic, strong) NSString *shopID;
+ (instancetype)ShowViewShopid:(NSString *)shopid  andcommit:(commit)commit;

@end
