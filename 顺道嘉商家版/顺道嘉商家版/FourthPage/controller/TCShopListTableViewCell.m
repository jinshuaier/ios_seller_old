//
//  TCShopListTableViewCell.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/3/2.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopListTableViewCell.h"

@implementation TCShopListTableViewCell

- (id)initTableviewCell:(NSString *)bianhao andHeadim:(NSString *)headim andShopname:(NSString *)shopname andAddress:(NSString *)address anddianz:(NSString *)dianz andbounStatus:(NSString *)bounStatus andRcode:(NSString *)code andmesinfo:(NSDictionary *)mesinfo{
    self = [super init];
    self.clipsToBounds = YES;
    self.contentView.backgroundColor = RGB(245, 245, 245);

    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WIDHT - 20, 300)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.layer.cornerRadius = 8;
    backview.layer.masksToBounds = YES;
    [self.contentView addSubview: backview];
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT - 20, 98)];
    topview.backgroundColor = TCUIColorFromRGB(0xe5e8ea);
    [backview addSubview: topview];
    
    //头像
    _headim = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 56, 56)];
    _headim.layer.cornerRadius = 4;
    _headim.layer.masksToBounds = YES;
    [_headim sd_setImageWithURL:[NSURL URLWithString:headim] placeholderImage:[UIImage imageNamed:@"系统默认照片.png"]];
    [topview addSubview: _headim];
    
    UIImageView *tipIm = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    tipIm.image = [UIImage imageNamed:@"shoplist角标图标.png"];
    [topview addSubview: tipIm];
    _bianhao = [[UILabel alloc]initWithFrame:CGRectMake(-12, 8, 50, 10)];
    _bianhao.text = @"001";
    _bianhao.textColor = [UIColor whiteColor];
    _bianhao.font = [UIFont systemFontOfSize:12];
    _bianhao.textAlignment = NSTextAlignmentCenter;
    _bianhao.transform = CGAffineTransformRotate(_bianhao.transform, (7 * M_PI) / 4);
    [topview addSubview: _bianhao];
    
    //店名
    _shopname = [[UILabel alloc]init];
    _shopname.numberOfLines = 2;
    _shopname.text = shopname;
    _shopname.font = [UIFont boldSystemFontOfSize:15];
    _shopname.textAlignment = NSTextAlignmentLeft;
    CGSize szie = [_shopname sizeThatFits:CGSizeMake(WIDHT - 12 - _headim.frame.origin.x - _headim.frame.size.width - 8, _headim.frame.size.height)];
    _shopname.frame = CGRectMake(_headim.frame.size.width + _headim.frame.origin.x + 8, _headim.frame.origin.y, szie.width, szie.height);
    _shopname.textColor = TCUIColorFromRGB(0x525f66);
    [topview addSubview: _shopname];
    
    //店长
    UILabel *dianzs = [[UILabel alloc]initWithFrame:CGRectMake(_shopname.frame.origin.x, _shopname.frame.origin.y + _shopname.frame.size.height + 4, 40, 21)];
    dianzs.font = [UIFont boldSystemFontOfSize:15];
    dianzs.text = @"店长:";
    dianzs.textColor = TCUIColorFromRGB(0x525f66);
    [topview addSubview: dianzs];
    _dianzhang = [[UILabel alloc]initWithFrame:CGRectMake(dianzs.frame.origin.x + dianzs.frame.size.width + 5, dianzs.frame.origin.y, WIDHT - dianzs.frame.origin.x - dianzs.frame.size.width - 5 - 10, 21)];
    _dianzhang.font = [UIFont boldSystemFontOfSize:15];
    _dianzhang.textColor = TCUIColorFromRGB(0x525f66);
    if ([dianz isEqualToString:@""]) {
        _dianzhang.text = @"暂无";
    }else{
        _dianzhang.text = dianz;
    }
    [topview addSubview: _dianzhang];
    
    //端
    _duanlb = [[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width - 12 - 20, topview.frame.size.height - 13 - 15, 20, 15)];
    _duanlb.text = @"端";
    _duanlb.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
    _duanlb.font = [UIFont systemFontOfSize:10];
    _duanlb.textColor = TCUIColorFromRGB(0xffffff);
    _duanlb.textAlignment = NSTextAlignmentCenter;
    _duanlb.layer.cornerRadius = 2;
    _duanlb.layer.masksToBounds = YES;
    [topview addSubview: _duanlb];
    _duanline = [[UILabel alloc]initWithFrame:CGRectMake(_duanlb.frame.origin.x + 3.5, _duanlb.frame.origin.y + _duanlb.frame.size.height + 2, 13, 3)];
    _duanline.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
    _duanline.layer.cornerRadius = 1;
    _duanline.layer.masksToBounds = YES;
    [topview addSubview: _duanline];
    
    //保
//    _baolb = [[UILabel alloc]initWithFrame:CGRectMake(_duanlb.frame.origin.x - 12 - 20, topview.frame.size.height - 13 - 15, 20, 15)];
//    _baolb.text = @"保";
//    _baolb.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
//    _baolb.font = [UIFont systemFontOfSize:10];
//    _baolb.textColor = TCUIColorFromRGB(0xffffff);
//    _baolb.textAlignment = NSTextAlignmentCenter;
//    _baolb.layer.cornerRadius = 2;
//    _baolb.layer.masksToBounds = YES;
//    [topview addSubview: _baolb];
//    _baoline = [[UILabel alloc]initWithFrame:CGRectMake(_baolb.frame.origin.x + 3.5, _baolb.frame.origin.y + _baolb.frame.size.height + 2, 13, 3)];
//    _baoline.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
//    _baoline.layer.cornerRadius = 1;
//    _baoline.layer.masksToBounds = YES;
//    [topview addSubview: _baoline];
    
    //状态
    _shopStyle = [[UILabel alloc]initWithFrame:CGRectMake(_duanlb.frame.origin.x - 12 - 56, topview.frame.size.height - 8 - 22, 56, 22)];
    _shopStyle.backgroundColor = TCUIColorFromRGB(0x24A7F2);
    _shopStyle.text = @"正在营业";
    _shopStyle.font = [UIFont systemFontOfSize:10];
    _shopStyle.textAlignment = NSTextAlignmentCenter;
    _shopStyle.layer.cornerRadius = 2;
    _shopStyle.layer.masksToBounds = YES;
    _shopStyle.textColor = [UIColor whiteColor];
    [topview addSubview: _shopStyle];
    
    //线
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, topview.frame.origin.y + topview.frame.size.height, WIDHT, 1)];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [backview addSubview: line];
    
    //地址
    UILabel *dizhi = [[UILabel alloc]initWithFrame:CGRectMake(_headim.frame.origin.x, line.frame.origin.y + line.frame.size.height + 8, 76, 17)];
    dizhi.text = @"店铺地址:";
    dizhi.font = [UIFont systemFontOfSize:15];
    dizhi.textColor = TCUIColorFromRGB(0x333333);
    [backview addSubview: dizhi];
    
    _address = [[UILabel alloc]init];
    _address.numberOfLines = 0;
    _address.textAlignment = NSTextAlignmentLeft;
    _address.font = [UIFont systemFontOfSize:15];
    _address.text = address;
    _address.textColor = TCUIColorFromRGB(0x333333);
    CGSize newsize = [_address sizeThatFits:CGSizeMake(topview.frame.size.width - 12 - dizhi.frame.origin.x - dizhi.frame.size.width, 100)];
    _address.frame = CGRectMake(dizhi.frame.origin.x + dizhi.frame.size.width + 4, dizhi.frame.origin.y, newsize.width, newsize.height);
    [backview addSubview: _address];
    
    //服务人员编码
    _RCode = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width  / 2 - 232 / 2, _address.frame.origin.y + _address.frame.size.height + 26, 232, 33)];
    if ([code isEqualToString:@""]) {
        _RCode.frame = CGRectMake(backview.frame.size.width  / 2 - 232 / 2, _address.frame.origin.y + _address.frame.size.height + 26, 232, 33);
        _RCode.text = [NSString stringWithFormat:@"服务人员编码：%@", @"暂无"];
    }else{
        _RCode.frame = CGRectMake(backview.frame.size.width  / 2 - 232 / 2, _address.frame.origin.y + _address.frame.size.height + 26, 232, 33);
        _RCode.text = [NSString stringWithFormat:@"服务人员编码：%@", code];
    }
    _RCode.font = [UIFont boldSystemFontOfSize:15];
    _RCode.textColor = TCUIColorFromRGB(0x24a7f2);
    _RCode.backgroundColor = [TCUIColorFromRGB(0x24a7f2)colorWithAlphaComponent:0.1];
    _RCode.textAlignment = NSTextAlignmentCenter;
    _RCode.layer.cornerRadius = 33 / 2.0;
    _RCode.layer.masksToBounds = YES;
    [backview addSubview: _RCode];
    
    //充值保证金
    _baozhengjinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _baozhengjinBtn.frame = CGRectMake(backview.frame.size.width / 2 - 192 / 2.0, _RCode.frame.origin.y + _RCode.frame.size.height + 54, 192, 40);
    [backview addSubview: _baozhengjinBtn];
    backview.frame = CGRectMake(10, 0, WIDHT - 20, _baozhengjinBtn.frame.origin.y + _baozhengjinBtn.frame.size.height + 48);
    _height = backview.frame.size.height;
    

    //1正常营业  -1暂停营业 -2未审核  -3审核中
    if ([[NSString stringWithFormat:@"%@", mesinfo[@"status"]] intValue] == 1) {
        _shopStyle.text = @"正在营业";
        _shopStyle.backgroundColor = TCUIColorFromRGB(0x24A7F2);
    }else if ([[NSString stringWithFormat:@"%@", mesinfo[@"status"]] intValue] == -1){
        _shopStyle.text = @"暂停营业";
        _shopStyle.backgroundColor = TCUIColorFromRGB(0xD7B65C);
        
    }else if ([[NSString stringWithFormat:@"%@", mesinfo[@"status"]] intValue] == -2){
        _shopStyle.text = @"未审核";
        _shopStyle.backgroundColor = TCUIColorFromRGB(0x38C8DD);
        
    }else if ([[NSString stringWithFormat:@"%@", mesinfo[@"status"]] intValue] == -3){
        _shopStyle.text = @"审核中";
        _shopStyle.backgroundColor = TCUIColorFromRGB(0x7ACC29);
    }
    
    
    //0未交保证金  1已交3000 2交0元   3已交0~3000  4已交钱待审核   -1已申请退款
    //充值保证金0，2    查看保证金1，3，4，   退换-1
    if ([bounStatus isEqualToString:@"0"]) {//不亮
        //端状态
        _duanlb.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
        _duanline.backgroundColor = TCUIColorFromRGB(0xc4c4c4);
        //按钮状态
        [_baozhengjinBtn.layer addSublayer:[self addlayer: @[(__bridge id)TCUIColorFromRGB(0x1ac6ff).CGColor,  (__bridge id)TCUIColorFromRGB(0x24a7f2).CGColor]]];
        [_baozhengjinBtn setTitle:@"充值保证金" forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else if ([bounStatus isEqualToString:@"1"]){
        _duanlb.backgroundColor = TCUIColorFromRGB(0xffaa00);
        _duanline.backgroundColor = TCUIColorFromRGB(0xffaa00);
        //按钮状态
        [_baozhengjinBtn.layer addSublayer:[self addlayer: @[(__bridge id)TCUIColorFromRGB(0x00e893).CGColor,  (__bridge id)TCUIColorFromRGB(0x23d882).CGColor]]];
        [_baozhengjinBtn setTitle:@"查看保证金" forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else if ([bounStatus isEqualToString:@"2"]){
        _duanlb.backgroundColor = TCUIColorFromRGB(0xffaa00);
        _duanline.backgroundColor = TCUIColorFromRGB(0xffaa00);
        //按钮状态
        [_baozhengjinBtn.layer addSublayer:[self addlayer: @[(__bridge id)TCUIColorFromRGB(0x1ac6ff).CGColor,  (__bridge id)TCUIColorFromRGB(0x24a7f2).CGColor]]];
        [_baozhengjinBtn setTitle:@"充值保证金" forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else if ([bounStatus isEqualToString:@"3"]){
        _duanlb.backgroundColor = TCUIColorFromRGB(0xffaa00);
        _duanline.backgroundColor = TCUIColorFromRGB(0xffaa00);
        //按钮状态
        [_baozhengjinBtn.layer addSublayer:[self addlayer: @[(__bridge id)TCUIColorFromRGB(0x00e893).CGColor,  (__bridge id)TCUIColorFromRGB(0x23d882).CGColor]]];
        [_baozhengjinBtn setTitle:@"查看保证金" forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else if ([bounStatus isEqualToString:@"4"]){
        _duanlb.backgroundColor = TCUIColorFromRGB(0xffaa00);
        _duanline.backgroundColor = TCUIColorFromRGB(0xffaa00);
        //按钮状态
        [_baozhengjinBtn.layer addSublayer:[self addlayer: @[(__bridge id)TCUIColorFromRGB(0x00e893).CGColor,  (__bridge id)TCUIColorFromRGB(0x23d882).CGColor]]];
        [_baozhengjinBtn setTitle:@"查看保证金" forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }else if ([bounStatus isEqualToString:@"-1"]){
        _duanlb.backgroundColor = TCUIColorFromRGB(0xffaa00);
        _duanline.backgroundColor = TCUIColorFromRGB(0xffaa00);
        //按钮状态
        [_baozhengjinBtn setTitle:@"退还保证金中..." forState:UIControlStateNormal];
        [_baozhengjinBtn setTitleColor:TCUIColorFromRGB(0xff2850) forState:UIControlStateNormal];
        _baozhengjinBtn.backgroundColor = [UIColor whiteColor];
        _baozhengjinBtn.layer.cornerRadius = 20;
        _baozhengjinBtn.layer.borderWidth = 1;
        _baozhengjinBtn.layer.borderColor = TCUIColorFromRGB(0xff2850).CGColor;
        _baozhengjinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

//添加渐变色
- (CAGradientLayer *)addlayer:(NSArray *)colorArr{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colorArr;
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = _baozhengjinBtn.bounds;
    gradientLayer.shadowOpacity = 0.3;//阴影透明度
    gradientLayer.shadowColor = [UIColor grayColor].CGColor;//颜色
    gradientLayer.shadowRadius = 3;//扩散范围
    gradientLayer.shadowOffset = CGSizeMake(1, 2);//范围
    gradientLayer.cornerRadius = 20;
    return gradientLayer;
}



@end
