//
//  TitleButton.m
//  封装Tabbar和Navgationbar
//
//  Created by USER on 16/3/10.
//  Copyright © 2016年 UnderZero. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

/**
 * init方法内部会调用这个方法
 * 只有通过代码创建控件,才会执行这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 * 通过xib\storyboard创建控件时,才会执行这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

/**
 * 初始化
 */
- (void)setup
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    // 文字
//    self.titleLabel.x = self.imageView.x;
//
//    // 图片
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
//}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}


@end

