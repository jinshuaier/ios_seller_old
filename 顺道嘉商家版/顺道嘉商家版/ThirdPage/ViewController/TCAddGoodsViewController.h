//
//  TCAddGoodsViewController.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCShopGoodsModel.h"

@interface TCAddGoodsViewController : UIViewController
@property (nonatomic, strong) NSString *codeStr; //传的值
@property (nonatomic, assign) BOOL isQr; //是否是二维码进来的
@property (nonatomic, assign) BOOL isSearch;//是否是搜索进来的
@property (nonatomic, strong) NSDictionary *QrDic; //二维码的字典
@property (nonatomic, strong) TCShopGoodsModel *selemodel;//选中商品传进来的model
@property (nonatomic, strong) NSString *showQRstr;
@property (nonatomic, strong) NSString *typeStr; //传过来的状态

@property (nonatomic, strong) NSMutableDictionary *seleDic;//选中商品传过来的字典
@property (nonatomic, strong) NSMutableArray *goodsImageArr; //商品图片

@end
