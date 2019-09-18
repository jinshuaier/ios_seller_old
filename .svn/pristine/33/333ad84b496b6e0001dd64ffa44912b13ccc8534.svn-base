//
//  TCChooseSlideView.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChooseSlideView.h"

@implementation TCChooseSlideView
-(void)setNameWithArray:(NSArray *)chooseSliderArray{
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    _chooseSliderArray = chooseSliderArray;
    
    //间隔
    CGFloat SPACE = (self.frame.size.width)/[_chooseSliderArray count];
    for(int i = 0;i<[chooseSliderArray count];i++){
        NSLog(@"111:%@",[chooseSliderArray objectAtIndex:i]);
        UIButton *sliderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        sliderBtn.frame = CGRectMake(SPACE*i, 0, SPACE, self.frame.size.height);
        sliderBtn.tag = i;
        if (sliderBtn.tag == 0) {
            //设置默认被选中按钮
            sliderBtn.selected = YES;
        }
        [sliderBtn setTitle:chooseSliderArray[i] forState:(UIControlStateNormal)];
        //按钮在正常状态下为灰色
        [sliderBtn setTitleColor:[TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.8] forState:(UIControlStateNormal)];
        //按钮按钮被选中状态为蓝色
        sliderBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [sliderBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateSelected)];
        //按钮的点击事件
        [sliderBtn addTarget:self action:@selector(sliderBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:sliderBtn];
        
        //划线
        if (i > 0){
            self.line = [[UIView alloc]initWithFrame:CGRectMake(SPACE * i ,(self.frame.size.height-11)/2,1, 11)];
            self.line.backgroundColor = [UIColor whiteColor];
            [self addSubview:self.line];
            
        }
    }
    
    //标识当被选中的下划线
    _selectedLine = [[UIView alloc]initWithFrame:CGRectMake((SPACE - 20)/2, self.frame.size.height - 6, 20, 4)];
    _selectedLine.tag = 1000;
    _selectedLine.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self addSubview:_selectedLine];
}
#pragma mark -- 滑动按钮的点击事件
-(void)sliderBtn:(UIButton *)sender{
    for(UIView *subView in self.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            UIButton *subBtn = (UIButton *)subView;
            if(subBtn.tag == sender.tag){
                subBtn.selected = YES;
                sender.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            }else{
                subBtn.selected = NO;
            }
        }
    }
    //计算每个按钮的间隔
    CGFloat SPACE = (self.frame.size.width)/[_chooseSliderArray count];
    UIView *selectedView = [self viewWithTag:1000];
    [UIView animateWithDuration:0.2f animations:^{
        CGRect selectedFrame = selectedView.frame;
        selectedFrame.origin.x = sender.tag *SPACE + (SPACE - 20)/2;
        selectedView.frame = selectedFrame;
    }];
    if([self.sliderDelegate respondsToSelector:@selector(_getTag:)]){
        [self.sliderDelegate _getTag:sender.tag];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


