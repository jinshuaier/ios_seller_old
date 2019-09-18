//
//  TCTopHubView.h
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTopHubView : UIView
@property (nonatomic, strong) UIView *showview;

- (void)ShowHubWithTitle:(NSString *)title andColor:(UIColor *)color;
@end
