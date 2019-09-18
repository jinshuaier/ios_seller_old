//
//  TCChooseSlideView.h
//  顺道嘉商家版
//
//  Created by Macx on 16/8/30.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TCChooseSlideProtocol <NSObject>

@required
-(void)_getTag:(NSInteger)tag;

@end
@interface TCChooseSlideView : UIView
{
//获得当前的组名
NSArray *_chooseSliderArray;
}
@property (nonatomic, strong) UIView *selectedLine;
@property (nonatomic, strong) UIView *line;
//设置滑动名的方法
-(void)setNameWithArray:(NSArray *)chooseSliderArray;
//协议代理
@property(nonatomic,assign)id<TCChooseSlideProtocol>sliderDelegate;
@end
