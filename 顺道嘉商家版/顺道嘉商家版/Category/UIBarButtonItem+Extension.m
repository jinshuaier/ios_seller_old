//
//  UIBarButtonItem+Extension.m
//  StampCoinCard
//
//  Created by MyMac on 16/3/8.
//  Copyright © 2016年 ZhangPing. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithBg:(NSString *)bg highBg:(NSString *)highBg target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:bg] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highBg] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];

}
@end
