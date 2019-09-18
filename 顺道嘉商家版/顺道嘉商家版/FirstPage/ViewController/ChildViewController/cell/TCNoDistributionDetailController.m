//
//  TCNoDistributionDetailController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/4.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNoDistributionDetailController.h"
#import "TCorderLTableViewCell.h"
@interface TCNoDistributionDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic, strong) UIView *ziquView;//门店自取view
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UILabel *ziqulb;//自选订单等。。。
@property (nonatomic, strong) UILabel *getTimelb;//送达时间
@property (nonatomic, strong) UILabel *nameLb;//姓名
@property (nonatomic, strong) UILabel *addressLb;//地址
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UILabel *shangpinje;//商品金额
@property (nonatomic, strong) UILabel *youhuijine;//优惠金额
@property (nonatomic, strong) UILabel *peisongfei;//配送费
@property (nonatomic, strong) UILabel *orderjine;//订单金额
@property (nonatomic, strong) UITextView *beizhuTV;//备注
@property (nonatomic, strong) UILabel *ordernum;//订单编号
@property (nonatomic, strong) UILabel *xiadantime;//下单时间
@property (nonatomic, strong) UILabel *zhifufangshi;//支付方式
@property (nonatomic, strong) UILabel *wanchengshijian;//完成时间
@property (nonatomic, strong) UIButton *leftBtn;//底部左侧按钮
@property (nonatomic, strong) UIButton *rightBtn;//底部右侧按钮
@property (nonatomic, strong) UIButton *bigBtn;//底部大按钮

@end

@implementation TCNoDistributionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"未配送";
    //把导航栏的左边箭头后面的字体去掉
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    //导航栏的左边箭头为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _lineColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    [self setFrame];
}

- (void)setFrame{
    _mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _mainScrollview.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    [self.view addSubview: _mainScrollview];
    //    _isZq = YES;
    //送货信息
    if (_isZq) {
        //门店自取
        _ziquView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, WIDHT, 100 * HEIGHTSCALE)];
        _ziquView.backgroundColor = [UIColor whiteColor];
        [_mainScrollview addSubview: _ziquView];
        //顶部线
        UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 4)];
        line1.backgroundColor = Color;
        [_ziquView addSubview: line1];
        UILabel *logoLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 76 * WIDHTSCALE, 32 * HEIGHTSCALE)];
        logoLb.backgroundColor = Color;
        logoLb.text = @"送货信息";
        logoLb.textColor = [UIColor whiteColor];
        logoLb.font = [UIFont systemFontOfSize:15];
        logoLb.textAlignment = NSTextAlignmentCenter;
        [_ziquView addSubview: logoLb];
        //line2
        UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, logoLb.frame.size.height + logoLb.frame.origin.y - 1.5, WIDHT, 1.5)];
        line2.backgroundColor = _lineColor;
        [_ziquView addSubview: line2];
        
        CGFloat h = _ziquView.frame.size.height - line2.frame.origin.y - line2.frame.size.height;
        UILabel *styleLb = [[UILabel alloc]initWithFrame:CGRectMake(logoLb.frame.origin.x, line2.frame.origin.y + line2.frame.size.height, logoLb.frame.size.width, h)];
        styleLb.text = @"送达方式:";
        styleLb.font = [UIFont systemFontOfSize:15];
        styleLb.textAlignment = NSTextAlignmentCenter;
        [_ziquView addSubview: styleLb];
        
        UILabel *ziqulb = [[UILabel alloc]initWithFrame:CGRectMake(styleLb.frame.size.width + styleLb.frame.origin.x, styleLb.frame.origin.y, WIDHT - styleLb.frame.origin.x - styleLb.frame.size.width - 160 * WIDHTSCALE, styleLb.frame.size.height)];
        ziqulb.textAlignment = NSTextAlignmentCenter;
        ziqulb.textColor = [UIColor colorWithRed:234 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1];
        ziqulb.font = [UIFont systemFontOfSize:16];
        ziqulb.text = @"门店自取";
        [_ziquView addSubview: ziqulb];
        
        UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(ziqulb.frame.origin.x + ziqulb.frame.size.width, ziqulb.frame.origin.y, 1.5, ziqulb.frame.size.height)];
        line3.backgroundColor = _lineColor;
        [_ziquView addSubview: line3];
        
        UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(line3.frame.size.width + line3.frame.origin.x, line3.frame.origin.y, 78.5 * WIDHTSCALE, line3.frame.size.height)];
        [messageBtn setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
        //    messageBtn.backgroundColor = [UIColor redColor];
        messageBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [messageBtn setTitle:@"发送消息" forState:UIControlStateNormal];
        [messageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(5 * HEIGHTSCALE, 25 * WIDHTSCALE, 30 * HEIGHTSCALE, 10 * WIDHTSCALE)];
        [messageBtn setTitleEdgeInsets:UIEdgeInsetsMake(35 * HEIGHTSCALE, -25 * WIDHTSCALE, 0, 0)];
        [_ziquView addSubview: messageBtn];
        
        UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(messageBtn.frame.size.width + messageBtn.frame.origin.x, messageBtn.frame.origin.y, 1.5, messageBtn.frame.size.height)];
        line4.backgroundColor = _lineColor;
        [_ziquView addSubview: line4];
        
        UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(line4.frame.size.width + line4.frame.origin.x, line4.frame.origin.y, 78.5 * WIDHTSCALE, line4.frame.size.height)];
        [phoneBtn setImage:[UIImage imageNamed:@"phones.png"] forState:UIControlStateNormal];
        //    phoneBtn.backgroundColor = [UIColor redColor];
        phoneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [phoneBtn setTitle:@"打电话" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(5 * HEIGHTSCALE, 25 * WIDHTSCALE, 30 * HEIGHTSCALE, 10 * WIDHTSCALE)];
        [phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(35 * HEIGHTSCALE, -25 * WIDHTSCALE, 0, 0)];
        [_ziquView addSubview: phoneBtn];
    }else{
        //其他类别
        _ziquView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, WIDHT, 200 * HEIGHTSCALE)];
        _ziquView.backgroundColor = [UIColor whiteColor];
        [_mainScrollview addSubview: _ziquView];
        //顶部线
        UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 4)];
        line1.backgroundColor = Color;
        [_ziquView addSubview: line1];
        UILabel *logoLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 76 * WIDHTSCALE, 32 * HEIGHTSCALE)];
        logoLb.backgroundColor = Color;
        logoLb.text = @"送货信息";
        logoLb.textColor = [UIColor whiteColor];
        logoLb.font = [UIFont systemFontOfSize:15];
        logoLb.textAlignment = NSTextAlignmentCenter;
        [_ziquView addSubview: logoLb];
        //line2
        UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, logoLb.frame.size.height + logoLb.frame.origin.y - 1.5, WIDHT, 1.5)];
        line2.backgroundColor = _lineColor;
        [_ziquView addSubview: line2];
        
        UILabel *styleLb = [[UILabel alloc]initWithFrame:CGRectMake(logoLb.frame.origin.x, line2.frame.origin.y + line2.frame.size.height, logoLb.frame.size.width, 48 * HEIGHTSCALE)];
        styleLb.text = @"送达方式:";
        styleLb.font = [UIFont systemFontOfSize:15];
        styleLb.textAlignment = NSTextAlignmentCenter;
        [_ziquView addSubview: styleLb];
        
        _ziqulb = [[UILabel alloc]initWithFrame:CGRectMake(styleLb.frame.size.width + styleLb.frame.origin.x, styleLb.frame.origin.y, WIDHT - styleLb.frame.origin.x - styleLb.frame.size.width - 160 * WIDHTSCALE, styleLb.frame.size.height)];
        _ziqulb.textAlignment = NSTextAlignmentCenter;
        _ziqulb.textColor = [UIColor colorWithRed:234 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1];
        _ziqulb.font = [UIFont systemFontOfSize:16];
        _ziqulb.text = @"预定订单";
        [_ziquView addSubview: _ziqulb];
        
        //送达时间
        _getTimelb = [[UILabel alloc]initWithFrame:CGRectMake(_ziqulb.frame.size.width + _ziqulb.frame.origin.x, _ziqulb.frame.origin.y, WIDHT - _ziqulb.frame.size.width - _ziqulb.frame.origin.x - 10, _ziqulb.frame.size.height)];
        _getTimelb.text = @"16:00前送达";
        _getTimelb.textAlignment = NSTextAlignmentRight;
        _getTimelb.font = [UIFont systemFontOfSize:17];
        [_ziquView addSubview: _getTimelb];
        
        
        UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _ziqulb.frame.origin.y + _ziqulb.frame.size.height, WIDHT, 1.5)];
        line3.backgroundColor = _lineColor;
        [_ziquView addSubview: line3];
        
        
        CGFloat h = (_ziquView.frame.size.height - line3.frame.origin.y - line3.frame.size.height) / 2;
        CGFloat w = WIDHT - 104 * WIDHTSCALE - 1.5;
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(styleLb.frame.origin.x, line3.frame.origin.y + line3.frame.size.height, w, h)];
        _nameLb.text = @"张先生  188888888888";
        _nameLb.font = [UIFont systemFontOfSize:15];
        [_ziquView addSubview: _nameLb];
        
        _addressLb = [[UILabel alloc]initWithFrame:CGRectMake(_nameLb.frame.origin.x, _nameLb.frame.origin.y + _nameLb.frame.size.height, _nameLb.frame.size.width, _nameLb.frame.size.height)];
        _addressLb.text = @"北京市通州区金融街园中园5号院56号楼二楼";
        _addressLb.numberOfLines = 0;
        _addressLb.font = [UIFont systemFontOfSize:15];
        [_ziquView addSubview: _addressLb];
        
        UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(_addressLb.frame.origin.x + _addressLb.frame.size.width, _nameLb.frame.origin.y, 1.5, h * 2)];
        line4.backgroundColor = _lineColor;
        [_ziquView addSubview: line4];
        
        //发消息
        CGFloat newh = (_ziquView.frame.size.height - line3.frame.origin.y - line3.frame.size.height - 1.5) / 2;
        UIButton *messBtn = [[UIButton alloc]initWithFrame:CGRectMake(line4.frame.origin.x + line4.frame.size.width, _nameLb.frame.origin.y, WIDHT - w - 1.5, newh)];
        //        messBtn.backgroundColor = [UIColor redColor];
        [messBtn setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
        messBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [messBtn setTitle:@"发送消息" forState:UIControlStateNormal];
        [messBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [messBtn setImageEdgeInsets:UIEdgeInsetsMake(0 * HEIGHTSCALE, 29 * WIDHTSCALE, 20 * HEIGHTSCALE, 15 * WIDHTSCALE)];
        [messBtn setTitleEdgeInsets:UIEdgeInsetsMake(30 * HEIGHTSCALE, -30 * WIDHTSCALE, 0, 0)];
        [_ziquView addSubview: messBtn];
        
        UIImageView *line5 = [[UIImageView alloc]initWithFrame:CGRectMake(line4.frame.origin.x + line4.frame.size.width, messBtn.frame.origin.y + messBtn.frame.size.height, messBtn.frame.size.width, 1.5)];
        line5.backgroundColor = _lineColor;
        [_ziquView addSubview: line5];
        
        UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(messBtn.frame.origin.x, line5.frame.origin.y + line5.frame.size.height, messBtn.frame.size.width, messBtn.frame.size.height)];
        [phoneBtn setImage:[UIImage imageNamed:@"phones.png"] forState:UIControlStateNormal];
        //    phoneBtn.backgroundColor = [UIColor redColor];
        phoneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [phoneBtn setTitle:@"打电话" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0 * HEIGHTSCALE, 29 * WIDHTSCALE, 20 * HEIGHTSCALE, 15 * WIDHTSCALE)];
        [phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(35 * HEIGHTSCALE, -30 * WIDHTSCALE, 0, 0)];
        [_ziquView addSubview: phoneBtn];
        
    }
    //订单详情
    UIView *detaiView = [[UIView alloc]initWithFrame:CGRectMake(0, _ziquView.frame.size.height + _ziquView.frame.origin.y + 10, WIDHT, 400)];
    detaiView.backgroundColor = [UIColor whiteColor];
    [_mainScrollview addSubview: detaiView];
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 4)];
    line1.backgroundColor = Color;
    [detaiView addSubview: line1];
    UILabel *logoLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 76 * WIDHTSCALE, 32 * HEIGHTSCALE)];
    logoLb.backgroundColor = Color;
    logoLb.text = @"订单详情";
    logoLb.textColor = [UIColor whiteColor];
    logoLb.font = [UIFont systemFontOfSize:15];
    logoLb.textAlignment = NSTextAlignmentCenter;
    [detaiView addSubview: logoLb];
    //line2
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, logoLb.frame.size.height + logoLb.frame.origin.y - 1.5, WIDHT, 1.5)];
    line2.backgroundColor = _lineColor;
    [detaiView addSubview: line2];
    
    //创建tableview
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y + line2.frame.size.height, WIDHT, 50 * 5) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [detaiView addSubview: _tableview];
    
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _tableview.frame.size.height + _tableview.frame.origin.y, WIDHT, 1.5)];
    line3.backgroundColor = _lineColor;
    [detaiView addSubview: line3];
    
    //商品金额
    UILabel *jielb = [[UILabel alloc]initWithFrame:CGRectMake(logoLb.frame.origin.x, line3.frame.origin.y + line3.frame.size.height, 70, 30)];
    //    jielb.backgroundColor = [UIColor redColor];
    jielb.text = @"商品金额";
    jielb.font = [UIFont systemFontOfSize:14];
    jielb.textAlignment = NSTextAlignmentLeft;
    [detaiView addSubview: jielb];
    _shangpinje = [[UILabel alloc]initWithFrame:CGRectMake(jielb.frame.size.width + jielb.frame.origin.x, jielb.frame.origin.y, WIDHT - jielb.frame.size.width - jielb.frame.origin.x - 10, jielb.frame.size.height)];
    _shangpinje.text = @"¥387";
    _shangpinje.font = [UIFont systemFontOfSize:15];
    _shangpinje.textAlignment = NSTextAlignmentRight;
    [detaiView addSubview: _shangpinje];
    
    //优惠金额
    UILabel *youlb = [[UILabel alloc]initWithFrame:CGRectMake(jielb.frame.origin.x, jielb.frame.size.height + jielb.frame.origin.y + 10, jielb.frame.size.width, jielb.frame.size.height)];
    youlb.text = @"优惠金额";
    youlb.font = [UIFont systemFontOfSize:14];
    youlb.textAlignment = NSTextAlignmentLeft;
    [detaiView addSubview: youlb];
    _youhuijine = [[UILabel alloc]initWithFrame:CGRectMake(youlb.frame.size.width + youlb.frame.origin.x, youlb.frame.origin.y, WIDHT - youlb.frame.size.width - youlb.frame.origin.x - 10, youlb.frame.size.height)];
    _youhuijine.text = @"¥5";
    _youhuijine.font = [UIFont systemFontOfSize:15];
    _youhuijine.textAlignment = NSTextAlignmentRight;
    [detaiView addSubview: _youhuijine];
    
    //配送费
    UILabel *peilb = [[UILabel alloc]initWithFrame:CGRectMake(jielb.frame.origin.x, youlb.frame.size.height + youlb.frame.origin.y + 10, jielb.frame.size.width, jielb.frame.size.height)];
    peilb.text = @"配送费";
    peilb.font = [UIFont systemFontOfSize:14];
    peilb.textAlignment = NSTextAlignmentLeft;
    [detaiView addSubview: peilb];
    _peisongfei = [[UILabel alloc]initWithFrame:CGRectMake(peilb.frame.size.width + peilb.frame.origin.x, peilb.frame.origin.y, WIDHT - peilb.frame.size.width - peilb.frame.origin.x - 10, peilb.frame.size.height)];
    _peisongfei.text = @"¥5";
    _peisongfei.font = [UIFont systemFontOfSize:15];
    _peisongfei.textAlignment = NSTextAlignmentRight;
    [detaiView addSubview: _peisongfei];
    
    UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _peisongfei.frame.size.height + _peisongfei.frame.origin.y, WIDHT, 1.5)];
    line4.backgroundColor = _lineColor;
    [detaiView addSubview: line4];
    
    //订单金额
    UILabel *dingdajine = [[UILabel alloc]initWithFrame:CGRectMake(peilb.frame.origin.x, line4.frame.origin.y + line4.frame.size.height, peilb.frame.size.width + 10, peilb.frame.size.height)];
    dingdajine.text = @"订单金额";
    dingdajine.font = [UIFont systemFontOfSize:15];
    dingdajine.textAlignment = NSTextAlignmentLeft;
    [detaiView addSubview: dingdajine];
    _orderjine = [[UILabel alloc]initWithFrame:CGRectMake(dingdajine.frame.size.width + dingdajine.frame.origin.x, dingdajine.frame.origin.y, WIDHT - dingdajine.frame.size.width - dingdajine.frame.origin.x - 10, dingdajine.frame.size.height)];
    _orderjine.text = @"¥377.00";
    _orderjine.textColor = [UIColor redColor];
    _orderjine.font = [UIFont systemFontOfSize:15];
    _orderjine.textAlignment = NSTextAlignmentRight;
    [detaiView addSubview: _orderjine];
    
    UIImageView *line5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, dingdajine.frame.size.height + dingdajine.frame.origin.y, WIDHT, 1.5)];
    line5.backgroundColor = _lineColor;
    [detaiView addSubview: line5];
    
    //备注
    UILabel *beizhu = [[UILabel alloc]initWithFrame:CGRectMake(dingdajine.frame.origin.x, line5.frame.origin.y + 1.5 + 10, 35, 20)];
    beizhu.text = @"备注:";
    beizhu.font = [UIFont systemFontOfSize:15];
    beizhu.textAlignment = NSTextAlignmentCenter;
    [detaiView addSubview: beizhu];
    _beizhuTV = [[UITextView alloc]initWithFrame:CGRectMake(beizhu.frame.origin.x + beizhu.frame.size.width + 5, beizhu.frame.origin.y, WIDHT - beizhu.frame.origin.x - beizhu.frame.size.width - 5 - 32 * WIDHTSCALE, 60 * HEIGHTSCALE)];
    _beizhuTV.backgroundColor = [UIColor colorWithRed:231 / 255.0  green:236 / 255.0 blue:237 / 255.0 alpha:1];
    _beizhuTV.text = @" 可乐要冰的";
    _beizhuTV.layer.cornerRadius = 5;
    _beizhuTV.userInteractionEnabled = NO;
    _beizhuTV.font = [UIFont systemFontOfSize:12];
    [detaiView addSubview: _beizhuTV];
    
    //重新detailview的高度
    [detaiView setFrame:CGRectMake(0, _ziquView.frame.size.height + _ziquView.frame.origin.y + 10, WIDHT, _beizhuTV.frame.origin.y + _beizhuTV.frame.size.height + 20)];
    
    
    //订单信息
    UIView *mesview = [[UIView alloc]initWithFrame:CGRectMake(0, detaiView.frame.size.height + detaiView.frame.origin.y + 10, WIDHT, 400)];
    mesview.backgroundColor = [UIColor whiteColor];
    [_mainScrollview addSubview: mesview];
    UIImageView *line6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 4)];
    line6.backgroundColor = Color;
    [mesview addSubview: line6];
    UILabel *mesLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 76 * WIDHTSCALE, 32 * HEIGHTSCALE)];
    mesLb.backgroundColor = Color;
    mesLb.text = @"订单信息";
    mesLb.textColor = [UIColor whiteColor];
    mesLb.font = [UIFont systemFontOfSize:15];
    mesLb.textAlignment = NSTextAlignmentCenter;
    [mesview addSubview: mesLb];
    //line7
    UIImageView *line7 = [[UIImageView alloc]initWithFrame:CGRectMake(0, mesLb.frame.size.height + mesLb.frame.origin.y - 1.5, WIDHT, 1.5)];
    line7.backgroundColor = _lineColor;
    [mesview addSubview: line7];
    
    //订单编号
    UILabel *onum = [[UILabel alloc]initWithFrame:CGRectMake(mesLb.frame.origin.x, line7.frame.origin.y + line7.frame.size.height + 12, 65, 20)];
    onum.text = @"订单编号:";
    onum.textAlignment = NSTextAlignmentCenter;
    onum.font = [UIFont systemFontOfSize:14];
    [mesview addSubview: onum];
    _ordernum = [[UILabel alloc]initWithFrame:CGRectMake(onum.frame.origin.x + onum.frame.size.width + 5, onum.frame.origin.y, WIDHT - onum.frame.origin.x - onum.frame.size.width - 5, onum.frame.size.height)];
    _ordernum.text = @"1234567890";
    _ordernum.font = [UIFont systemFontOfSize:14];
    _ordernum.textAlignment = NSTextAlignmentLeft;
    [mesview addSubview: _ordernum];
    
    //下单时间
    UILabel *xiadan = [[UILabel alloc]initWithFrame:CGRectMake(onum.frame.origin.x, onum.frame.origin.y + onum.frame.size.height + 12, 65, 20)];
    xiadan.text = @"下单时间:";
    xiadan.textAlignment = NSTextAlignmentCenter;
    xiadan.font = [UIFont systemFontOfSize:14];
    [mesview addSubview: xiadan];
    _xiadantime = [[UILabel alloc]initWithFrame:CGRectMake(xiadan.frame.origin.x + xiadan.frame.size.width + 5, xiadan.frame.origin.y, WIDHT - xiadan.frame.origin.x - xiadan.frame.size.width - 5, xiadan.frame.size.height)];
    _xiadantime.text = @"2016-08-04 09:30";
    _xiadantime.font = [UIFont systemFontOfSize:14];
    _xiadantime.textAlignment = NSTextAlignmentLeft;
    [mesview addSubview: _xiadantime];
    
    //支付方式
    UILabel *zhifu = [[UILabel alloc]initWithFrame:CGRectMake(xiadan.frame.origin.x, xiadan.frame.origin.y + xiadan.frame.size.height + 12, 65, 20)];
    zhifu.text = @"下单时间:";
    zhifu.textAlignment = NSTextAlignmentCenter;
    zhifu.font = [UIFont systemFontOfSize:14];
    [mesview addSubview: zhifu];
    _zhifufangshi = [[UILabel alloc]initWithFrame:CGRectMake(zhifu.frame.origin.x + zhifu.frame.size.width + 5, zhifu.frame.origin.y, WIDHT - zhifu.frame.origin.x - zhifu.frame.size.width - 5, zhifu.frame.size.height)];
    _zhifufangshi.text = @"在线支付";
    _zhifufangshi.font = [UIFont systemFontOfSize:14];
    _zhifufangshi.textAlignment = NSTextAlignmentLeft;
    [mesview addSubview: _zhifufangshi];
    
    //完成时间
    UILabel *wancheng = [[UILabel alloc]initWithFrame:CGRectMake(zhifu.frame.origin.x, zhifu.frame.origin.y + zhifu.frame.size.height + 12, 65, 20)];
    wancheng.text = @"完成时间:";
    wancheng.textAlignment = NSTextAlignmentCenter;
    wancheng.font = [UIFont systemFontOfSize:14];
    [mesview addSubview: wancheng];
    _wanchengshijian = [[UILabel alloc]initWithFrame:CGRectMake(wancheng.frame.origin.x + wancheng.frame.size.width + 5, wancheng.frame.origin.y, WIDHT - wancheng.frame.origin.x - wancheng.frame.size.width - 5, wancheng.frame.size.height)];
    _wanchengshijian.text = @"";
    _wanchengshijian.font = [UIFont systemFontOfSize:14];
    _wanchengshijian.textAlignment = NSTextAlignmentLeft;
    [mesview addSubview: _wanchengshijian];
    [mesview setFrame:CGRectMake(0, detaiView.frame.size.height + detaiView.frame.origin.y + 10, WIDHT, wancheng.frame.origin.y + wancheng.frame.size.height + 16 * HEIGHTSCALE)];
    
    //设置scrollview的范围
    _mainScrollview.contentSize = CGSizeMake(WIDHT, mesview.frame.origin.y + mesview.frame.size.height + 20);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview registerNib:[UINib nibWithNibName:@"TCorderLTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    TCorderLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


@end
