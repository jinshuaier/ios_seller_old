//
//  TCChooseAddressViewController.h
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/8.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCChooseAddressViewController : UIViewController
typedef void(^dizhiBlo)(NSString*address,NSString*locaddress,NSString*longtitude,NSString *latitude);
@property (nonatomic, copy) dizhiBlo diBlock;
@property (nonatomic, copy) AMapGeoPoint *maplocation;
@end
