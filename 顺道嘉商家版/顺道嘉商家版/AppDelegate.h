//
//  AppDelegate.h
//  顺道嘉商家版
//
//  Created by 某某 on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
static BOOL Production = TRUE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property BOOL isBack;

@end

