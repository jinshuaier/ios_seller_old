//
//  UIButton+exsicte.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/3.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "UIButton+exsicte.h"

@implementation UIButton (exsicte)
//创建button，无背景图片
+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor   addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}
//创建button，无背景图片,无字体
+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color    addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}
//有背景图片
+(UIButton *)creatButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor   addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
    
}

@end
