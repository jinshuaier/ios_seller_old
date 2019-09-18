//
//  TCshopManagerTableViewCell.h
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCshopManagerTableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *bianhao;
@property (strong, nonatomic)  UIImageView *headim;
@property (strong, nonatomic)  UILabel *shopname;
@property (strong, nonatomic)  UILabel *styleim;
@property (strong, nonatomic)  UILabel *address;
@property (strong, nonatomic)  UILabel *contact;
@property (strong, nonatomic)  UILabel *style;
@property (strong, nonatomic)  UILabel *peisongfei;
@property (strong, nonatomic)  UILabel *qisongjia;
@property (strong, nonatomic)  UILabel *isto;
@property (strong, nonatomic)  UILabel *dianzhang;
@property (strong, nonatomic)  UILabel *dianhua;
@property (strong, nonatomic)  UILabel *dianyuan;
@property (strong, nonatomic)  UIButton *btn;
@property (nonatomic, assign) NSInteger height;//返回cell的高度

- (id)initTableviewCell:(NSString *)bianhao andHeadim:(NSString *)headim andShopname:(NSString *)shopname andAddress:(NSString *)address andisyingy:(NSString *)isyy andcontat:(NSString *)contact andstyle:(NSString *)style andps:(NSString *)peis andqisong:(NSString *)qis andisto:(NSString *)isto anddianz:(NSString *)dianz andphone:(NSString *)phone anddianyuan:(NSString *)dianyuan andbounStatus:(NSString *)bounStatus;

@end
