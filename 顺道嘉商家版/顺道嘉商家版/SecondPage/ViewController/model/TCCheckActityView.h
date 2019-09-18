//
//  TCCheckActityView.h
//  顺道嘉商家版
// 
//  Created by 胡高广 on 2017/5/24.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCCheckActityView : UIView

-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)title andMessage:(NSString *)message;
-(instancetype)initWithFrame:(CGRect)frame andmessage:(NSString *)message;

-(instancetype)initWithFrame:(CGRect)frame andTtiles:(NSString *)titles andMessages:(NSString *)messages; //保证金
@property (nonatomic, strong) NSString *contentActity; //活动


@end
