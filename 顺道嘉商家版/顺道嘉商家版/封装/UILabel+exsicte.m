//
//  UILabel+exsicte.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/3.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "UILabel+exsicte.h"

@implementation UILabel (exsicte)

+(UILabel *)creatLabelFrame:(CGRect)frame backgroundColor:(UIColor *)color text:(NSString *)str textAlignment:(NSTextAlignment)aliginment font:(UIFont *)font textColor:(UIColor *)textcolor
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.backgroundColor = color;
    label.text = str;
    label.textAlignment =(aliginment);
    label.font = font;
    label.textColor = textcolor;
    return label;
}
//创建label
+ (UILabel*)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textcolor font:(UIFont *)font  numberOfLines:(int)numberOfLines adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth{
    
    UILabel*lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = color;
    lable.text = str;
    lable.textColor =textcolor;
    lable.font = font;
    lable.numberOfLines = numberOfLines;
    lable.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    
    return lable;
    
}


@end
