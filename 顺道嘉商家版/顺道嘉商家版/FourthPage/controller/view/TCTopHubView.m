//
//  TCTopHubView.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/6/14.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTopHubView.h"


@implementation TCTopHubView

- (id)init{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)ShowHubWithTitle:(NSString *)title andColor:(UIColor *)color{
    [_showview removeFromSuperview];
    [_showview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _showview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 300)];
    _showview.backgroundColor = color;
    [self addSubview: _showview];
    
    //title
    UILabel *mestitle = [[UILabel alloc]init];
    mestitle.text = title;
    mestitle.font = [UIFont systemFontOfSize:14];
    mestitle.textColor = [UIColor whiteColor];
    mestitle.numberOfLines = 0;
    CGSize size = [mestitle sizeThatFits: CGSizeMake(WIDHT - 24, MAXFLOAT)];
    mestitle.frame = CGRectMake(12, 16, size.width, size.height);
    [_showview addSubview: mestitle];
    _showview.frame = CGRectMake(0, 0, WIDHT, 0);

    
//    [UIView animateWithDuration:0.3 animations:^{
//        _showview.frame = CGRectMake(0, 0, WIDHT, mestitle.frame.origin.y + mestitle.frame.size.height + 16);
//    }];
    
    mestitle.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _showview.frame = CGRectMake(0, 0, WIDHT, mestitle.frame.origin.y + mestitle.frame.size.height + 16);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            mestitle.alpha = 1.0;
        }];
    }];
}


    












@end
