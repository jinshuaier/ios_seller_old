//
//  TCDeleCateListView.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton * sender);
// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数 //下一步就是声明属性了，注意block的声明属性修饰要用copy

@interface TCDeleCateListView : UIView
-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)title;
@property (nonatomic,copy) ButtonClick buttonAction;
@end
