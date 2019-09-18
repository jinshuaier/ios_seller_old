//
//  TCLastCollectionViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLastCollectionViewCell.h"

@implementation TCLastCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RGB(242, 242, 242);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versionlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDHT,  15 * HEIGHTSCALE)];
    _versionlb.textColor = RGB(153, 153, 153);
    _versionlb.text = [NSString stringWithFormat:@"版本:V%@", appCurVersion];
    _versionlb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview: _versionlb];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT / 2 - 100 * WIDHTSCALE, _versionlb.frame.size.height + 12 * HEIGHTSCALE, 200 * WIDHTSCALE, 44 * HEIGHTSCALE)];
    _title.backgroundColor = [UIColor whiteColor];
    _title.textColor = [UIColor redColor];
    _title.font = [UIFont systemFontOfSize:18 * HEIGHTSCALE];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.layer.cornerRadius = 22 * HEIGHTSCALE;
    _title.layer.masksToBounds = YES;
    _title.text = @"退出登录";
    [self addSubview: _title];
}

@end
