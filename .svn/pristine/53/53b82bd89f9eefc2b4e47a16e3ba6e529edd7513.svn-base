//
//  TCSpecifView.m
//  ShunDaoJia
//
//  Created by 胡高广 on 2017/12/25.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "TCSpecifView.h"

@interface TCSpecifView()


@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *shopSpceMuArr;

@end

@implementation TCSpecifView
-(id)initWithFrame:(CGRect)frame andArr:(NSArray *)specifArr{
    self = [super initWithFrame:frame];
    if(self) {
        //创建View
        [self createUI:specifArr];
        self.idArr = specifArr;
    }
    
    return self;
}

//创建view
- (void)createUI:(NSArray *)specifArr{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    self.backView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview: _backView];
    //规格背景
    self.guigeView = [[UIView alloc] init];
    self.guigeView.backgroundColor = [UIColor whiteColor];
    self.guigeView.frame = CGRectMake(24, (HEIGHT - 288)/2, WIDHT - 48, 288);
    self.guigeView.layer.cornerRadius = 8;
    self.guigeView.layer.masksToBounds = YES;
    [_backView addSubview:self.guigeView];

//    //商品名字/
    self.shopNameLabel = [UILabel publicLab:@"选择品类" textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Medium" size:15 numberOfLines:0];
    self.shopNameLabel.frame = CGRectMake(15, 20,60, 15);
    [self.guigeView addSubview:self.shopNameLabel];

    //删除的小图标
    self.backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(WIDHT - 48 - 16 - 20, 20, 16, 17);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"关闭按钮"] forState:(UIControlStateNormal)];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.guigeView addSubview:self.backBtn];

    //闲
    UIView *viewLine = [[UIView alloc] init];
    viewLine.frame = CGRectMake(15, CGRectGetMaxY(self.shopNameLabel.frame) + 20, WIDHT - 30 - 30, 1);
    viewLine.backgroundColor = TCBgColor;
    [self.guigeView addSubview:viewLine];
    
    //button数组
    self.SortView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewLine.frame), WIDHT - 48, 0)];
    self.SortView.backgroundColor = [UIColor whiteColor];
    self.SortView.clipsToBounds = YES;
    [self.guigeView addSubview: self.SortView];

    self.btnArr = specifArr;
    for (int i = 0; i < self.btnArr.count; i++) {
        
        NSString *namestr = self.btnArr[i][@"name"] ;
        static UIButton *searchrecordBtn = nil;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:UIControlStateSelected];
        [button setTitleColor:TCUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        button.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        button.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
        [button setTitle:namestr forState:UIControlStateNormal];
        
        CGRect newRect = [namestr boundingRectWithSize:CGSizeMake(WIDHT - 48 - 40, 32) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil];
        if (i == 0) {
            button.frame = CGRectMake(20, 12, newRect.size.width + 20, 32);
//            button.selected = YES;
//            self.selectedBtn = button;
//            button.backgroundColor = [TCUIColorFromRGB(0xF99E20) colorWithAlphaComponent:0.2];
//            button.layer.borderColor = TCUIColorFromRGB(0xF99E20).CGColor;
        }else{
            CGFloat newwidth = WIDHT - 20 - CGRectGetMaxX(searchrecordBtn.frame) - 48;
            if (newwidth >= newRect.size.width) {
                button.frame = CGRectMake(CGRectGetMaxX(searchrecordBtn.frame) + 20, searchrecordBtn.frame.origin.y, newRect.size.width + 20, 32);
            }else{
                button.frame = CGRectMake(20, CGRectGetMaxY(searchrecordBtn.frame) + 20, newRect.size.width + 20, 32);
            }
            button.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
            button.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
        }
        button.tag = i + 1;
        [button addTarget:self action:@selector(recordBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 0.5;
        button.layer.masksToBounds = YES;

        //代表前一个按钮 用来记录前一个按钮的位置与大小
        searchrecordBtn = button;
        [self.SortView addSubview: button];
        if (i ==  self.btnArr.count - 1) {
            self.SortView.frame = CGRectMake(0, CGRectGetMaxY(viewLine.frame), WIDHT - 48, CGRectGetMaxY(button.frame) + 20);
            self.lastBtn = button;
        }
    }
    
    self.guigeView.frame = CGRectMake(24, (HEIGHT - CGRectGetMaxY(self.SortView.frame))/2, WIDHT - 48, CGRectGetMaxY(self.SortView.frame));
}

#pragma mark -- 搜索记录的点击事件
-(void)recordBtn:(UIButton *)sender{
    _selectedBtn.selected = NO;
    _selectedBtn.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    _selectedBtn.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
    
    sender.selected = !sender.selected;
    sender.backgroundColor = [TCUIColorFromRGB(0x53C3C3) colorWithAlphaComponent:0.2];
    sender.layer.borderColor = TCUIColorFromRGB(0x53C3C3).CGColor;
    self.selectedBtn = sender;
    
    //如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
    if ([self.delegate respondsToSelector:@selector(sendValue:andName:)]) {
        [self.delegate  sendValue:self.idArr[sender.tag - 1][@"goodscateid"] andName:self.idArr[sender.tag - 1][@"name"]];
    }
    
    [self backAction];
}

#pragma mark -- 删除
- (void)backAction
{
    [UIView animateWithDuration:0.3 animations:^{
       
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
        _backView = nil;
        [self removeFromSuperview];
        self.guigeView = nil;
    }];
}

@end

