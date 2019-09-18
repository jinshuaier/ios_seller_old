//
//  TCAddCategoryViewController.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/26.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAddCategoryViewController : UIViewController
@property (nonatomic, assign) BOOL isChange; //判断是否为修改
@property (nonatomic, strong) NSString *goodscateid; //修改传过来的
@property (nonatomic, strong) NSString *nameStr; //修改传过来的
@property (nonatomic, strong) NSString *sortStr; //修改传过来的
@property (nonatomic, assign) BOOL isAddGoods; //是否是从添加商品来的

@end
