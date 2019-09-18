//
//  TCSJTJViewController.m
//  顺道嘉(新)
//
//  Created by 某某 on 16/10/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TCSJTJViewController.h"
#import "TCExamplesViewController.h"
#import "SGImagePickerController.h"
#import "TCShopManagerViewController.h"

@interface TCSJTJViewController ()<UIScrollViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UIScrollView *mainscrollview;
@property (nonatomic, strong) NSString *numid;//接收身份证信息
@property (nonatomic, strong) NSString *name;//接收姓名
@property (nonatomic, strong) NSString *telnum;//接收电话
@property (nonatomic, strong) NSString *add;//接收地址信息
//身份证
@property (nonatomic, strong) UITextField *userTF;
//电话号码
@property (nonatomic, strong) UITextField *phoneNum;
//姓名
@property (nonatomic, strong) UITextField *nameTF;
//详细地址
@property (nonatomic, strong) UITextField *ncNameTF;
@property (nonatomic, strong) UIView *tipview2;
@property (nonatomic, strong) UILabel *lbtitle;
@property (nonatomic, strong) UIButton *btns;
@property (nonatomic, strong) NSString *isauth;//判断是否通过标志
@property (nonatomic, strong) UIImageView *photoimageview;
@property (nonatomic, strong) UIView *messShowView;//跳出的信息展示框
@property (nonatomic, strong) UIView *mainviews;//添加图片的view
//判断是否已经选择图片
@property (nonatomic, assign) BOOL isphoto;

@end

@implementation TCSJTJViewController
- (void)viewWillAppear:(BOOL)animated
{
    if (self.iszhuce){
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = Color;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         
         @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
           
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        if (self.tiaozhuan){
            // 删除导航栏左侧按钮
            self.navigationItem.leftBarButtonItem = nil;
            
        } else {
            //左边导航栏的按钮
            UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12*WIDHTSCALE, 20*HEIGHTSCALE)];
            // Add your action to your button
            [leftButton addTarget:self action:@selector(barButtonItemsao:) forControlEvents:UIControlEventTouchUpInside];
            [leftButton setBackgroundImage:[UIImage imageNamed:@"白"] forState:(UIControlStateNormal)];
            UIBarButtonItem *barleftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
            self.navigationItem.leftBarButtonItem = barleftBtn;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.navigationItem.title = @"完善信息";
    _photoArr = [NSMutableArray array];
    _show = YES;

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(messageShow)];
    self.navigationItem.rightBarButtonItem = right;
    right.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];

    if (self.iszhuce && self.tiaozhuan) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismis)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = BtnTitleColor;
    }
    

    //创建scrollview
    _mainscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _mainscrollview.backgroundColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3];
    _mainscrollview.contentSize = CGSizeMake(WIDHT, HEIGHT);
    _mainscrollview.delegate = self;
    _mainscrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainscrollview];

    CGRect frame = _mainscrollview.bounds;
    UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 10 * HEIGHTSCALE, frame.size.width , 210 * HEIGHTSCALE)];
    tview.layer.cornerRadius = 1;//圆角
    tview.alpha = 1;//透明度
    tview.backgroundColor = [UIColor whiteColor];
    [_mainscrollview addSubview:tview];

    //身份证text
    UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, 25 * HEIGHTSCALE - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
    im1.backgroundColor = mainColor;
    im1.image = [UIImage imageNamed:@"身份证图标11.png"];
    [tview addSubview: im1];

    _userTF = [[UITextField alloc]initWithFrame:CGRectMake(im1.frame.origin.x + im1.frame.size.width + 10 * WIDHTSCALE, 0, WIDHT - im1.frame.origin.x - im1.frame.size.width - 10 * WIDHTSCALE - 20 * WIDHTSCALE, 50 * HEIGHTSCALE)];
    self.userTF.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];
    //设置一键清楚输入内容按钮
    self.userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (self.iszhuce){
        self.userTF.userInteractionEnabled = YES;
    } else {
        self.userTF.text = _mesdic[@"data"][@"idno"];
        self.userTF.userInteractionEnabled = NO;
    }
    //横线1
    UIImageView *lineImageview = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, _userTF.frame.origin.y + _userTF.frame.size.height, tview.frame.size.width - 40 * WIDHTSCALE, 1)];
    lineImageview.backgroundColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3];
    [tview addSubview: lineImageview];


    //姓名text
    UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, lineImageview.frame.origin.y + 1 + 25 * HEIGHTSCALE - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
    im2.image = [UIImage imageNamed:@"姓名图标11.png"];
    [tview addSubview: im2];
    _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(im2.frame.origin.x + im2.frame.size.width + 10 * WIDHTSCALE, lineImageview.frame.origin.y + lineImageview.frame.size.height, frame.size.width - im2.frame.origin.x - im2.frame.size.width - 10 * WIDHTSCALE - 20 * WIDHTSCALE, 50 * HEIGHTSCALE)];
    self.nameTF.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];


    //横线2
    UIImageView *lineImageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, _nameTF.frame.origin.y + _nameTF.frame.size.height, tview.frame.size.width - 40 * WIDHTSCALE, 1)];
    lineImageview2.backgroundColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3];
    [tview addSubview: lineImageview2];


    //电话号码
    UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, lineImageview2.frame.origin.y + 1 + 25 * HEIGHTSCALE - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
    im3.image = [UIImage imageNamed:@"联系方式图标11.png"];
    [tview addSubview: im3];
    self.phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(im3.frame.origin.x + im3.frame.size.width + 10 * WIDHTSCALE, lineImageview2.frame.origin.y + lineImageview2.frame.size.height, frame.size.width - im3.frame.origin.x - im3.frame.size.width - 10 * WIDHTSCALE - 20 * WIDHTSCALE, 50 * HEIGHTSCALE)];
    self.phoneNum.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    
    //注册
    if (self.iszhuce) {
        self.phoneNum.userInteractionEnabled = YES;
    } else {
        self.phoneNum.text = _mesdic[@"data"][@"mobile"];
        self.phoneNum.userInteractionEnabled = NO;
    }

    //横线3
    UIImageView *lineImageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, _phoneNum.frame.origin.y + _phoneNum.frame.size.height, tview.frame.size.width - 40 * WIDHTSCALE, 1)];
    lineImageview3.image = [UIImage imageNamed:@""];
    lineImageview3.backgroundColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3];
    [tview addSubview: lineImageview3];


    //详细地址
    UIImageView *im4 = [[UIImageView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, lineImageview3.frame.origin.y + 1 + 25 * HEIGHTSCALE - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
    im4.image = [UIImage imageNamed:@"家庭住址图标11.png"];
    [tview addSubview: im4];
    self.ncNameTF = [[UITextField alloc]initWithFrame:CGRectMake(im4.frame.origin.x + im4.frame.size.width + 10 * WIDHTSCALE, lineImageview3.frame.origin.y + lineImageview3.frame.size.height, frame.size.width - im4.frame.origin.x - im4.frame.size.width - 10 * WIDHTSCALE - 20 * WIDHTSCALE, 50 * HEIGHTSCALE)];
    self.ncNameTF.font = [UIFont systemFontOfSize:16 * HEIGHTSCALE];



    //判断屏幕的高度小余 550 要移动view
    if ([UIScreen mainScreen].applicationFrame.size.height < 550) {
        self.ncNameTF.delegate = self;
    }

    tview.userInteractionEnabled = YES;
    //添加到页面上
    [tview addSubview:self.userTF];
    [tview addSubview:self.nameTF];
    [tview addSubview:self.phoneNum];
    [tview addSubview:self.ncNameTF];

    _userTF.placeholder = @"请输入商家的身份证号码";
    _nameTF.placeholder = @"请输入商家的姓名";
    _phoneNum.placeholder = @"请输入商家的联系方式";
    _ncNameTF.placeholder = @"请输入商家的地址";

    tview.frame = CGRectMake(0, 10 * HEIGHTSCALE, frame.size.width , _ncNameTF.frame.origin.y + _ncNameTF.frame.size.height);


    //创建贴士
    UIView *tipview = [[UIView alloc]initWithFrame:CGRectMake(10 * WIDHTSCALE, tview.frame.size.height + 20 * HEIGHTSCALE, WIDHT - 20 * HEIGHTSCALE, 150 * HEIGHTSCALE)];
    tipview.layer.cornerRadius = 10 * HEIGHTSCALE;
    tipview.backgroundColor = [UIColor whiteColor];
    _tipview2 = tipview;
    [_mainscrollview addSubview:tipview];
    //创建tip内容
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10 * WIDHTSCALE, 10 * HEIGHTSCALE, WIDHT / 2, 15 * HEIGHTSCALE)];
    lb1.text = @"注意:";
    lb1.font = [UIFont systemFontOfSize: 15 * HEIGHTSCALE];
    lb1.textColor = [UIColor orangeColor];
    [tipview addSubview:lb1];

    _lbtitle = [[UILabel alloc]initWithFrame:CGRectMake(50 * WIDHTSCALE, 20 * HEIGHTSCALE, tipview.frame.size.width - 50 * WIDHTSCALE - 15 * WIDHTSCALE, (150 - 30) * HEIGHTSCALE)];
    _lbtitle.font = [UIFont systemFontOfSize:14 * HEIGHTSCALE];
    _lbtitle.textColor = [UIColor orangeColor];
    _lbtitle.numberOfLines = 0;
    _lbtitle.text = @"为了更好的保障您的合法权益，请上传您的相关证件：包括身份证正反面，营业执照等证件。证件通过审核后不能自行修改，如若修改需联系客服人员，待确认无误后方可更改。请您在上传时仔细检查证件信息，确认清晰无误后再上传。";
    [tipview addSubview:_lbtitle];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10 * WIDHTSCALE, tipview.frame.origin.y + tipview.frame.size.height + 10 * HEIGHTSCALE, 100 * WIDHTSCALE, 30 * HEIGHTSCALE);
    [btn setTitle:@"查看证件照模板" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5 * HEIGHTSCALE;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:12 * HEIGHTSCALE];
    btn.backgroundColor = mainColor;
    [btn setTitleColor:BtnTitleColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(muban) forControlEvents:UIControlEventTouchUpInside];
    _btns = btn;
    [_mainscrollview addSubview: btn];

    [self createPhoto];
}

//查看证件照模板
- (void)muban{
    TCExamplesViewController *example = [[TCExamplesViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:example animated:YES];
}



- (void)createPhoto{
    //添加相片
    _mainviews = [[UIView alloc]initWithFrame:CGRectMake(10 * WIDHTSCALE,  _btns.frame.origin.y + _btns.frame.size.height + 10 * HEIGHTSCALE, WIDHT - 20 * WIDHTSCALE, 100 * HEIGHTSCALE)];
    [_mainscrollview addSubview:_mainviews];

    _photoimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (_mainviews.frame.size.width - 10 * WIDHTSCALE) / 2, (_mainviews.frame.size.width - 10 * WIDHTSCALE) / 2)];
    _photoimageview.image = [UIImage imageNamed:@"上传证件照.png"];
    _photoimageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upload)];
    [_photoimageview addGestureRecognizer:tap1];
    [_mainviews addSubview:_photoimageview];
    _mainviews.frame = CGRectMake(10 * WIDHTSCALE,  _btns.frame.origin.y + _btns.frame.size.height + 10 * HEIGHTSCALE, WIDHT - 20 * WIDHTSCALE, _photoimageview.frame.size.height);
    _mainscrollview.contentSize = CGSizeMake(WIDHT, _mainviews.frame.origin.y + _mainviews.frame.size.height + 40 * HEIGHTSCALE + 64);
}

//根据参数的个数  返回对应的位置
- (CGRect)getrect:(unsigned long int) i{
    CGFloat width = (WIDHT - 20 * WIDHTSCALE - 10 * WIDHTSCALE) / 2 + 10 * WIDHTSCALE;
    CGFloat height = (WIDHT - 20 * WIDHTSCALE - 10 * WIDHTSCALE) / 2 + 5 * HEIGHTSCALE;
    return CGRectMake((i % 2) * width, (i / 2) * height, (WIDHT - 20 * WIDHTSCALE - 10 * WIDHTSCALE) / 2, (WIDHT - 20 * WIDHTSCALE - 10 * WIDHTSCALE) / 2);
}

- (void)messageShow{
    //判断是否已经选择图片或数量是否超过十张
    if (_photoArr.count == 3) {
        self.isphoto = YES;
    }else{
        self.isphoto = NO;
    }
    if(!self.isphoto){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您需要上传3张证件照" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if(![_userTF.text isEqualToString:@""] && ![_phoneNum.text isEqualToString:@""] && ![_nameTF.text isEqualToString:@""] && ![_ncNameTF.text isEqualToString:@""] && _isphoto){
        //添加提示框
        UIView *tishiview = [[UIView alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, HEIGHT / 2 - 230 * HEIGHTSCALE / 2 - 64, WIDHT - 40 * WIDHTSCALE, 230 * HEIGHTSCALE)];
        tishiview.backgroundColor = [UIColor redColor];
        tishiview.backgroundColor = [UIColor whiteColor];
        //添加文字
        UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(20 * WIDHTSCALE, 0, tishiview.frame.size.width - 40 * WIDHTSCALE, tishiview.frame.size.height - 40 * HEIGHTSCALE)];
        la.textAlignment = NSTextAlignmentCenter;
        la.font = [UIFont systemFontOfSize:15 * HEIGHTSCALE];
        la.text = @"是否确认提交认证信息？";
        la.numberOfLines = 0;
        [tishiview addSubview:la];
        //添加按钮
        UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelbtn.frame = CGRectMake(0, tishiview.frame.size.height - 40 * HEIGHTSCALE, (tishiview.frame.size.width - 1) / 2, 40 * HEIGHTSCALE);
        cancelbtn.backgroundColor = mainColor;
        [cancelbtn setTitle:@"稍后" forState:UIControlStateNormal];
        [cancelbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelbtn addTarget:self action:@selector(taps) forControlEvents:UIControlEventTouchUpInside];
        [tishiview addSubview:cancelbtn];

        UIButton *commitbtn = [UIButton buttonWithType:UIButtonTypeSystem];
        commitbtn.frame = CGRectMake(cancelbtn.frame.size.width + 1, tishiview.frame.size.height - 40 * HEIGHTSCALE,  (tishiview.frame.size.width - 1) / 2, 40 * HEIGHTSCALE);
        commitbtn.backgroundColor = mainColor;
        [commitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commitbtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitbtn addTarget:self action:@selector(loginss:) forControlEvents:UIControlEventTouchUpInside];
        [tishiview addSubview:commitbtn];
        [self createbacbiew:tishiview];

    }else{
        //如果都填写了信息
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请将信息填写完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

//上传照片
- (void)upload{
        if (_photoArr.count == 3) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"最多选择3张照片"];
        }else{
            //原图
            SGImagePickerController *picker = [[SGImagePickerController alloc]init];
            [picker setDidFinishSelectImages:^(NSArray *images) {
                if (_photoArr.count + images.count > 3) {
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD showErrorWithStatus:@"最多上传3张照片"];
                }else{
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [_photoArr addObjectsFromArray:images];
                    //创建imaegview
                    for (int i = 0; i < _photoArr.count; i++) {
                        UIImageView *imageview = [[UIImageView alloc]init];
                        imageview.frame = [self getrect:i];
                        imageview.image = _photoArr[i];
                        imageview.tag = i + 1;
                        imageview.layer.cornerRadius = 5;
                        imageview.layer.masksToBounds = YES;
                        UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
                        [imageview addGestureRecognizer:tapss];
                        imageview.userInteractionEnabled = YES;
                        [_mainviews addSubview:imageview];
                    }
                    //重新设置添加图片的位置
                    _photoimageview.frame = [self getrect:_photoArr.count];
                    //重新设置view的高度
                    _mainviews.frame = CGRectMake(10 * WIDHTSCALE,  _btns.frame.origin.y + _btns.frame.size.height + 10 * HEIGHTSCALE, WIDHT - 20 * WIDHTSCALE, _photoimageview.frame.size.height + _photoimageview.frame.origin.y);
                    //重新设置scrollview的高度
                    if (_mainviews.frame.origin.y + _mainviews.frame.size.height > HEIGHT) {
                        _mainscrollview.contentSize = CGSizeMake(WIDHT, _mainviews.frame.origin.y + _mainviews.frame.size.height + 10 * HEIGHTSCALE + 64);
                    }
                }
            }];
            [self presentViewController:picker animated:YES completion:nil];
        }
        //缩略图
        //        [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
        //            NSLog(@"%lu", (unsigned long)thumbnails.count);
        //            [_photoArr addObjectsFromArray:thumbnails];
        //            //创建imaegview
        //            for (int i = 1; i <= _photoArr.count; i++) {
        //                UIImageView *imageview = [[UIImageView alloc]init];
        //                imageview.frame = [self getrect:i];
        //                imageview.image = _photoArr[i - 1];
        //                [_mainscrollview addSubview:imageview];
        //            }
        //            //重新设置添加图片的位置
        //            _photoimageview.frame = [self getrect:_photoArr.count + 1];
        //            //重新设置scrollview的高度
        //            if (_photoimageview.frame.origin.y + _photoimageview.frame.size.height > HEIGHT) {
        //                _mainscrollview.contentSize = CGSizeMake(WIDHT, _photoimageview.frame.origin.y + _photoimageview.frame.size.height + 10);
        //            }
        //
        //            NSLog(@"照片数组的信息 %@", _photoArr);
        //        }];
}

//点击图片触发的事件
- (void)chufa:(UITapGestureRecognizer *)tap{
    NSLog(@"当前图片数量 %lu", (unsigned long)_photoArr.count);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_mainviews removeFromSuperview];
        [self createPhoto];
        //移除选择的元素
        [_photoArr removeObjectAtIndex:tap.view.tag - 1];

        //重新遍历添加图片
        for (int i = 0; i < _photoArr.count; i++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.frame = [self getrect:i];
            imageview.image = _photoArr[i];
            imageview.tag = i + 1;
            imageview.layer.cornerRadius = 5;
            imageview.layer.masksToBounds = YES;
            UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
            [imageview addGestureRecognizer:tapss];
            imageview.userInteractionEnabled = YES;
            [_mainviews addSubview:imageview];
        }
        //重新设置添加图片的位置
        _photoimageview.frame = [self getrect:_photoArr.count];

        //重新设置view的高度
        _mainviews.frame = CGRectMake(10 * WIDHTSCALE,  _btns.frame.origin.y + _btns.frame.size.height + 10 * HEIGHTSCALE, WIDHT - 20 * WIDHTSCALE, _photoimageview.frame.size.height + _photoimageview.frame.origin.y);

        //重新设置scrollview的高度
        if (_mainviews.frame.origin.y + _mainviews.frame.size.height > HEIGHT) {
            _mainscrollview.contentSize = CGSizeMake(WIDHT, _mainviews.frame.origin.y + _mainviews.frame.size.height + 10 * HEIGHTSCALE + 64);
        }
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"更改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SGImagePickerController *picker = [[SGImagePickerController alloc]init];
        [picker setDidFinishSelectImages:^(NSArray *images) {
            if (images.count >  1) {
                //修改时 如果选择的个数大于当前个数大于1   （暂不区分 基础个数是否为4）
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showErrorWithStatus:@"只能选择一张替换"];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
                [_photoArr insertObject:images[0] atIndex:tap.view.tag - 1];
                [_photoArr removeObjectAtIndex:tap.view.tag];
                UIImageView *imageview = [[UIImageView alloc]init];
                imageview.frame = [self getrect:tap.view.tag - 1];
                imageview.tag = tap.view.tag;
                imageview.backgroundColor = mainColor;
                imageview.image = _photoArr[tap.view.tag - 1];

                imageview.layer.cornerRadius = 5;
                imageview.layer.masksToBounds = YES;
                UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
                [imageview addGestureRecognizer:tapss];
                imageview.userInteractionEnabled = YES;
                [_mainviews addSubview:imageview];
            }
        }];
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }]];

    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}


//创建灰色背景
- (void)createbacbiew:(UIView *)views{
    if (_show) {
        _messShowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
        _messShowView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:_messShowView];
        _show = NO;

        [UIView animateWithDuration:0.3 animations:^{
            views.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                views.transform = CGAffineTransformIdentity;
            }];
        }];
        [_messShowView addSubview:views];
    }
}

//取消事件
- (void)taps{
    _messShowView.hidden = YES;
    _show = YES;
}

//上传事件
- (void)loginss:(UIButton *)sender{
    NSLog(@"提交了。。。");
    sender.userInteractionEnabled = NO;

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //上传实名信息
    NSDictionary *paramters = @{@"mid":[self.userdefault valueForKey:@"userMID"], @"id": [self.userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"name":self.nameTF.text, @"idno":self.userTF.text, @"tel":self.phoneNum.text, @"address":self.ncNameTF.text};
    NSLog(@"canshu %@", paramters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecret:@"100108"] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [SVProgressHUD show];
        [SVProgressHUD showWithStatus:@"提交中..."];
        //写入图片data
        for (int i = 0; i < _photoArr.count; i++) {
            NSString *str = [NSString stringWithFormat:@"pic%d", i+1];
            NSString *str1 = [NSString stringWithFormat:@"id%d.jpeg", i+1];
            NSData *data = UIImageJPEGRepresentation(_photoArr[i], 0.1);
            [formData appendPartWithFileData:data name:str fileName:str1 mimeType:@"image/jpeg"];
        }

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"提交返回信息%@", str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:nil];
        if ([[NSString stringWithFormat:@"%@", dic[@"retValue"]] isEqualToString:@"5"]) {
            if (self.iszhuce){
                TCShopManagerViewController *shopManageVC = [[TCShopManagerViewController alloc] init];
                shopManageVC.hidesBottomBarWhenPushed = YES;
                shopManageVC.zhuce = YES;
                [self.navigationController pushViewController:shopManageVC animated:YES];
            } else {
                [self performSelector:@selector(dismis) withObject:nil afterDelay:1.5];
            }
            [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retMessage"]];

        }
        sender.userInteractionEnabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"提交失败!"];
        NSLog(@"上传失败");
        sender.userInteractionEnabled = YES;
    }];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing: YES];
    [_mainscrollview endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.userTF resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self.nameTF resignFirstResponder];
    [self.ncNameTF resignFirstResponder];
}

- (void)barButtonItemsao:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismis{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
