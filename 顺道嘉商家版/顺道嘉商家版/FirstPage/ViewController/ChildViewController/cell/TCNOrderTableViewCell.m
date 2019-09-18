//
//  TCNOrderTableViewCell.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2017/10/31.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNOrderTableViewCell.h"

@implementation TCNOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self getcreat];
    }
    return self;
}
-(void)getcreat{
    
    //创建主View
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = CGRectMake(10, 0, WIDHT - 20, 183);
    mainView.backgroundColor = [UIColor redColor];
    [self addSubview:mainView];
    
    
    //上面的view
    self.topView = [[UIView alloc]init];
    self.topView.frame = CGRectMake(0, 0, mainView.width, 36);
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.alpha = 0.5;
    [mainView addSubview:self.topView];
//    //上面view中的订单种类
//    self.type = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width/5, self.topView.frame.size.height)];
//    self.type.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
//    self.type.textColor = [UIColor whiteColor];
////    if ([self.type.text isEqualToString:@"快速送达"]) {
////        self.type.backgroundColor =  TCUIColorFromRGB(0x00888cc);
////        
////    }else if ([self.type.text isEqualToString:@"预定订单"]){
////        self.type.backgroundColor = TCUIColorFromRGB(0x00cccc);
////    }else if ([self.type.text isEqualToString:@"门店自取"]){
////        self.type.backgroundColor = TCUIColorFromRGB(0xcccccc);
////    }
//    [self.topView addSubview:self.type];
//    //上面view中的状态
//    self.state = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*(1 - 0.19),self.topView.frame.size.height*0.2, self.contentView.frame.size.width*0.17, self.topView.frame.size.height*0.6)];
//    self.state.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
//    [self.topView addSubview:self.state];
//    //地址label 高度随字数变化 高度自适应
//    self.Address = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.02, self.contentView.frame.size.height*0.284, self.contentView.frame.size.width*0.744, 0)];
//    
//    CGSize size = [self.Address sizeThatFits:CGSizeMake(self.Address.frame.size.width, MAXFLOAT)];
//    self.Address.numberOfLines = 0;
//    self.frame = CGRectMake(self.Address.origin.x, self.Address.origin.y, self.Address.size.width, size.height);
//    self.Address.backgroundColor = TCUIColorFromRGB(0x4646464);
//    self.Address.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
//    [self.contentView addSubview:self.Address];
    
    //创建价格label
//    self.price = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.02, self.contentView.frame.size.height*0.568, self.contentView.frame.size.width*0.14, self.contentView.frame.size.height*0.12)];
//    self.price.textColor = TCUIColorFromRGB(0xFF5500);
//    self.price.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
//    [self.contentView addSubview:self.price];
//    //电话按钮
//    self.phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.885, self.contentView.frame.size.height*0.377, self.contentView.frame.size.width*0.094, self.contentView.frame.size.width*0.094)];
//    [self.phoneBtn setImage:[UIImage imageNamed:@"电话图标"] forState:UIControlStateNormal];
//    
//    //收货人label
//    self.perple = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.826, self.contentView.frame.size.height*0.55, self.contentView.frame.size.width*0.115, self.contentView.frame.size.height*0.1)];
//    self.perple.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
//    self.perple.textColor = TCUIColorFromRGB(0x525F66);
//    //预计到达时间label
//    self.deliverytime = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.02, self.contentView.frame.size.height*0.83, self.contentView.frame.size.width*0.39, self.contentView.frame.size.height*0.12)];
//    self.deliverytime.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.deliverytime.backgroundColor = [UIColor whiteColor];
//    self.deliverytime.textColor = TCUIColorFromRGB(0x656565);
//    [self.contentView addSubview:self.deliverytime];
//    
////订单创建时间
//    self.orderTime = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width*0.597, self.contentView.frame.size.height*0.83, self.contentView.frame.size.width*0.39, self.contentView.frame.size.height*12)];
//    self.orderTime.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.orderTime.textColor = TCUIColorFromRGB(0x656565);
//    [self.contentView addSubview:self.orderTime];
//    //时间上面的线
//    UIView*lineView = [[UIView alloc]initWithFrame:CGRectMake(5, self.contentView.frame.size.height*0.83 - 6, self.contentView.frame.size.width - 10, 1)];
//    lineView.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:lineView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
