//
//  KuaibaoCollectionViewCell.h
//  顺道嘉商家版
//
//  Created by GeYang on 2017/4/17.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGAdvertScrollView.h"

@protocol KuaiBaoDelegate <NSObject>

- (void)DidSelectedKuaiBao:(NSInteger)index;

@end

@interface KuaibaoCollectionViewCell : UICollectionViewCell

- (void)registerCell:(NSArray *)kuaibaoarr;

@property (nonatomic, weak) id <KuaiBaoDelegate> delegate;
@property (nonatomic, strong) NSArray *kuaibaoArr;
@end
