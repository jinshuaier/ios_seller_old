//
//  TCshopManagerTableViewCell.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/10.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCshopManagerTableViewCell.h"

@implementation TCshopManagerTableViewCell

- (id)initTableviewCell:(NSString *)bianhao andHeadim:(NSString *)headim andShopname:(NSString *)shopname andAddress:(NSString *)address andisyingy:(NSString *)isyy andcontat:(NSString *)contact andstyle:(NSString *)style andps:(NSString *)peis andqisong:(NSString *)qis andisto:(NSString *)isto anddianz:(NSString *)dianz andphone:(NSString *)phone anddianyuan:(NSString *)dianyuan andbounStatus:(NSString *)bounStatus{
    self = [super init];
    //编号
    _bianhao = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDHT - 45, 30)];
    _bianhao.text = bianhao;
    _bianhao.numberOfLines = 0;
    _bianhao.textColor = backFontColor;
    _bianhao.font = [UIFont systemFontOfSize:15];
    _bianhao.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_bianhao];

    //编辑按钮
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 10 - 25, 10, 35, 40)];
    [_btn setImage:[UIImage imageNamed:@"修改信息按钮"] forState:UIControlStateNormal];
    [self addSubview: _btn];

    //线
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, _btn.frame.origin.y + _btn.frame.size.height + 2, WIDHT - 10, 1.5)];
    line.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    [self addSubview: line];

    //头像
    _headim = [[UIImageView alloc]initWithFrame:CGRectMake(10, line.frame.origin.y + 1.5 + 10, 60 * WIDHTSCALE, 60 * WIDHTSCALE)];
    _headim.layer.cornerRadius = 5;
    _headim.layer.masksToBounds = YES;
    [_headim sd_setImageWithURL:[NSURL URLWithString:headim] placeholderImage:[UIImage imageNamed:@"系统默认照片.png"]];
    [self addSubview: _headim];

    //店名
    _shopname = [[UILabel alloc]init];
    _shopname.numberOfLines = 2;
    _shopname.text = shopname;
    _shopname.font = [UIFont systemFontOfSize:20];
    _shopname.textAlignment = NSTextAlignmentLeft;
    CGSize szie = [_shopname sizeThatFits:CGSizeMake(WIDHT - 10 - 10 - _headim.frame.size.width - 32, _headim.frame.size.height)];
    _shopname.frame = CGRectMake(_headim.frame.size.width + 10 + 10, _headim.frame.origin.y, szie.width, szie.height);
    _shopname.textColor = backFontColor;
    [self addSubview: _shopname];
    
    //是否有保证金图标
    UIImageView *bzjIM = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 10 - 16, _shopname.frame.origin.y, 16, 17)];
    bzjIM.image = [UIImage imageNamed:@"liebiao保证金图标"];
    if (![bounStatus isEqualToString:@"0"]) {
        [self.contentView addSubview: bzjIM];
    }
    
    //是否营业图标
    _styleim = [[UILabel alloc]initWithFrame:CGRectMake(WIDHT - 10 - 80 * WIDHTSCALE, _shopname.frame.origin.y + _shopname.frame.size.height + 5, 80 * WIDHTSCALE, 25 * HEIGHTSCALE)];
    if ([isyy isEqualToString:@"1"]) {
        _styleim.text = @"正常营业";
    }else if ([isyy isEqualToString:@"-1"]){
        _styleim.text = @"暂停营业";
    }else if ([isyy isEqualToString:@"-2"]){
        _styleim.text = @"未审核";
    }else if ([isyy isEqualToString:@"-3"]){
        _styleim.text = @"审核中";
    }
    _styleim.layer.borderWidth = 1;
    _styleim.layer.borderColor = BtnTitleColor.CGColor;
    _styleim.textAlignment = NSTextAlignmentCenter;
    _styleim.layer.cornerRadius = 5 * HEIGHTSCALE;
    _styleim.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];
    [self addSubview: _styleim];

    //地址
    UILabel *dizhi = [[UILabel alloc]init];
    dizhi.text = @"地址:";
    dizhi.adjustsFontSizeToFitWidth = YES;
    dizhi.font = [UIFont systemFontOfSize:15];
    dizhi.textColor = SmallTitleColor;
    CGSize dizhisize = [dizhi sizeThatFits:CGSizeMake(40, 100)];
    dizhi.frame = CGRectMake(_shopname.frame.origin.x, _styleim.frame.origin.y + _styleim.frame.size.height + 12, dizhisize.width, dizhisize.height);
    [self addSubview: dizhi];
    _address = [[UILabel alloc]init];
    _address.numberOfLines = 0;
    _address.textAlignment = NSTextAlignmentLeft;
    _address.font = [UIFont systemFontOfSize:15];
    _address.text = address;
    _address.textColor = shopColor;
    CGSize newsize = [_address sizeThatFits:CGSizeMake(WIDHT - 10 - 5 - dizhi.frame.origin.x - dizhi.frame.size.width, 100)];
    _address.frame = CGRectMake(dizhi.frame.origin.x + dizhi.frame.size.width + 5, dizhi.frame.origin.y, newsize.width, newsize.height);
    [self addSubview: _address];

    //联系电话
    UILabel *lianxi = [[UILabel alloc]init];
    if ([_address.text isEqualToString:@""]) {
        lianxi.frame = CGRectMake(dizhi.frame.origin.x, dizhi.frame.size.height + dizhi.frame.origin.y + 12, 70, 20);
    }else{
        lianxi.frame = CGRectMake(dizhi.frame.origin.x, _address.frame.size.height + _address.frame.origin.y + 12, 70, 20);
    }
    lianxi.font = [UIFont systemFontOfSize:15];
    lianxi.text = @"联系电话:";
    lianxi.textColor = SmallTitleColor;
    [self addSubview: lianxi];
    _contact = [[UILabel alloc]initWithFrame:CGRectMake(lianxi.frame.origin.x + lianxi.frame.size.width + 5, lianxi.frame.origin.y, WIDHT - lianxi.frame.origin.x - lianxi.frame.size.width - 5 - 10, lianxi.frame.size.height)];
    _contact.font = [UIFont systemFontOfSize:15];
    _contact.text = contact;;
    _contact.textColor = shopColor;
    [self addSubview: _contact];

    //店铺类型
    UILabel *dianpu = [[UILabel alloc]initWithFrame:CGRectMake(lianxi.frame.origin.x, lianxi.frame.origin.y + lianxi.frame.size.height + 12, 70, 20)];
    dianpu.font = [UIFont systemFontOfSize:15];
    dianpu.text = @"店铺类型:";
    dianpu.textColor = SmallTitleColor;
    [self addSubview: dianpu];
    _style = [[UILabel alloc]initWithFrame:CGRectMake(dianpu.frame.size.width + dianpu.frame.origin.x + 5, dianpu.frame.origin.y, _contact.frame.size.width, dianpu.frame.size.height)];
    _style.font = [UIFont systemFontOfSize:15];
    _style.text = style;
    _style.textColor = shopColor;
    [self addSubview: _style];

    //配送费
    UILabel *peisong = [[UILabel alloc]initWithFrame:CGRectMake(dianpu.frame.origin.x, dianpu.frame.size.height + dianpu.frame.origin.y + 12, 65, 20)];
    peisong.font = [UIFont systemFontOfSize:15];
    peisong.textColor = SmallTitleColor;
    peisong.text = @"配送费:";
    [self addSubview: peisong];
    _peisongfei = [[UILabel alloc]initWithFrame:CGRectMake(peisong.frame.size.width + peisong.frame.origin.x + 5, peisong.frame.origin.y, WIDHT - 10 - peisong.frame.size.width - peisong.frame.origin.x - 5, 20)];
    _peisongfei.textColor = RedColor;
    _peisongfei.font = [UIFont systemFontOfSize:15];
    _peisongfei.textColor = [UIColor redColor];
    _peisongfei.text = [NSString stringWithFormat:@"¥%@", peis];
    [self addSubview: _peisongfei];

    //起送价
    UILabel *qisong = [[UILabel alloc]initWithFrame:CGRectMake(peisong.frame.origin.x, peisong.frame.size.height + peisong.frame.origin.y + 12, 65, 20)];
    qisong.font = [UIFont systemFontOfSize:15];
    qisong.text = @"起送价:";
    qisong.textColor = SmallTitleColor;
    [self addSubview: qisong];
    _qisongjia = [[UILabel alloc]initWithFrame:CGRectMake(qisong.frame.size.width + qisong.frame.origin.x + 5, qisong.frame.origin.y, WIDHT - 10 - qisong.frame.size.width - qisong.frame.origin.x - 5, 20)];
    _qisongjia.textColor = RedColor;
    _qisongjia.font = [UIFont systemFontOfSize:15];
    _qisongjia.textColor = [UIColor redColor];
    _qisongjia.text = [NSString stringWithFormat:@"¥%@", qis];
    [self addSubview: _qisongjia];

    //是否同步
    _isto = [[UILabel alloc]initWithFrame:CGRectMake(qisong.frame.origin.x, qisong.frame.origin.y + qisong.frame.size.height + 12, WIDHT - 10 - qisong.frame.origin.x, 20)];
    _isto.font = [UIFont systemFontOfSize:15];
    _isto.textColor = [UIColor colorWithRed:0 green:204/255.0 blue:204/255.0 alpha:1.0];
    if ([isto isEqualToString:@"1"]) {
        _isto.text = @"已同步默认商品";
    }else{
        _isto.text = @"未同步默认商品";
    }
    _isto.textColor = btnColors;
    [self addSubview: _isto];

    //店长
    UILabel *dianzs = [[UILabel alloc]initWithFrame:CGRectMake(_isto.frame.origin.x, _isto.frame.origin.y + _isto.frame.size.height + 12, 35, 20)];
    dianzs.font = [UIFont systemFontOfSize:15];
    dianzs.text = @"店长:";
    dianzs.textColor = backFontColor;
    [self addSubview: dianzs];
    _dianzhang = [[UILabel alloc]initWithFrame:CGRectMake(dianzs.frame.origin.x + dianzs.frame.size.width + 5, dianzs.frame.origin.y, WIDHT - dianzs.frame.origin.x - dianzs.frame.size.width - 5 - 10, 20)];
    _dianzhang.font = [UIFont systemFontOfSize:15];
    _dianzhang.textColor = backFontColor;
    if ([dianz isEqualToString:@""]) {
        _dianzhang.text = @"暂无";
    }else{
        _dianzhang.text = dianz;
    }
    [self addSubview: _dianzhang];

    //电话
    UILabel *dianhu = [[UILabel alloc]initWithFrame:CGRectMake(dianzs.frame.origin.x, dianzs.frame.origin.y + dianzs.frame.size.height + 12, 35, 20)];
    dianhu.font = [UIFont systemFontOfSize:15];
    dianhu.text = @"电话:";
    dianhu.textColor = SmallTitleColor;
    [self addSubview: dianhu];
    _dianhua = [[UILabel alloc]initWithFrame:CGRectMake(dianhu.frame.origin.x + dianhu.frame.size.width + 5, dianhu.frame.origin.y, WIDHT - dianhu.frame.origin.x - dianhu.frame.size.width - 5 - 10, 20)];
    _dianhua.textColor = shopColor;
    _dianhua.font = [UIFont systemFontOfSize:15];
    if ([contact isEqualToString:@""]) {
        _dianhua.text = @"暂无";
    }else{
        _dianhua.text = contact;
    }
    [self addSubview: _dianhua];

    //店员
    UILabel *dinayuan = [[UILabel alloc]init];
    dinayuan.text = @"店员:";
    dinayuan.adjustsFontSizeToFitWidth = YES;
    dinayuan.font = [UIFont systemFontOfSize:15];
    dinayuan.textColor = SmallTitleColor;
    CGSize dizhisizes = [dizhi sizeThatFits:CGSizeMake(40, 100)];
    dinayuan.frame = CGRectMake(dianhu.frame.origin.x, dianhu.frame.origin.y + dianhu.frame.size.height + 12, dizhisizes.width, dizhisizes.height);
    [self addSubview: dinayuan];
    _dianyuan = [[UILabel alloc]init];
    _dianyuan.numberOfLines = 0;
    _dianyuan.textAlignment = NSTextAlignmentLeft;
    _dianyuan.font = [UIFont systemFontOfSize:15];
    _dianyuan.text = dianyuan;
    _dianyuan.textColor = shopColor;
    CGSize newsizes = [_dianyuan sizeThatFits:CGSizeMake(WIDHT - 10 - 5 - dinayuan.frame.origin.x - dinayuan.frame.size.width, 300)];
    _dianyuan.frame = CGRectMake(dinayuan.frame.origin.x + dinayuan.frame.size.width + 5, dinayuan.frame.origin.y, newsizes.width, newsizes.height);
    [self addSubview: _dianyuan];

    _height = _dianyuan.frame.origin.y + _dianyuan.frame.size.height + 20;
    return self;
}



@end
