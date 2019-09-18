//
//  TCSeleCateView.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/4/27.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSeleCateView.h"

@interface TCSeleCateView ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *recommendArr;
@property (nonatomic, strong) NSMutableArray *myArray;
@property (nonatomic, strong) UIView *searchHistoryView;
@property (nonatomic, strong) UIView *hotSearchView;

@end

@implementation TCSeleCateView

- (instancetype)initWithFrame:(CGRect)frame recommendArr:(NSMutableArray *)recommendArr myArray:(NSMutableArray *)myArray 
{
    if (self = [super initWithFrame:frame]) {
        self.myArray = myArray;
        self.recommendArr = recommendArr;
        [self addSubview:self.searchHistoryView];
        [self addSubview:self.hotSearchView];
        self.viewHight = self.searchHistoryView.frame.size.height + self.hotSearchView.frame.size.height;
    }
    return self;
}


- (UIView *)hotSearchView
{
    if (!_hotSearchView) {
        
        self.hotSearchView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame) title:@"推荐品类" textArr:_recommendArr];
        self.hotSearchView.backgroundColor = [UIColor whiteColor];
    }
    return _hotSearchView;
}


- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        if (_myArray.count > 0) {
            self.searchHistoryView = [self setViewWithOriginY:0 title:@"我的品类" textArr:self.myArray];
            self.searchHistoryView.backgroundColor = [UIColor whiteColor];
        } else {
            self.searchHistoryView = [self setNoHistoryView];
        }
    }
    return _searchHistoryView;
}



- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr
{
    //创建View
    UIView *view = [[UIView alloc] init];
    UIView *garyView = [[UIView alloc] init];
    garyView.frame = CGRectMake(0, 0, WIDHT, 42);
    garyView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [view addSubview:garyView];
    
    //创建小竖条
    UIView *verticalView = [[UIView alloc] init];
    verticalView.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    verticalView.frame = CGRectMake(15, 22, 3, 18);
    [garyView addSubview:verticalView];
    
    //名称
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(verticalView.frame) + 5, 20, 64, 22)];
    titleL.text = title;
    titleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    titleL.textColor = TCUIColorFromRGB(0x393939);
    titleL.textAlignment = NSTextAlignmentLeft;
    [garyView addSubview:titleL];
    

    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:text] + 24;
        if (letfWidth + width + 15 > WIDHT) {
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 32)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.text = text;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 4;
        label.textAlignment = NSTextAlignmentCenter;
        if ( [title isEqualToString:@"推荐品类"]) {
            label.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
            label.textColor = TCUIColorFromRGB(0x666666);
        } else {
            label.textColor = TCUIColorFromRGB(0x666666);
            label.layer.borderColor = TCUIColorFromRGB(0xDEDEDE).CGColor;
        }
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [view addSubview:label];
        letfWidth += width + 15;
    }
    view.frame = CGRectMake(0, riginY, WIDHT, y + 40);
    view.backgroundColor = [UIColor redColor];
    return view;
}


- (UIView *)setNoHistoryView
{
    UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDHT - 30, 30)];
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textColor = [UIColor blackColor];
        titleL.textAlignment = NSTextAlignmentLeft;
    
        UILabel *notextL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame) + 10, 100, 20)];
        notextL.font = [UIFont systemFontOfSize:12];
        notextL.textColor = [UIColor blackColor];
        notextL.textAlignment = NSTextAlignmentLeft;
        [historyView addSubview:titleL];
        [historyView addSubview:notextL];
    return historyView;
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(WIDHT, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width;
    return width;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (self.tapAction) {
        self.tapAction(label.text);
    }
}

- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index
{
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
