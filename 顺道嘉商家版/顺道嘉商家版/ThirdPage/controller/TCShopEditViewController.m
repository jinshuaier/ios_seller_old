//
//  TCShopEditViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/24.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCShopEditViewController.h"
//默认最大输入字数 kMaxTextCount
#define kMaxTextCount 150
@interface TCShopEditViewController ()<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate,UITextViewDelegate>
{
    UILabel *textLabel;
    UILabel *textNumberLabel;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *downView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UITextField *tiaoma;
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *price;
@property (nonatomic, strong) UITextField *guige;
@property (nonatomic, strong) UITextField *sort;
@property (nonatomic, strong) UITextField *kouwei;
@property (nonatomic, strong) UIImageView *imageviews;//添加商品图片
@property (nonatomic, strong) UITextView *jieshaoTV;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIView *backGView;
@property (nonatomic, strong) NSMutableArray *secSortArr;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextView *kouweiTV;
@property (nonatomic, assign) BOOL isRemove;
@property (nonatomic, strong) UIView *kouweiView;
@property (nonatomic, strong) UIView *imView;
@property (nonatomic, strong) NSData *imageData;//用来记录选取的图片
@property (nonatomic, strong) NSMutableArray *firstSortArr;//存储一级分类信息
@property (nonatomic, strong) NSMutableArray *secondeScorArr;//存储二级分类信息
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UIScrollView *secondescrollview;
@property (nonatomic, strong) UIView *sesviews;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *fenlei;//记录一级分类
@property (nonatomic, strong) NSString *fenlei2;//记录二级分类
@property (nonatomic, strong) NSString *sortID;//选择分类的id（二级）
@property (nonatomic, strong) NSString *segmentid;//是否上下架；
@property (nonatomic, strong) NSString *gid;//商品id  跟新是用
@property (nonatomic, strong) UILabel *tm;
@property (nonatomic, assign) BOOL QrHas;//判断二维码扫描进来是否存在图片
@property (nonatomic, strong) UITextField *yujingtf;
@end

@implementation TCShopEditViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    
    if (self.zhuce){
        
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = Color;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         
         @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
           
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        //左边导航栏的按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12*WIDHTSCALE, 20*HEIGHTSCALE)];
        // Add your action to your button
        [leftButton addTarget:self action:@selector(barButtonItemsao:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
        UIBarButtonItem *barleftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = barleftBtn;
    } else {
        self.tabBarController.tabBar.hidden= YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGgray;
    if(self.isChange == YES){
        self.title = @"修改商品";
    }else{
        self.title = @"添加商品";
    }
    _firstSortArr = [NSMutableArray array];
    _userdefaults = [NSUserDefaults standardUserDefaults];
    //获取分类信息
    [self requestleft];
    NSLog(@"位置%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]);

    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64 - 12)];
    _mainScrollView.backgroundColor = backGgray;
    _mainScrollView.delegate = self;
    [self.view addSubview: _mainScrollView];

    _topView = [[UIView alloc]initWithFrame:CGRectMake(12, 8, WIDHT - 24, 200 * HEIGHTSCALE)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 3;
    [_mainScrollView addSubview: _topView];


    //条码
    if (![[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
        //如果是扫二维码进来
        _tm = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 50, 35)];
        _tm.text = @"条码";
        _tm.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview: _tm];
        _tiaoma = [[UITextField alloc]initWithFrame:CGRectMake(_tm.frame.origin.x + _tm.frame.size.width + 5, _tm.frame.origin.y, _topView.frame.size.width - _tm.frame.origin.x - _tm.frame.size.width - 2 - 5, _tm.frame.size.height)];
        _tiaoma.font = [UIFont systemFontOfSize:13];
        _tiaoma.textAlignment = NSTextAlignmentCenter;
        _tiaoma.placeholder = @"条形码";
        [_topView addSubview: _tiaoma];
        UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(_tiaoma.frame.origin.x, _tiaoma.frame.origin.y + _tiaoma.frame.size.height, _tiaoma.frame.size.width, 1.5)];
        line1.backgroundColor = backGgray;
        [_topView addSubview: line1];
    }else{
        _tm = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }


    //名称
    UILabel *mc = [[UILabel alloc]initWithFrame:CGRectMake(2, _tm.frame.origin.y + _tm.frame.size.height + 5, 50, 35)];
    mc.text = @"名称";
    mc.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: mc];
    _name = [[UITextField alloc]initWithFrame:CGRectMake(mc.frame.origin.x + mc.frame.size.width + 5, mc.frame.origin.y, _topView.frame.size.width - mc.frame.origin.x - mc.frame.size.width - 2 - 5, mc.frame.size.height)];
    _name.placeholder = @"填写商品名称";
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:13];
    [_topView addSubview: _name];
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.origin.y + _name.frame.size.height, _name.frame.size.width, 1.5)];
    line2.backgroundColor = backGgray;
    [_topView addSubview: line2];

    //价格
    UILabel *jg = [[UILabel alloc]initWithFrame:CGRectMake(2, mc.frame.origin.y + mc.frame.size.height + 5, 50, 35)];
    jg.text = @"价格";
    jg.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: jg];
    _price = [[UITextField alloc]initWithFrame:CGRectMake(jg.frame.origin.x + jg.frame.size.width + 5, jg.frame.origin.y, _topView.frame.size.width - jg.frame.origin.x - jg.frame.size.width - 2 - 5, jg.frame.size.height)];
    _price.placeholder = @"填写商品价格";
    _price.delegate = self;
    _price.keyboardType = UIKeyboardTypeDecimalPad;
    _price.font = [UIFont systemFontOfSize:13];
    _price.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: _price];
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(_price.frame.origin.x, _price.frame.origin.y + _price.frame.size.height, _price.frame.size.width, 1.5)];
    line3.backgroundColor = backGgray;
    [_topView addSubview: line3];

    //规格
    UILabel *gg = [[UILabel alloc]initWithFrame:CGRectMake(2, jg.frame.origin.y + jg.frame.size.height + 5, 50, 35)];
    gg.text = @"规格";
    gg.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: gg];
    _guige = [[UITextField alloc]initWithFrame:CGRectMake(gg.frame.origin.x + gg.frame.size.width + 5, gg.frame.origin.y, _topView.frame.size.width - gg.frame.origin.x - gg.frame.size.width - 2 - 5, gg.frame.size.height)];
    _guige.placeholder = @"填写商品规格";
    _guige.font = [UIFont systemFontOfSize:13];
    _guige.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: _guige];
    UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(_guige.frame.origin.x, _guige.frame.origin.y + _guige.frame.size.height, _guige.frame.size.width, 1.5)];
    line4.backgroundColor = backGgray;
    [_topView addSubview: line4];

    //分类
    UILabel *fl = [[UILabel alloc]initWithFrame:CGRectMake(2, gg.frame.origin.y + gg.frame.size.height + 5, 50, 35)];
    fl.text = @"分类";
    fl.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview: fl];
    _sort = [[UITextField alloc]initWithFrame:CGRectMake(fl.frame.origin.x + fl.frame.size.width + 5, fl.frame.origin.y, _topView.frame.size.width - fl.frame.origin.x - fl.frame.size.width - 2 - 5, fl.frame.size.height)];
    _sort.placeholder = @"填写商品分类";
    _sort.font = [UIFont systemFontOfSize:13];
    _sort.textAlignment = NSTextAlignmentCenter;
    _sort.delegate = self;
    [_topView addSubview: _sort];
    UIImageView *line5 = [[UIImageView alloc]initWithFrame:CGRectMake(_sort.frame.origin.x, _sort.frame.origin.y + _sort.frame.size.height, _sort.frame.size.width, 1.5)];
    line5.backgroundColor = backGgray;
    [_topView addSubview: line5];
    _topView.frame = CGRectMake(12, 8, WIDHT - 24, _sort.frame.origin.y + _sort.frame.size.height + 2.5);

//    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
        //库存量
        UILabel *kw = [[UILabel alloc]initWithFrame:CGRectMake(2, fl.frame.origin.y + fl.frame.size.height + 5, 60, 35)];
        kw.text = @"库存量";
        kw.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview: kw];
        _kouwei = [[UITextField alloc]initWithFrame:CGRectMake(kw.frame.origin.x + kw.frame.size.width + 5, kw.frame.origin.y, _topView.frame.size.width - kw.frame.origin.x - kw.frame.size.width - 2 - 5, kw.frame.size.height)];
        _kouwei.placeholder = @"最小值为1，最大值9999";
        _kouwei.text = @"0";
        _kouwei.font = [UIFont systemFontOfSize:13];
        _kouwei.textAlignment = NSTextAlignmentCenter;
        _kouwei.keyboardType = UIKeyboardTypeDecimalPad;
        [_kouwei addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_topView addSubview: _kouwei];
        UIImageView *line6 = [[UIImageView alloc]initWithFrame:CGRectMake(_kouwei.frame.origin.x, _kouwei.frame.origin.y + _kouwei.frame.size.height, _kouwei.frame.size.width, 1.5)];
        line6.backgroundColor = backGgray;
        [_topView addSubview: line6];
        //预警值
        UILabel *yujing = [[UILabel alloc]initWithFrame:CGRectMake(kw.frame.origin.x, kw.frame.origin.y + kw.frame.size.height + 5, kw.frame.size.width, kw.frame.size.height)];
        yujing.text = @"预警值";
        yujing.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview: yujing];
        _yujingtf = [[UITextField alloc]initWithFrame:CGRectMake(_kouwei.frame.origin.x, yujing.frame.origin.y, _kouwei.frame.size.width, _kouwei.frame.size.height)];
        _yujingtf.placeholder = @"最小值0，最大值不能超过库存量";
        _yujingtf.font = [UIFont systemFontOfSize:13];
        _yujingtf.textAlignment = NSTextAlignmentCenter;
        _yujingtf.keyboardType = UIKeyboardTypeDecimalPad;
        _yujingtf.text = @"0";
        [_yujingtf addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_topView addSubview: _yujingtf];
        UIImageView *line7 = [[UIImageView alloc]initWithFrame:CGRectMake(_yujingtf.frame.origin.x,_yujingtf.frame.origin.y + _yujingtf.frame.size.height, _yujingtf.frame.size.width, 1.5)];
        line7.backgroundColor = backGgray;
        [_topView addSubview: line7];
        
        _topView.frame = CGRectMake(12, 8, WIDHT - 24, _yujingtf.frame.origin.y + _yujingtf.frame.size.height + 2.5);
//    }
//    else{
//        //口味
//        UILabel *kw = [[UILabel alloc]initWithFrame:CGRectMake(2, fl.frame.origin.y + fl.frame.size.height + 5, 50, 35)];
//        kw.text = @"口味";
//        kw.textAlignment = NSTextAlignmentCenter;
//        [_topView addSubview: kw];
//        _kouwei = [[UITextField alloc]initWithFrame:CGRectMake(kw.frame.origin.x + kw.frame.size.width + 5, kw.frame.origin.y, _topView.frame.size.width - kw.frame.origin.x - kw.frame.size.width - 2 - 5, kw.frame.size.height)];
//        _kouwei.placeholder = @"填写商品口味";
//        _kouwei.font = [UIFont systemFontOfSize:13];
//        _kouwei.textAlignment = NSTextAlignmentCenter;
//        _kouwei.delegate = self;
//        [_topView addSubview: _kouwei];
//        UIImageView *line6 = [[UIImageView alloc]initWithFrame:CGRectMake(_kouwei.frame.origin.x, _kouwei.frame.origin.y + _kouwei.frame.size.height, _kouwei.frame.size.width, 1.5)];
//        line6.backgroundColor = backGgray;
//        [_topView addSubview: line6];
//        _topView.frame = CGRectMake(12, 8, WIDHT - 24, _kouwei.frame.origin.y + _kouwei.frame.size.height + 2.5);
//    }
    


    //添加第二个view
    _downView = [[UIView alloc]initWithFrame:CGRectMake(12, _topView.frame.origin.y + _topView.frame.size.height + 8, _topView.frame.size.width, 280 * HEIGHTSCALE)];
    _downView.backgroundColor = [UIColor whiteColor];
    _downView.layer.cornerRadius = 3;
    [_mainScrollView addSubview: _downView];

    //商品图片
    UILabel *sptp = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 70, 30)];
    sptp.text = @"商品图片";
    [_downView addSubview: sptp];
    _imView = [[UIView alloc]initWithFrame:CGRectMake(sptp.frame.origin.x + sptp.frame.size.width + 40 * WIDHTSCALE, sptp.frame.origin.y, 160 * HEIGHTSCALE, 160 * HEIGHTSCALE)];
    [_downView addSubview:_imView];
    _imageviews = [[UIImageView alloc]initWithFrame:_imView.bounds];
    _imageviews.image = [UIImage imageNamed:@"plus"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_imView addGestureRecognizer:tap];
    [_imView addSubview: _imageviews];
    _imageviews.layer.cornerRadius = 5;
    _imageviews.layer.masksToBounds = YES;
    _imView.layer.masksToBounds = YES;
    _imView.layer.cornerRadius = 5;



    //商品介绍
    UILabel *jieshao = [[UILabel alloc]initWithFrame:CGRectMake(2, _imageviews.frame.origin.y + _imageviews.frame.size.height + 20, 70, 30)];
    jieshao.text = @"商品介绍";
    [_downView addSubview: jieshao];
    _jieshaoTV = [[UITextView alloc]initWithFrame:CGRectMake(jieshao.frame.origin.x + jieshao.frame.size.width + 8, jieshao.frame.origin.y, _downView.frame.size.width - jieshao.frame.origin.x - jieshao.frame.size.width - 8 - 8, 100 * HEIGHTSCALE)];
    _jieshaoTV.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:236 / 255.0 blue:237 / 255.0 alpha:1];
    _jieshaoTV.layer.cornerRadius = 8;
    _jieshaoTV.delegate = self;
    [_downView addSubview: _jieshaoTV];

    //是否上架
    UILabel *shangjia = [[UILabel alloc]initWithFrame:CGRectMake(2, _jieshaoTV.frame.origin.y + _jieshaoTV.frame.size.height + 30 * HEIGHTSCALE, 70, 30)];
    shangjia.text =  @"是否上架";
    [_downView addSubview: shangjia];
    NSArray *arr = @[@"上架", @"下架"];
    _segment = [[UISegmentedControl alloc]initWithItems:arr];
    _segment.frame = CGRectMake(shangjia.frame.origin.x + shangjia.frame.size.width + 8, shangjia.frame.origin.y, 200, 30);
    _segment.tintColor = Color;
    _segment.selectedSegmentIndex = 0;
    if (_segment.selectedSegmentIndex == 0) {
        _segmentid = @"1";
    }else{
        _segmentid = @"0";
    }
    [_downView addSubview: _segment];
    
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE, CGRectGetMaxY(_segment.frame) + 30, WIDHT - 80 * WIDHTSCALE, 48 * HEIGHTSCALE)];
    _commitBtn.backgroundColor = btnColors;
    [_commitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.layer.cornerRadius = 5;
    [_downView addSubview: _commitBtn];
    
    _downView.frame = CGRectMake(12, _topView.frame.origin.y + _topView.frame.size.height + 8, _topView.frame.size.width, _commitBtn.frame.origin.y + _commitBtn.frame.size.height + 10);
    _mainScrollView.contentSize = CGSizeMake(WIDHT, _downView.frame.origin.y + _downView.frame.size.height);

    //进来修改的
    if (_isChange) {
        _name.text = _shopMesDic[@"name"];
        _price.text = _shopMesDic[@"price"];
        _guige.text = _shopMesDic[@"spec"];
        _fenlei = _shopMesDic[@"rootcat_name"];
        _fenlei2 = _shopMesDic[@"cat_name"];
        _tiaoma.text = [NSString stringWithFormat:@"%@", _shopMesDic[@"barcode"]];
        _sort.text = [_shopMesDic[@"rootcat_name"] stringByAppendingString:[NSString stringWithFormat:@"--%@", _shopMesDic[@"cat_name"]]];
        _sortID = _shopMesDic[@"shopcatid"];
        _jieshaoTV.text = _shopMesDic[@"description"];
        if ([_shopMesDic[@"status"] isEqualToString:@"1"]) {
            _segment.selectedSegmentIndex = 0;
            _segmentid = _shopMesDic[@"status"];
        }else{
            _segment.selectedSegmentIndex = 1;
            _segmentid = _shopMesDic[@"status"];
        }
        if (![_shopMesDic[@"headPic"] isEqualToString:@""]) {
            //获取当前图片信息
            dispatch_async(dispatch_queue_create("SecondConcurrentQueue", DISPATCH_QUEUE_CONCURRENT), ^{
                _imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_shopMesDic[@"headPic"]]];
                [_imageData writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"store.png"] atomically:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _imageviews.image = [UIImage imageWithData:_imageData];
                });
            });
        }
        _gid = _shopMesDic[@"id"];
//        if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
            _yujingtf.text = _shopMesDic[@"warning"];
            _kouwei.text = _shopMesDic[@"stockCount"];
//        }else{
//            NSArray *arr = _shopMesDic[@"natures"];
//            if (arr.count != 0) {
//                NSString *str = arr[0];
//                for (int i = 1; i < arr.count; i++) {
//                    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@", arr[i]]];
//                }
//                _kouwei.text = str;
//            }
//        }
    }

     _tiaoma.text = self.codeStr;
    //如果扫码进来
    if (_isQr) {
        
        _name.text = _QrDic[@"name"];
        _price.text = [NSString stringWithFormat:@"%@", _QrDic[@"price"]];
        _guige.text = _QrDic[@"spec"];
        NSArray *arr = _QrDic[@"img"];
        if (arr.count != 0) {
            //如果有图  显示下
            [_imageviews sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
            _QrHas = YES;
        }
    }
}

- (void)valueChanged:(UITextField *)field{
    NSLog(@"%@", field.text);
    if ([field.text intValue] > 9999) {
        field.text = @"9999";
    }
}

//请求分类
- (void)requestleft{
    [TCAFNetworking postWithURLString:[TCServerSecret loginAndRegisterSecret:@"300107"] parameters:@{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"showgoods":@"-1"} success:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"图库分类接口 %@", str);
        if (dic[@"data"]) {
            //存储一级分类
            [_firstSortArr addObjectsFromArray:dic[@"data"][@"goods_types"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
    
}

//textView的代理方法
//判断开始输入
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length >= kMaxTextCount){
        //截取字符串
        textView.text = [textView.text substringToIndex:150];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [_tiaoma resignFirstResponder];
    [_name resignFirstResponder];
    [_price resignFirstResponder];
    [_guige resignFirstResponder];
   
    if(textField == _price){
        return YES;
    }
    
    if (textField == _sort) {
        [self createBackGView];
        UIView *sortview = [[UIView alloc]initWithFrame:CGRectMake(20, 0, WIDHT - 40, 300 * HEIGHTSCALE)];
        sortview.backgroundColor = [UIColor whiteColor];
        sortview.center = self.view.center;
        sortview.layer.cornerRadius = 5;
        _isRemove = NO;
        [_backGView addSubview: sortview];

        CGFloat h = sortview.frame.size.height / 2;
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, h - 0.5, sortview.frame.size.width, 1)];
        line.backgroundColor = backGgray;
        [sortview addSubview: line];

        UILabel *firstSort = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 30)];
        firstSort.text = @"一级分类";
        [sortview addSubview: firstSort];
        UIScrollView *firstScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, firstSort.frame.origin.y + firstSort.frame.size.height, sortview.frame.size.width, line.frame.origin.y - 2 - firstSort.frame.origin.y - firstSort.frame.size.height)];
        firstScroll.showsVerticalScrollIndicator = NO;
        [sortview addSubview: firstScroll];

        UILabel *sesort = [[UILabel alloc]initWithFrame:CGRectMake(5, line.frame.origin.y + 1 + 5, 70, 30)];
        sesort.text = @"二级分类";
        [sortview addSubview: sesort];


        _sesviews = [[UIView alloc]initWithFrame:CGRectMake(0, sesort.frame.origin.y + sesort.frame.size.height, sortview.frame.size.width, line.frame.origin.y - 2 - firstSort.frame.origin.y - firstSort.frame.size.height)];
        [sortview addSubview: _sesviews];

        for (int i = 0; i < _firstSortArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
            btn.frame = [self createBtnFrame:i andWidth:_sesviews.frame.size.width];
            [btn setTitle:_firstSortArr[i][@"name"] forState:UIControlStateNormal];

            if ([_firstSortArr[i][@"name"] isEqualToString:_fenlei]) {
                //如果有
                btn.layer.borderColor = Color.CGColor;
                [btn setTitleColor:Color forState:UIControlStateNormal];
                btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
                _selectBtn = btn;
                //创建已选中的二级分类
                [self creatSecondSort:_firstSortArr[i][@"childs"]];
            }else{
                btn.layer.borderColor = [UIColor blackColor].CGColor;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
            }
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 0.5;
            btn.tag = i;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn addTarget:self action:@selector(sortChick:) forControlEvents:UIControlEventTouchUpInside];
            [firstScroll addSubview: btn];
            if (i == _firstSortArr.count - 1) {
                firstScroll.contentSize = CGSizeMake(sortview.frame.size.width, btn.frame.origin.y + btn.frame.size.height + 5);
            }
        }
    }else if (textField == _kouwei) {
        [self createBackGView];
        UIView *sview = [[UIView alloc]initWithFrame:CGRectMake(20, 0, WIDHT - 40, 300 * HEIGHTSCALE)];
        sview.backgroundColor = [UIColor whiteColor];
        sview.layer.cornerRadius = 5;
        _isRemove = YES;
        [_backGView addSubview: sview];
        [sview setFrame:CGRectMake(10, HEIGHT / 2 - 100, WIDHT - 20, 220)];
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, sview.frame.size.height - 60, sview.frame.size.width, 1.5)];
        line.backgroundColor = btnColors;
        [sview addSubview: line];
        //创建取消按钮
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn1.titleLabel.font = [UIFont systemFontOfSize:16];
        btn1.backgroundColor = [UIColor whiteColor];
        btn1.frame = CGRectMake(0, line.frame.origin.y + 1.5, sview.frame.size.width / 2, sview.frame.size.height - line.frame.origin.y - 1.5);
        [btn1 setTitle:@"取消" forState:UIControlStateNormal];
        [btn1 setTitleColor:btnColors forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [sview addSubview: btn1];
        //创建确认按钮
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn2.titleLabel.font = [UIFont systemFontOfSize:16];
        btn2.frame = CGRectMake(btn1.frame.size.width, btn1.frame.origin.y, btn1.frame.size.width, btn1.frame.size.height);
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
        UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:btn2.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *lay = [[CAShapeLayer alloc]init];
        lay.path = pa.CGPath;
        lay.frame = btn2.bounds;
        btn2.layer.mask = lay;
        btn2.backgroundColor = btnColors;
        [sview addSubview: btn2];

        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, sview.frame.size.width - 20, 25)];
        title.text = @"添加口味时用请逗号隔开";
        [sview addSubview: title];
        _kouweiTV = [[UITextView alloc]initWithFrame:CGRectMake(10, title.frame.size.height + title.frame.origin.y + 5, title.frame.size.width, line.frame.origin.y - 5 - title.frame.size.height - title.frame.origin.y - 10)];
        _kouweiTV.backgroundColor = backGgray;
        _kouweiTV.text = _kouwei.text;
        _kouweiTV.layer.cornerRadius = 5;
        [sview addSubview: _kouweiTV];
        _kouweiView = sview;
    }
    return NO;
}

//创建二级分类
- (void)creatSecondSort:(NSArray *)arr{
    _array = arr;
    _secondescrollview = [[UIScrollView alloc]initWithFrame:_sesviews.bounds];
    _secondescrollview.backgroundColor = [UIColor whiteColor];
    _secondescrollview.showsVerticalScrollIndicator = NO;
    [_sesviews addSubview: _secondescrollview];
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
        btn.frame = [self createBtnFrame:i andWidth:_sesviews.frame.size.width];
        [btn setTitle:arr[i][@"name"] forState:UIControlStateNormal];

        if (btn.titleLabel.text == _fenlei2) {
            [btn setTitleColor:Color forState:UIControlStateNormal];
            btn.layer.borderColor = Color.CGColor;
            btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            btn.backgroundColor = [UIColor whiteColor];
        }
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(secondechick:) forControlEvents:UIControlEventTouchUpInside];
        [_secondescrollview addSubview: btn];
        if (i == arr.count - 1) {
            _secondescrollview.contentSize = CGSizeMake(_sesviews.frame.size.width, btn.frame.origin.y + btn.frame.size.height + 5);
        }
    }

}

- (void)createBackGView{
    _backGView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _backGView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_backGView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_backGView];
}

- (void)tap:(UIGestureRecognizer *)gue{
    if (gue.view == _backGView) {
        if (!_isRemove) {
            [_backGView removeFromSuperview];
        }else{
            [_kouweiTV resignFirstResponder];
        }
    }
    if (gue.view == _imView) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //拍照
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                __block UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                ipc.delegate = self;
                ipc.allowsEditing = YES;
                [self presentViewController:ipc animated:YES completion:^{
                    ipc = nil;
                }];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            __block UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设置选择后的图片可被编辑，即可以选定任意的范围
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.navigationBar.tintColor = [UIColor whiteColor];
            picker.navigationBar.barTintColor = Color;
            [self presentViewController:picker animated:YES completion:^{
                picker = nil;
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//picker.delegate代理方法  选择完图片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *oldimage = [info valueForKey:UIImagePickerControllerEditedImage];
    UIImage *image = [oldimage fixOrientation];
    //放入全局队列中保存头像
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将头像写入沙盒
        _imageData = UIImageJPEGRepresentation(image, 0.5);
        [_imageData writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"store.png"] atomically:YES];
        _QrHas = YES;
    });
    _imageviews.image = image;
    //点击choose后跳转到前一页
    [self dismissViewControllerAnimated:YES completion:nil];
}

//返回按钮的位置
- (CGRect)createBtnFrame:(int) i  andWidth:(CGFloat) width{
    CGFloat wid = 5 + (width - 5.0 * 5) / 4;
    return CGRectMake(i % 4 * wid + 5, (30 + 5) * (i / 4), (width - 5.0 * 5) / 4, 30);
}

//一级分类按钮点击事件
- (void)sortChick:(UIButton *)sender{
    _fenlei = sender.titleLabel.text;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _selectBtn.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:Color forState:UIControlStateNormal];
    sender.layer.borderColor = Color.CGColor;
    sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    _selectBtn = sender;
    [self creatSecondSort:_firstSortArr[sender.tag][@"childs"]];
}

- (void)remove{
    [_backGView removeFromSuperview];
}

//口味确认按钮
- (void)chick{
    [_backGView removeFromSuperview];
    _kouwei.text = _kouweiTV.text;
}

//二级分类按钮触发事件
- (void)secondechick:(UIButton *)sender{
    [_backGView removeFromSuperview];
    _fenlei2 = sender.titleLabel.text;
    _sort.text = [_fenlei stringByAppendingString:[NSString stringWithFormat:@"--%@", sender.titleLabel.text]];
    _sortID = _array[sender.tag][@"id"];
    NSLog(@"点击的id %@  %@", _sortID, _array[sender.tag][@"name"]);
}

- (void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *userInfo = [note userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if (HEIGHT - height - 220 <= HEIGHT / 2 - 100 ) {
        _kouweiView.frame = CGRectMake(10, HEIGHT - height - 220, WIDHT - 20, 220);
    }

}

- (void)keyboardWillHide{
    _kouweiView.frame = CGRectMake(10, HEIGHT / 2 - 100, WIDHT - 20, 220);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//提交
- (void)commit{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //判断当前是上架还是下架
    if (_segment.selectedSegmentIndex == 0) {
        _segmentid = @"1";
    }else{
        _segmentid = @"-1";
    }
    //二维码中是否有图片
    NSArray *arr = _QrDic[@"img"];

    //口味 过滤掉中文逗号
//    NSString *str = [_kouwei.text stringByReplacingOccurrencesOfString:@"，" withString:@","];

    BOOL can ;
    if (_isQr) {
        //从扫码进来  _kouwei 为库存量
        if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            if ([_kouwei.text intValue] < [_yujingtf.text intValue]) {
                can = YES;
            }else{
                can = [_name.text isEqualToString:@""] || [_price.text isEqualToString:@""] || [_sort.text isEqualToString:@""] || !_QrHas || [_kouwei.text isEqualToString:@""];
            }
        }else{
            can = [_name.text isEqualToString:@""] || [_price.text isEqualToString:@""] || [_sort.text isEqualToString:@""] || !_QrHas;
        }
    }else{
        if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            if ([_kouwei.text intValue] < [_yujingtf.text intValue]) {
                can = YES;
            }else{
                can = [_name.text isEqualToString:@""] || [_price.text isEqualToString:@""] || [_sort.text isEqualToString:@""] || _imageData == nil || [_kouwei.text isEqualToString:@""];
            }
        }else{
            can = [_name.text isEqualToString:@""] || [_price.text isEqualToString:@""] || [_sort.text isEqualToString:@""] || _imageData == nil;
        }
    }

    if (can) {
        if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
            [SVProgressHUD showErrorWithStatus:@"分类，名称，价格，商品图片都不能为空, 预警值不能大于库存量！"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"分类，名称，价格，商品图片都不能为空"];
        }
    }else{
        [SVProgressHUD showWithStatus:@"提交中..."];
        NSDictionary *paramter = [NSDictionary dictionary];
        if (_isChange) {
            //进来修改
            if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
                paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"gid":_gid, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
            }else{
                paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"gid":_gid, @"barcode": _tiaoma.text, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
            }
        }else{
            //创建
            if (_isQr) {
                //如果扫二维码进来  如果无图
                if (arr.count == 0) {
                    //如果角色是供货商
                    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
                        paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                    }else{
                        paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"barcode": _tiaoma.text, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                    }
                }else{
                    //如果有图
                    NSString *str1 = arr[0];
                    for (int i = 1; i < arr.count; i++) {
                        str1 = [str1 stringByAppendingString:[NSString stringWithFormat:@",%@", arr[1]]];
                    }
                    if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]){
                        paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"img": str1, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                    }else{
                        paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"img": str1, @"barcode": _tiaoma.text, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                    }
                }
            }else{
                //如果角色是供货商
                if ([[_userdefaults valueForKey:@"userRole"] isEqualToString:@"供货商"]) {
                    paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                }else{
                    paramter = @{@"id":[_userdefaults valueForKey:@"userID"], @"token":[_userdefaults valueForKey:@"userToken"], @"shopid":[_userdefaults valueForKey:@"shopID"], @"name":_name.text, @"shopcatid":_sortID, @"price":_price.text, @"spec":_guige.text, @"description":_jieshaoTV.text, @"status":_segmentid, @"barcode": _tiaoma.text, @"stockCount": _kouwei.text, @"warning":_yujingtf.text};
                }
                
            }
        }

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:[TCServerSecret loginAndRegisterSecret:@"300103"] parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //如果二维码扫描后没有图片
            if (arr.count == 0) {
                [formData appendPartWithFileData:_imageData name:@"pic" fileName:@"store.png" mimeType:@"image/png"];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [[[[[str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""] stringByReplacingOccurrencesOfString:@"\'" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\t" withString:@""] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"添加商品返回信息%@", str);
            
            if ([dic[@"retValue"] intValue] == 1 || [dic[@"retValue"] intValue] == 2) {
                [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
    }
}

- (void)back{
    if (_isQr) {
        //如果二维码进来  让他pop到根目录
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _price){
        //控制长度
        
        const char * ch=[string cStringUsingEncoding:NSUTF8StringEncoding];
        if(*ch == 0)
            return YES;
        //字符0－9 和 .
        if( *ch != 46 && ( *ch<48 || *ch>57) )
            return NO;
        
        //有了小数点
        if([_price.text rangeOfString:@"."].length==1)
        {
            NSUInteger length=[textField.text rangeOfString:@"."].location;
            
            //小数点后面两位小数 且不能再是小数点
            if([[_price.text substringFromIndex:length] length]>2 || *ch ==46)   //3表示后面小数位的个数。。
                
                return NO;
        }
        
        return YES;
    }
       return YES;
}

#pragma mark -- 左边返回按钮
- (void)barButtonItemsao:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
