//
//  KuaibaoCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/4/17.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "KuaibaoCollectionViewCell.h"
#import "SGAdvertScrollView.h"

@interface KuaibaoCollectionViewCell()<SGAdvertScrollViewDelegate>

@end

@implementation KuaibaoCollectionViewCell

- (void)registerCell:(NSArray *)kuaibaoarr{
    self.backgroundColor = [UIColor redColor];
//    SGAdvertScrollView *advertScrollView2 = [[SGAdvertScrollView alloc]init];
//    advertScrollView2.userInteractionEnabled = YES;
//    advertScrollView2.backgroundColor = [UIColor blackColor];
//    advertScrollView2.advertScrollViewDelegate = self;
//    advertScrollView2.frame = CGRectMake(0, 0, WIDHT, 54);
//    advertScrollView2.image = [UIImage imageNamed:@"顺道嘉快报图标.png"];
//    advertScrollView2.titleArray = _kuaibaoArr;
//    [self addSubview:advertScrollView2];
}

- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(DidSelectedKuaiBao:)]) {
        [self.delegate DidSelectedKuaiBao:index];
    }
}









@end
