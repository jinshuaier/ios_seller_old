//
//  TCIDViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCIDViewController.h"

@interface TCIDViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIView *bgckView;
@property (nonatomic, strong) UIImageView *photoPic1;//相机图片
@property (nonatomic, strong) UIImageView *photoPic2;
@property (nonatomic, strong) UIImageView *photoPic3;
@property (nonatomic, strong) UIScrollView *myscrollView;
@property (nonatomic, strong) NSData *imageData;//用来记录选取的图片
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIView *alphaView1;
@property (nonatomic, strong) UIView *alphaView2;
@property (nonatomic, strong) UIView *alphaView3;
@property (nonatomic, strong) NSString *stateStr;
@property (nonatomic, strong) UILabel *tiLabel1;
@property (nonatomic, strong) UILabel *tiLabel2;
@property (nonatomic, strong) UILabel *tiLabel3;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *idnoField;


@end

@implementation TCIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传身份证照";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    [self creatUI];
    [self creatRequest];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    self.myscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT,HEIGHT)];
    self.myscrollView.contentSize = CGSizeMake(WIDHT, 1.2*HEIGHT);
    self.myscrollView.showsVerticalScrollIndicator = FALSE;
    self.myscrollView.showsHorizontalScrollIndicator = FALSE;
    self.myscrollView.scrollEnabled = YES;
    self.myscrollView.backgroundColor = TCBgColor;
    [self.view addSubview:self.myscrollView];
    NSArray *arr = @[@"上传店主身份证正面照", @"上传店主身份证正面照", @"上传手持身份证照片"];
    NSArray *alpArr = @[@"点击修改店主身份证正面照",@"点击修改店主身份证反面照",@"点击修改手持身份证照"];
    for (int i = 0; i < 3; i++) {
        UIImageView *imview = [[UIImageView alloc]initWithFrame:CGRectMake(60,30 + i *(30 + 135),240,135)];
        imview.tag = 1000 + i;
        imview.userInteractionEnabled = YES;
        imview.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        imview.image = [UIImage imageNamed:@""];
        imview.tag = i + 1;
        //加入手势
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapzheng:)];
        [imview addGestureRecognizer:tapView];
        [self.myscrollView addSubview:imview];
        
        UIImageView *photoimage = [[UIImageView alloc]initWithFrame:CGRectMake(97, 30, 46, 40)];
        if (i == 0) {
            self.photoPic1 = photoimage;
        }else if (i == 1){
            self.photoPic2 = photoimage;
        }else if (i == 2){
            self.photoPic3 = photoimage;
        }
        photoimage.image = [UIImage imageNamed:@"相机图标"];
        [imview addSubview:photoimage];
        
        UILabel *texLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(photoimage.frame) + 20, 240, 15)];
        if (i == 0) {
            self.tiLabel1 = texLabel;
        }else if(i == 1){
            self.tiLabel2 = texLabel;
        }else{
            self.tiLabel3 = texLabel;
        }
        texLabel.text = arr[i];
        texLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        texLabel.textColor = TCUIColorFromRGB(0x666666);
        texLabel.textAlignment = NSTextAlignmentCenter;
        [imview addSubview:texLabel];
        
        UIView* alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 240, 35)];
        if (i == 0) {
            self.alphaView1 = alphaView;
        }else if(i == 1){
            self.alphaView2 = alphaView;
        }else{
            self.alphaView3 = alphaView;
        }
        alphaView.backgroundColor = TCUIColorFromRGB(0x000000);
        alphaView.alpha = 0.6;
        alphaView.hidden = YES;
        [imview addSubview:alphaView];
        
        UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 240, 15)];
        editLabel.text = alpArr[i];
        editLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        editLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
        editLabel.textAlignment = NSTextAlignmentCenter;
        [alphaView addSubview:editLabel];
    }
    
    NSArray *titArr = @[@"店主姓名",@"店主身份证照"];
    NSArray *plaArr = @[@"请输入店主姓名",@"请输入身份证号"];
    for (int i = 0; i < titArr.count; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 30 + 3 *(30 + 135) + i *55, WIDHT, 55)];
        view.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        [self.myscrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 100, 15)];
        label.text = titArr[i];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = TCUIColorFromRGB(0x666666);
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 15, 20, WIDHT - 45 - 100, 15)];
        field.tag = 5 + i;
        if (i == 0) {
            self.nameField = field;
        }else if(i == 1){
            self.idnoField = field;
        }
        field.borderStyle = UITextBorderStyleNone;
        field.placeholder = plaArr[i];
        field.textAlignment = NSTextAlignmentRight;
        field.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        field.textColor = TCUIColorFromRGB(0x333333);
        [field addTarget:self  action:@selector(alueChange:)  forControlEvents:UIControlEventAllEditingEvents];
        [view addSubview:field];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 54, WIDHT - 15, 1)];
        line.backgroundColor = TCLineColor;
        [view addSubview:line];

    }
    self.saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30 + 3 *(30 + 135) + 2 *55 + 40, WIDHT - 30, 48)];
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 5;
    self.saveBtn.alpha = 0.6;
    self.saveBtn.userInteractionEnabled = NO;
    [self.saveBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [self.saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [self.saveBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.saveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.saveBtn addTarget:self action:@selector(clickSave:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.myscrollView addSubview:self.saveBtn];
    
}
- (void)alueChange:(UITextField *)textField{
    UIImageView *zhengimage = (UIImageView *)[self.view viewWithTag:1];
    UIImageView *fanimage = (UIImageView *)[self.view viewWithTag:2];
    UIImageView *handimage = (UIImageView *)[self.view viewWithTag:3];
    
    if (self.nameField.text.length != 0 && self.idnoField.text.length != 0) {
        if (zhengimage.image == nil|| fanimage.image == nil || handimage.image == nil) {
            NSLog(@"信息不全 图不全");
        }else{
            NSLog(@"信息够了 可以保存 请求数据");
            self.saveBtn.alpha = 1;
            self.saveBtn.userInteractionEnabled = YES;
        }
    }else{
        NSLog(@"数据不全");
    }
}
-(void)tapzheng:(UITapGestureRecognizer *)tap{
    UITapGestureRecognizer *singtap = (UITapGestureRecognizer *)tap;
    if ([singtap view].tag  == 1 ){
        self.stateStr = @"1";
        if (self.photoPic1.hidden == NO) {
            [self creatalphaView:@"身份证正面实例照片"];
        }else{
            [self clickalphaView];
        }
    }else if ([singtap view].tag == 2){
        self.stateStr = @"2";
        if (self.photoPic2.hidden == NO) {
            [self creatalphaView:@"身份证反面实例照片"];
        }else{
            [self clickalphaView];
        }
    }else if([singtap view].tag == 3 ){
        self.stateStr = @"3";
        if (self.photoPic3.hidden == NO) {
            [self creatalphaView:@"手持身份证实例照片"];
        }else{
            [self clickalphaView];
        }
    }
}

-(void)creatalphaView:(NSString *)state{
    self.bgckView = [[UIView alloc] init];
    self.bgckView.frame = CGRectMake(0, 0, WIDHT, HEIGHT);
    self.bgckView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgckView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 323)];
    contentView.center = CGPointMake(WIDHT/2, HEIGHT/2);
    contentView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 10;
    [self.bgckView addSubview:contentView];
    
    UIImageView *picView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 240, 135)];
    picView.image = [UIImage imageNamed:state];
    [contentView addSubview:picView];
    
    UIImageView *egImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    egImage.image = [UIImage imageNamed:@"例"];
    [picView addSubview:egImage];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(picView.frame) + 20, 240, 18)];
    label1.text = @"1.需文字清晰，边框完整，露出国徽";
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label1.textColor = TCUIColorFromRGB(0x666666);
    label1.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame) + 10, 240, 36)];
    label2.text = @"2.拍复印件需加盖印章，可用有效特许证件代替";
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label2.textColor = TCUIColorFromRGB(0x666666);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.numberOfLines = 0;
    CGSize size = [label2 sizeThatFits:CGSizeMake(240, MAXFLOAT)];
    label2.frame = CGRectMake(20, CGRectGetMaxY(label1.frame) + 10, 240, size.height);
    [contentView addSubview:label2];
    
    UIButton *knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(79, CGRectGetMaxY(label2.frame) + 30, 122, 34)];
    [knowBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [knowBtn setTitle:@"知道了" forState:(UIControlStateNormal)];
    [knowBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [knowBtn addTarget:self action:@selector(clickKnow:) forControlEvents:(UIControlEventTouchUpInside)];
    knowBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    knowBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    knowBtn.layer.masksToBounds = YES;
    knowBtn.layer.cornerRadius = 17;
    [contentView addSubview:knowBtn];
}
-(void)clickKnow:(UIButton *)sender{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
    [self clickalphaView];
}

-(void)clickalphaView{
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

//picker.delegate代理方法  选择完图片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImageView *zhengimage = (UIImageView *)[self.view viewWithTag:1];
    UIImageView *fanimage = (UIImageView *)[self.view viewWithTag:2];
    UIImageView *handimage = (UIImageView *)[self.view viewWithTag:3];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    //放入全局队列中保存头像
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将头像写入沙盒
        _imageData = UIImageJPEGRepresentation(image, 0.5);
        [_imageData writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"store.png"] atomically:YES];
    });
    if ([self.stateStr isEqualToString:@"1"]) {
        zhengimage.image = image;
        self.photoPic1.hidden = YES;
        self.tiLabel1.hidden = YES;
        self.alphaView1.hidden = NO;
        [self imageQuest:@"id_pic_1"];
    }else if ([self.stateStr isEqualToString:@"2"]){
        fanimage.image = image;
        self.photoPic2.hidden = YES;
        self.tiLabel2.hidden = YES;
        self.alphaView2.hidden = NO;
        [self imageQuest:@"id_pic_2"];
    }else{
        handimage.image = image;
        self.photoPic3.hidden = YES;
        self.tiLabel3.hidden = YES;
        self.alphaView3.hidden = NO;
        [self imageQuest:@"id_pic_3"];
    }
    //点击choose后跳转到前一页
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 上传服务器
-(void)imageQuest:(NSString *)name{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"2"};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"2"};
    //提交修改，上传图片至服务器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecretOffline:@"201006"] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //开始滚动
        if (self.imageData) {
            [formData appendPartWithFileData:self.imageData  name:name fileName:@"idcard.png" mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [TCProgressHUD showMessage:dic[@"msg"]];
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"returnlicense" object:nil];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    
}

-(void)clickSave:(UIButton *)sender{
    [self saveIdRequest];
}

-(void)saveIdRequest{
    
    if (self.idnoField.text.length < 18 && ![BSUtils IsIdentityCard:self.idnoField.text]) {
        [TCProgressHUD showMessage:@"请输入正确的身份证号"];
    } else {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
        NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
        NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
        NSString *Timestr = [TCGetTime getCurrentTime];
        
        NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"name":self.nameField.text,@"idno":self.idnoField.text,@"shopid":shopID};
        NSString *signStr = [TCServerSecret signStr:dic];
        NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"name":self.nameField.text,@"idno":self.idnoField.text,@"shopid":shopID};
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201011"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            NSLog(@"%@---%@",jsonDic,jsonStr);
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"returnid" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            nil;
        }];
    }
}
    -(void)creatRequest{
        UIImageView *zhengimage = (UIImageView *)[self.view viewWithTag:1];
        UIImageView *fanimage = (UIImageView *)[self.view viewWithTag:2];
        UIImageView *handimage = (UIImageView *)[self.view viewWithTag:3];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"获取中..."];
        NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
        NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
        NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"2"};
        NSString *signStr = [TCServerSecret signStr:dic];
        NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"2"};
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201020"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            [SVProgressHUD dismiss];
            NSLog(@"%@---%@",jsonDic,jsonStr);
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                self.saveBtn.alpha = 1;
                self.saveBtn.userInteractionEnabled = YES;
                NSString *str1 = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"front"][@"imageid"]];
                NSString *str2 = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"back"][@"imageid"]];
                NSString *str3 = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"carry"][@"imageid"]];
                NSString *idStr = [NSString stringWithFormat:@"%@",jsonDic[@"idno"]];
                if ([str1 isEqualToString:@"0"]) {
                    self.photoPic1.hidden = NO;
                    self.tiLabel1.hidden = NO;
                    self.alphaView1.hidden = YES;
                }else{
                    self.photoPic1.hidden = YES;
                    self.tiLabel1.hidden = YES;
                    self.alphaView1.hidden = NO;
                    [zhengimage sd_setImageWithURL:[NSURL URLWithString: jsonDic[@"data"][@"front"][@"src"]] placeholderImage:[UIImage imageNamed:@"商家版长占位图"]];
                }
                
                if ([str2 isEqualToString:@"0"]) {
                    self.photoPic2.hidden = NO;
                    self.tiLabel2.hidden = NO;
                    self.alphaView2.hidden = YES;
                }else{
                    self.photoPic2.hidden = YES;
                    self.tiLabel2.hidden = YES;
                    self.alphaView2.hidden = NO;
                    [fanimage sd_setImageWithURL:[NSURL URLWithString: jsonDic[@"data"][@"back"][@"src"]] placeholderImage:[UIImage imageNamed:@"商家版长占位图"]];
                }
                
                if ([str3 isEqualToString:@"0"]) {
                    self.photoPic3.hidden = NO;
                    self.tiLabel3.hidden = NO;
                    self.alphaView3.hidden = YES;
                }else{
                    self.photoPic3.hidden = YES;
                    self.tiLabel3.hidden = YES;
                    self.alphaView3.hidden = NO;
                    [handimage sd_setImageWithURL:[NSURL URLWithString: jsonDic[@"data"][@"carry"][@"src"]] placeholderImage:[UIImage imageNamed:@"商家版长占位图"]];
                }
                if ([idStr isEqualToString:@""]) {
                    
                }else{
                    self.idnoField.text = jsonDic[@"data"][@"idno"];
                }
                self.nameField.text = jsonDic[@"data"][@"name"];
            }else{
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
        } failure:^(NSError *error) {
            nil;
        }];
    }


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    [self.idnoField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
