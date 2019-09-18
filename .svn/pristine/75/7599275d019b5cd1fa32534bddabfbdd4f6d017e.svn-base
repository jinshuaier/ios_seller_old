//
//  TCSelectClassifyView.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/6.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCSelectClassifyProtocol <NSObject>

@required
-(void)_getTag:(NSInteger)tag;

@end
@interface TCSelectClassifyView : UIView
{
    //获得当前的组名
    NSArray *_chooseSliderArray;
}
@property (nonatomic, strong) UIView *selectedLine;
//设置滑动名的方法
-(void)setNameWithArray:(NSArray *)chooseSliderArray;
//协议代理
@property(nonatomic,assign)id<TCSelectClassifyProtocol>sliderDelegate;
@end
