//
//  TCAddGoodsViewController.m
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/1/9.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCAddGoodsViewController.h"
#import "TCSpecifView.h"
#import "TZImagePickerController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TCShopsManaerViewController.h"
#import "TCSeleCateViewController.h" //选择品类
#import "ACSelectMediaView.h"

@interface TCAddGoodsViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,tapDelegete,TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    UIView *backView;
    UIView *gary_oneView;
    UIView *specbjView;
    NSInteger j;
}
@property (nonatomic, strong) UIScrollView *mainScroller; //创建的tableView
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) UILabel *texteLabel;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) LxGridViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) UILabel *seleCategorylabel;
@property (nonatomic, strong) NSData *shopPicData;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSMutableArray *picArr; //图片的数组
@property (nonatomic, strong) UIButton *saoCodeBtn;//上架按钮
@property (nonatomic, strong) UIButton *xiaCodeBtn;//下架按钮
@property (nonatomic, strong) UIButton *comleBtn;//完成按钮

@property (nonatomic, strong) UIView *gary_twoView;
@property (nonatomic, strong) UIView *gary_threeView;
@property (nonatomic, strong) UIView *back_twoBackView;
@property (nonatomic, strong) NSString *showQstr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeArr;
@property (nonatomic, strong) NSMutableArray *spectArr;//规格的数组
@property (nonatomic, weak) ACSelectMediaView *mediaView;
@property (nonatomic, assign) BOOL isGoodCateSelect;


@end

@implementation TCAddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.seleDic) {
        self.title = @"编辑商品";
    }else{
        self.title = @"添加商品";
    }
    self.view.backgroundColor = TCBgColor;
    self.userdefaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCatetongzhi:)name:@"addCatetongzhi" object:nil];
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //初始化十足
    _picArr = [NSMutableArray array];
    _spectArr = [NSMutableArray array];
    //创建滚动视图
    [self setUpScroller];
    //传值
//    [self setUpInfo];
    // Do any additional setup after loading the view.
}

//上一个页面返回来的值
- (void)setUpInfo {
    if (self.QrDic){
        NSString *picStr = self.QrDic[@"img"];
        if ([picStr isEqualToString:@""]) {
            
        }else{
            NSArray *arr = @[self.QrDic[@"img"]];
            _selectedPhotos = [NSMutableArray arrayWithArray:arr];
            _picArr = [NSMutableArray arrayWithArray:arr];
        }
    } else if (self.seleDic){
        self.idStr = self.seleDic[@"goodscateid"];
        NSArray *arr = self.seleDic[@"images"];
        for (int i = 0; i < arr.count; i++) {
            
            [_selectedPhotos addObject:arr[i][@"src"]];
            [_picArr addObject:arr[i][@"src"]];
        }
    }
}

//这里是商品的品类
- (void)addCatetongzhi:(NSNotification *)text{
    NSLog(@"%@ %@",text.userInfo[@"textOne"],text.userInfo[@"textTwo"]);
    self.idStr = [NSString stringWithFormat:@"%@",text.userInfo[@"textTwo"]];
    self.seleCategorylabel.text = text.userInfo[@"textOne"];
    self.isGoodCateSelect = YES;
}
//创建View
- (void)setUpScroller
{
    //创建滚动视图
    _mainScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _mainScroller.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    _mainScroller.delegate = self;
    _mainScroller.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview: _mainScroller];
    //创建第一块的视图
    NSArray *title_oneArr = @[@"商品名称",@"商品条码",@"品类"];
    NSArray *placeArr = @[@"输入商品名称（1-20字）",@"填写商品条形码（选填）"];
    for (int i = 0; i < title_oneArr.count; i ++) {
        UILabel *title_oneLabel = [UILabel publicLab:title_oneArr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
        title_oneLabel.frame = CGRectMake(15, 45*i, 60, 45);
        [_mainScroller addSubview:title_oneLabel];
        
        //线
        UIView *line_oneView = [[UIView alloc] init];
        line_oneView.backgroundColor = TCBgColor;
        line_oneView.frame = CGRectMake(15, 45 + 45*i, WIDHT - 15, 1);
        [_mainScroller addSubview:line_oneView];
        
        if (i < 2){
            //输入框
            UITextField *textfield = [[UITextField alloc]init];
            textfield.frame = CGRectMake(CGRectGetMaxX(title_oneLabel.frame) + 10, 45*i, WIDHT - 15 - (CGRectGetMaxX(title_oneLabel.frame) + 10), 45);
            textfield.font = [UIFont systemFontOfSize:15];
            [textfield addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
            textfield.delegate = self;
            textfield.textAlignment = NSTextAlignmentRight;
            textfield.placeholder = placeArr[i];
            textfield.tag = 100 + i;
            textfield.returnKeyType = UIReturnKeyDone;//变为搜索按钮
            textfield.textColor = TCUIColorFromRGB(0x333333);
            [_mainScroller addSubview:textfield];
            //选中商品进来的
            if (i == 0) {
                if (self.seleDic) {
                    textfield.text = [NSString stringWithFormat:@"%@",self.seleDic[@"name"]];
                } else if (self.QrDic) {
                    textfield.text = self.QrDic[@"name"];
                }
            } else if (i == 1) {
//                textfield.keyboardType = UIKeyboardTypeNumberPad;
                if (self.seleDic) {
                    textfield.text = [NSString stringWithFormat:@"%@",self.seleDic[@"barcode"]];
                } else if (self.codeStr) {
                    textfield.text = self.codeStr;
                }
            }
        } else {
            self.seleCategorylabel = [UILabel publicLab:@"选择商品品类" textColor:TCUIColorFromRGB(0x53C3C3) textAlignment:NSTextAlignmentRight fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
            self.seleCategorylabel.frame = CGRectMake(CGRectGetMaxX(title_oneLabel.frame), 45 * 2, WIDHT - 40 - CGRectGetMaxX(title_oneLabel.frame), 45);
            self.seleCategorylabel.userInteractionEnabled = YES;
            if (self.seleDic) {
                self.seleCategorylabel.text = self.seleDic[@"goodscatename"];
            }
            [_mainScroller addSubview:self.seleCategorylabel];
            //加手势
            UITapGestureRecognizer *tapCate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCate)];
            [self.seleCategorylabel addGestureRecognizer:tapCate];
            
            //三角图标
            UIImageView *imageSan = [[UIImageView alloc] init];
            imageSan.image = [UIImage imageNamed:@"进入小三角（灰）"];
            imageSan.frame = CGRectMake(CGRectGetMaxX(self.seleCategorylabel.frame) + 20, (45 - 8)/2 + 45 *2, 5, 8);
            [_mainScroller addSubview:imageSan];
        }
    }
        //小灰框
        gary_oneView = [[UIView alloc] init];
        gary_oneView.frame = CGRectMake(0, 45 *3, WIDHT, 10);
        gary_oneView.backgroundColor = TCBgColor;
        [_mainScroller addSubview:gary_oneView];
        //第二个大段,添加图片
        backView = [[UIView alloc] init];
        backView.frame = CGRectMake(0, CGRectGetMaxY(gary_oneView.frame), WIDHT, 19);
        backView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [_mainScroller addSubview:backView];
        //图片的title
        UILabel *title_twoLabel = [UILabel publicLab:@"商品图片" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        title_twoLabel.frame = CGRectMake(15, 15, 56, 14);
        [backView addSubview:title_twoLabel];
        //
        UILabel *title_disLabel = [UILabel publicLab:@"(最多上传9张)" textColor:TCUIColorFromRGB(0x9F9D9B) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:12 numberOfLines:0];
        title_disLabel.frame = CGRectMake(CGRectGetMaxX(title_twoLabel.frame), 17, 90, 12);
        [backView addSubview:title_disLabel];
        //1、得到默认布局高度（唯一获取高度方法）
        CGFloat height = [ACSelectMediaView defaultViewHeight];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame) + 15, self.view.bounds.size.width, height)];
        //灰框
        UIView *gary_twoView = [[UIView alloc] init];
        self.gary_twoView = gary_twoView;
        gary_twoView.frame = CGRectMake(0, CGRectGetMaxY(bgView.frame), WIDHT, 10);
        gary_twoView.backgroundColor = TCBgColor;
        
        specbjView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gary_twoView.frame), WIDHT, 180 + 45)];
        specbjView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        //商品规格
        UILabel *title_threeLabel = [UILabel publicLab:@"商品信息" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
        title_threeLabel.frame = CGRectMake(15, 0, 74, 44);
        //细线
        UIView *lineTitle = [[UIView alloc] init];
        lineTitle.frame = CGRectMake(0, CGRectGetMaxY(title_threeLabel.frame), WIDHT, 1);
        lineTitle.backgroundColor = TCBgColor;
        
        //for
        NSArray *arr = @[@"降序排序（0-9999）",@"规格",@"价格",@"库存"];
        NSArray *plArr = @[@"",@"添加商品规格",@"设置商品价格",@"设置库存数"];
        for (int i = 0; i < arr.count; i ++) {
            UILabel *title_Label = [UILabel publicLab:arr[i] textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
            title_Label.frame = CGRectMake(15, CGRectGetMaxY(title_threeLabel.frame) + 45*i, WIDHT/2, 45);
            [specbjView addSubview:title_Label];
            //
            UITextField *mess_field = [[UITextField alloc]init];
            mess_field.frame = CGRectMake(CGRectGetMaxX(title_Label.frame) + 10, CGRectGetMaxY(title_threeLabel.frame) + 45*i, WIDHT - 15 - (CGRectGetMaxX(title_Label.frame) + 10), 45);
            mess_field.font = [UIFont systemFontOfSize:15];
            mess_field.textAlignment = NSTextAlignmentRight;
            [mess_field addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
            mess_field.placeholder = plArr[i];
            mess_field.tag = 1000 + i;
            mess_field.delegate = self;
            mess_field.returnKeyType = UIReturnKeyDone;//变为搜索按钮
            mess_field.textColor = TCUIColorFromRGB(0x333333);
            [specbjView addSubview:mess_field];
            
            if (i == 0){
                UIButton *add_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                [add_btn setBackgroundImage:[UIImage imageNamed:@"加商品"] forState:(UIControlStateNormal)];
                add_btn.frame = CGRectMake(WIDHT - 20 - 15, (45 - 20)/2 + 45, 20, 20);
                [add_btn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
                [specbjView addSubview:add_btn];
                
                mess_field.frame = CGRectMake(WIDHT - 35 - 8 - 40, 45, 40, 45);
                mess_field.textAlignment = NSTextAlignmentCenter;
                mess_field.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                mess_field.text = @"50";
                UIButton *cut_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                [cut_btn setBackgroundImage:[UIImage imageNamed:@"减商品"] forState:(UIControlStateNormal)];
                cut_btn.frame = CGRectMake(WIDHT - 20 - 15 - 40 - 16 - 20, (45 - 20)/2 + 45, 20, 20);
                [cut_btn addTarget:self action:@selector(cutClick:) forControlEvents:(UIControlEventTouchUpInside)];
                [specbjView addSubview:cut_btn];
            }
            //线
            UIView *line_View = [[UIView alloc] init];
            line_View.backgroundColor = TCBgColor;
            line_View.frame = CGRectMake(15, CGRectGetMaxY(title_threeLabel.frame) + 45 + 45*i, WIDHT - 15, 1);
            [specbjView addSubview:line_View];
            //选中商品进来的
            if (self.seleDic) {
                [_spectArr addObjectsFromArray:self.seleDic[@"speclists"]];
                
                if (i == 0) {
                    mess_field.text = [NSString stringWithFormat:@"%@",self.seleDic[@"sort"]];
                } else if (i == 1) {
                    mess_field.text = [NSString stringWithFormat:@"%@",_spectArr[0][@"spec"]];
                }else if (i == 2) {
                    mess_field.text = [NSString stringWithFormat:@"%@",_spectArr[0][@"price"]];
                }else if (i == 3){
                    mess_field.text = [NSString stringWithFormat:@"%@",_spectArr[0][@"stockCount"]];
                }
            }
            
            //扫码进来的
            if (self.QrDic){
                if (i == 1){
                    mess_field.text = self.QrDic[@"spec"];
                } else if (i== 2){
                    mess_field.text = self.QrDic[@"price"];
                }
          }
    }
    
    // 小灰框
    UIView *gary_threeView = [[UIView alloc] init];
    self.gary_threeView = gary_threeView;
    gary_threeView.frame = CGRectMake(0, CGRectGetMaxY(specbjView.frame), WIDHT, 10);
    gary_threeView.backgroundColor = TCBgColor;
    [_mainScroller addSubview:gary_threeView];
    
    //创建view
    UIView *back_twoBackView = [[UIView alloc] init];
    self.back_twoBackView = back_twoBackView;
    back_twoBackView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    back_twoBackView.frame = CGRectMake(0, CGRectGetMaxY(gary_threeView.frame), WIDHT, 180);
    [_mainScroller addSubview:back_twoBackView];
    //title
    UILabel *titleBack = [UILabel publicLab:@"商品文字描述" textColor:TCUIColorFromRGB(0x333333) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:15 numberOfLines:0];
    titleBack.frame = CGRectMake(15, 15, 100, 15);
    [back_twoBackView addSubview:titleBack];
    //textView的灰框
    UIView *GaryTextView = [[UIView alloc] init];
    GaryTextView.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    GaryTextView.frame = CGRectMake(15, CGRectGetMaxY(titleBack.frame) + 10, WIDHT - 30, 120);
    [back_twoBackView addSubview:GaryTextView];
    
    self.textview = [[UITextView alloc]init];
    self.textview.frame = CGRectMake(3, 3, WIDHT - 30 - 20, 100);
    self.textview.delegate = self;
    self.textview.returnKeyType = UIReturnKeyDone;//变为搜索按钮
    self.textview.textColor = TCUIColorFromRGB(0x333333);
    self.textview.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.textview.backgroundColor = TCUIColorFromRGB(0xF5F5F5);
    
    if (self.seleDic){
        self.textview.text = self.seleDic[@"description"];
    }else if (self.QrDic){
        self.textview.text = self.QrDic[@"description"];
    }
    [GaryTextView addSubview:self.textview];
    
    //添加label
    self.texteLabel = [[UILabel alloc]init];
    self.texteLabel.frame = CGRectMake(10, 10, WIDHT - 30 - 20, 100);
    self.texteLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.texteLabel.text = @"请简单的描述该商品";
    self.texteLabel.textColor = TCUIColorFromRGB(0xC4C4C4);
    self.texteLabel.numberOfLines = 0;
    [self.texteLabel sizeToFit];
    [GaryTextView addSubview:self.texteLabel];
    
    if (self.textview.text.length > 0) {
        self.texteLabel.hidden = YES;
    }else{
        self.texteLabel.hidden = NO;
    }
    //上架出售和放入下架库
    UIButton *saoCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saoCodeBtn = saoCodeBtn;
    saoCodeBtn.frame = CGRectMake(15, CGRectGetMaxY(back_twoBackView.frame) + 40, 155, 48);
    [saoCodeBtn setTitle:@"上架出售" forState:UIControlStateNormal];
    [saoCodeBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    saoCodeBtn.layer.cornerRadius = 5;
    saoCodeBtn.userInteractionEnabled = YES;
    saoCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    saoCodeBtn.layer.masksToBounds = YES;
    saoCodeBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    saoCodeBtn.alpha = 1;
    saoCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [saoCodeBtn addTarget:self action:@selector(saoCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroller addSubview:saoCodeBtn];
    
    UIButton *xiaCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xiaCodeBtn = xiaCodeBtn;
    xiaCodeBtn.frame = CGRectMake(WIDHT - 15 - 155, CGRectGetMaxY(back_twoBackView.frame) + 40, 155, 48);
    [xiaCodeBtn setTitle:@"放入下架库" forState:UIControlStateNormal];
    [xiaCodeBtn setTitleColor:TCUIColorFromRGB(0x53C3C3) forState:UIControlStateNormal];
    xiaCodeBtn.layer.cornerRadius = 5;
    xiaCodeBtn.layer.borderWidth = 1;
    xiaCodeBtn.alpha = 1;
    xiaCodeBtn.userInteractionEnabled = YES;
    xiaCodeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    xiaCodeBtn.layer.borderColor = TCUIColorFromRGB(0x53C3C3).CGColor;
    xiaCodeBtn.layer.masksToBounds = YES;
    xiaCodeBtn.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    xiaCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [xiaCodeBtn addTarget:self action:@selector(xiaCodeBtnBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroller addSubview:xiaCodeBtn];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.comleBtn = completeBtn;
    completeBtn.frame = CGRectMake(15, CGRectGetMaxY(back_twoBackView.frame) + 40, WIDHT - 30, 48);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    completeBtn.layer.cornerRadius = 5;
    completeBtn.userInteractionEnabled = YES;
    completeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    completeBtn.layer.masksToBounds = YES;
    completeBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    completeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [completeBtn addTarget:self action:@selector(completeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroller addSubview:completeBtn];
    
    if (self.seleDic && ![self.typeStr isEqualToString:@"2"]) {
        saoCodeBtn.hidden = YES;
        xiaCodeBtn.hidden = YES;
        completeBtn.hidden = NO;
        _mainScroller.contentSize = CGSizeMake(WIDHT, CGRectGetMaxY(completeBtn.frame) + 20);
    } else {
        saoCodeBtn.hidden = NO;
        xiaCodeBtn.hidden = NO;
        completeBtn.hidden = YES;
        _mainScroller.contentSize = CGSizeMake(WIDHT, CGRectGetMaxY(xiaCodeBtn.frame) + 20);
    }
    //2、初始化
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
    mediaView.showDelete = NO;
    mediaView.showAddButton = NO;
    
    if (self.seleDic) {
        mediaView.preShowMedias = self.goodsImageArr;
        _picArr = self.goodsImageArr;
    }
    mediaView.allowMultipleSelection = NO;
    mediaView.allowPickingVideo = NO;
    mediaView.showAddButton = YES;
    mediaView.showDelete = YES;
    self.mediaView = mediaView;
    
    //3、随时获取新的布局高度
    [mediaView observeViewHeight:^(CGFloat value) {
        bgView.height = value;
        gary_twoView.frame = CGRectMake(0, CGRectGetMaxY(bgView.frame), WIDHT, 10);
        specbjView.frame = CGRectMake(0, CGRectGetMaxY(self.gary_twoView.frame), WIDHT, 180 + 45);
        gary_threeView.frame = CGRectMake(0, CGRectGetMaxY(specbjView.frame), WIDHT, 10);
        back_twoBackView.frame = CGRectMake(0, CGRectGetMaxY(gary_threeView.frame), WIDHT, 180);
        saoCodeBtn.frame = CGRectMake(15, CGRectGetMaxY(back_twoBackView.frame) + 40, 155, 48);
        xiaCodeBtn.frame = CGRectMake(WIDHT - 15 - 155, CGRectGetMaxY(back_twoBackView.frame) + 40, 155, 48);
        completeBtn.frame = CGRectMake(15, CGRectGetMaxY(back_twoBackView.frame) + 40, WIDHT - 30, 48);
        _mainScroller.contentSize = CGSizeMake(WIDHT, CGRectGetMaxY(xiaCodeBtn.frame) + 20);
        _mainScroller.contentSize = CGSizeMake(WIDHT, CGRectGetMaxY(completeBtn.frame) + 20);
    }];
    //4、随时获取已经选择的媒体文件
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        for (ACMediaModel *model in list) {
            NSLog(@"%@",model.name);
            self.shopPicData = model.uploadType;
            
            //上传图片到
            [self goodsPicRequest:self.shopPicData];
        }
    }];
    [bgView addSubview:mediaView];
    [self.mainScroller addSubview:bgView];
    [_mainScroller addSubview:gary_twoView];
    [_mainScroller addSubview:specbjView];
    [specbjView addSubview:title_threeLabel];
    [specbjView addSubview:lineTitle];
}

- (void)alueChange:(UITextField *)textField{

    if (textField.tag-1000 >= 0) {
        //开始编辑时使整个视图整体向上移
        [UIView beginAnimations:@"up" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame = CGRectMake(0, -(textField.tag-1000) - 140, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }

        self.saoCodeBtn.userInteractionEnabled = YES;
        self.saoCodeBtn.alpha = 1;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextField *onetextField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *sortTextField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *priceTextField = (UITextField *)[self.view viewWithTag:1002];
    UITextField *kunTextField = (UITextField *)[self.view viewWithTag:1003];
    UITextField *goodsNamefield = (UITextField *)[self.view viewWithTag:100];
    UITextField *codesfield = (UITextField *)[self.view viewWithTag:101];
    
    NSString *String = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (onetextField == textField) {
        if (String.length > 4) {
            textField.text = [String substringToIndex:4];
            return NO;
        }
        if (String.length > 1){
           unichar single = [String characterAtIndex:0];//当前输入的字符
            if (single == '0') {
                [TCProgressHUD showMessage:@"亲，第一个数字不能为0!"];
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                
                return NO;
            }
        }
    } else if (goodsNamefield == textField) {
        if (String.length > 20) {
            textField.text = [String substringToIndex:20];
            return NO;
        }
    } else if (codesfield == textField) {
        if (String.length > 20) {
            textField.text = [String substringToIndex:20];
            return NO;
        }
    } else if (sortTextField == textField) {
        if (String.length > 20) {
            textField.text = [String substringToIndex:20];
            return NO;
        }
    } else if (priceTextField == textField) {
        if (String.length > 8) {
            textField.text = [String substringToIndex:8];
        }
        if ([textField.text intValue] > 999999.99) {
            textField.text = [String substringToIndex:6];
            [TCProgressHUD showMessage:@"亲，超过最大值"];
            return NO;
        }
    } else if (kunTextField == textField) {
        if (String.length > 4) {
            textField.text = [String substringToIndex:4];
            return NO;
        }
    }
    return YES;
}

#pragma -mark UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:@"up" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = CGRectMake(0, - 100 - 216, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    //结束编辑时整个试图返回原位
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = self.view.bounds;
    [UIView commitAnimations];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = self.view.bounds;
    [UIView commitAnimations];
    
    UITextField *goodsNamefield = (UITextField *)[self.view viewWithTag:100];
    UITextField *codesfield = (UITextField *)[self.view viewWithTag:101];
    
    UITextField *onetextField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *twotextField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *threetextField = (UITextField *)[self.view viewWithTag:1002];
    UITextField *fourtextField = (UITextField *)[self.view viewWithTag:1003];
    
    [goodsNamefield resignFirstResponder];
    [codesfield resignFirstResponder];
    [onetextField resignFirstResponder];
    [twotextField resignFirstResponder];
    [threetextField resignFirstResponder];
    [fourtextField resignFirstResponder];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    //结束编辑时整个试图返回原位
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = self.view.bounds;
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        //结束编辑时整个试图返回原位
        [UIView beginAnimations:@"down" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame = self.view.bounds;
        [UIView commitAnimations];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
//判断开始输入
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length > 0){
        self.texteLabel.hidden = YES;
    }else{
        self.texteLabel.hidden = NO;
    }
}

#pragma mark -- saoCodeBtnClicked
- (void)saoCodeBtnClicked:(UIButton *)sender
{
    if ([self.seleCategorylabel.text isEqualToString:@"选择商品品类"]) {
        [TCProgressHUD showMessage:@"请选择商品品类"];
    }else{
        [self createQuest:@"0"];
    }
}

- (void)xiaCodeBtnBtnClicked:(UIButton *)sender
{
    if ([self.seleCategorylabel.text isEqualToString:@"选择商品品类"]) {
        [TCProgressHUD showMessage:@"请选择商品品类"];
    }else{
        [self createQuest:@"1"];
    }
}

- (void)completeBtnClicked:(UIButton *)sender {
    if ([self.typeStr isEqualToString:@"1"]) {
        [self createQuest:@"0"];
    } else if ([self.typeStr isEqualToString:@"2"]) {
        [self createQuest:@"2"];
    } else if ([self.typeStr isEqualToString:@"3"]) {
        [self createQuest:@"1"];
    }
}

#pragma mark -- 上架和下架
- (void)createQuest:(NSString *)status
{
    UITextField *goodsNamefield = (UITextField *)[self.view viewWithTag:100];
    UITextField *codesfield = (UITextField *)[self.view viewWithTag:101];

    UITextField *onetextField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *twotextField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *threetextField = (UITextField *)[self.view viewWithTag:1002];
    UITextField *fourtextField = (UITextField *)[self.view viewWithTag:1003];
    
    if (goodsNamefield.text.length == 0 || codesfield.text.length == 0 || onetextField.text.length == 0 || twotextField.text.length == 0 || threetextField.text.length == 0 || fourtextField.text.length == 0) {
        [TCProgressHUD showMessage:@"请检查并填写完整信息"];
    } else if (![BSUtils inputShouldNumber:codesfield.text]) {
        [TCProgressHUD showMessage:@"请输入数字商品条形码"];
    }
    else if (_picArr.count == 0) {
        [TCProgressHUD showMessage:@"请添加商品图片"];
    }  else {

        //商品规格的json
        NSMutableArray *commitArr = [NSMutableArray array];
        NSDictionary *jsonDic = @{@"spec":twotextField.text,@"price":threetextField.text,@"stockCount":fourtextField.text};
        [commitArr addObject:jsonDic];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commitArr options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strs = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        //图片的json
        NSDictionary *jsonPicDic;
        for (int i = 0; i < _picArr.count; i++) {
            jsonPicDic = @{@"shop_image":_picArr[i]};
        }
        NSString *strData = [self convertToJsonData:jsonPicDic];
        NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *midStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userID"]];
        NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userToken"]];
        NSString *textViewStr;
        if (self.textview.text.length == 0) {
            textViewStr = @"0";
        } else {
            textViewStr = self.textview.text;
        }
        
        NSString *goodsid;
        if (self.seleDic) {
            goodsid = [NSString stringWithFormat:@"%@",self.seleDic[@"goodsid"]];
            if (self.isGoodCateSelect == NO) {
                self.idStr = [NSString stringWithFormat:@"%@",self.seleDic[@"goodscateid"]];
            }
        } else {
            goodsid = @"0";
        }

        NSDictionary *dic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"shopId":shopID,@"goodsName":goodsNamefield.text,@"goodsCateId":self.idStr,@"specs":strs,@"status":status,@"imgName":strData,@"goodsId":goodsid,@"description":textViewStr,@"sort":onetextField.text,@"barcode":codesfield.text};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *parameters = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"shopId":shopID,@"goodsName":goodsNamefield.text,@"goodsCateId":self.idStr,@"specs":strs,@"status":status,@"imgName":strData,@"sign":singStr,@"goodsId":goodsid,@"description":textViewStr,@"sort":onetextField.text,@"barcode":codesfield.text};
        //上架or下架
        NSString *netStr;
        if (self.seleDic) {
            netStr = @"202013";
        } else {
            netStr = @"202011";
        }
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:netStr] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                if (self.isQr == YES) {
                    //复制就能用
                    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",jsonDic[@"msg"]]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhishuaxin" object:nil];
            } else {
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            [TCProgressHUD showMessage:[NSString stringWithFormat:@"%@",jsonDic[@"msg"]]];
        }];
    }
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSLiteralSearch range:range3];

    return mutStr;
}

#pragma mark x
- (void)tapCate{
    NSLog(@"选择品类");
    TCSeleCateViewController *seleVC = [[TCSeleCateViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seleVC animated:YES];
}

#pragma mark -- 加商品排序
- (void)addClick:(UIButton *)sender
{
    UITextField *textfield = (UITextField *)[self.view viewWithTag:1000];
    int count = [textfield.text intValue];
    count++;
    if (count > 9999){
        [TCProgressHUD showMessage:@"超过排序最大值"];
    } else {
        textfield.text = [NSString stringWithFormat:@"%d",count];
    }
}

#pragma mark -- 减商品排序
- (void)cutClick:(UIButton *)sender
{
    UITextField *textfield = (UITextField *)[self.view viewWithTag:1000];
    int count = [textfield.text intValue];
    count--;
    if (count < 0){
        [TCProgressHUD showMessage:@"不能少于排序最小值"];
    } else {
        textfield.text = [NSString stringWithFormat:@"%d",count];
    }
}

#pragma mark -- 循环上传图片
- (void)goodsPicRequest:(NSData *)PicData
{
    //    [_picArr removeAllObjects];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *shopID = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"shopId":shopID};
    NSString *singStr = [TCServerSecret signStr:dic];
    
    NSDictionary *parameters = @{@"shopId":shopID,@"sign":singStr};
    NSDictionary *dicc = [TCServerSecret report:parameters];
    
    //提交修改，上传图片至服务器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecretOffline:@"202012"] parameters:dicc constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //开始滚动
        if (PicData) {
            [formData appendPartWithFileData:PicData  name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"提交图片的返回结果 %@", dic[@"msg"]);
        NSString *codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        // 把图片地址保存到数组中
        
        if ([codeStr isEqualToString:@"1"]) {
            [_picArr addObject:dic[@"data"][@"url"]];
            NSLog(@"%@------------",_picArr);
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
}
#pragma mark -- 规格点击
- (void)sendValue:(NSString *)tagStr andName:(NSString *)nameStr
{
    NSLog(@"%@",tagStr);
    self.seleCategorylabel.text = nameStr;
    self.idStr = tagStr;
}


@end
