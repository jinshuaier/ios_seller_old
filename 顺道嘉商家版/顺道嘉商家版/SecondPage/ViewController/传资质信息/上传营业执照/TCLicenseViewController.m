//
//  TCLicenseViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/4.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCLicenseViewController.h"

@interface TCLicenseViewController ()<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIView *bgckView;
@property (nonatomic, strong) NSData *imageData;//用来记录选取的图片
@property (nonatomic, strong) UIImageView *photoPic;
@property (nonatomic, strong) UILabel *tiLabel;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIButton *PreservationBtn;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) NSString *imageid;

@end

@implementation TCLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传营业执照";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    [self creatUI];
    [self creatRequest];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDHT - 240)/2, 30, 240, 135)];
    self.bgView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    self.bgView.userInteractionEnabled = YES;
    self.bgView.image = [UIImage imageNamed:@""];
    
    //加入手势
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.bgView addGestureRecognizer:tapView];
    [self.view addSubview:self.bgView];
    
    UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(97, 30, 46, 40)];
    self.photoPic = photoImage;
    photoImage.image = [UIImage imageNamed:@"相机图标"];
    [self.bgView addSubview:photoImage];
    
    UILabel *texLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(photoImage.frame) + 20, 120, 15)];
    self.tiLabel = texLabel;
    texLabel.text = @"点击上传营业执照";
    texLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    texLabel.textColor = TCUIColorFromRGB(0x666666);
    texLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:texLabel];
    
    self.alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 240, 35)];
    self.alphaView.backgroundColor = TCUIColorFromRGB(0x000000);
    self.alphaView.alpha = 0.4;
    self.alphaView.hidden = YES;
    [self.bgView addSubview:self.alphaView];
    
    UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 240, 15)];
    editLabel.text = @"点击图片修改营业执照";
    editLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    editLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    editLabel.textAlignment = NSTextAlignmentCenter;
    [self.alphaView addSubview:editLabel];
    
    self.PreservationBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.bgView.frame) + 40, WIDHT - 30, 48)];
    self.PreservationBtn.alpha = 0.6;
    self.PreservationBtn.userInteractionEnabled = NO;
    [self.PreservationBtn setBackgroundColor:TCUIColorFromRGB(0x53C3C3)];
    [self.PreservationBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [self.PreservationBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    self.PreservationBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.PreservationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.PreservationBtn addTarget:self action:@selector(clickPre:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.PreservationBtn];
}

-(void)clickPre:(UIButton *)sender{
    [self imageQuest];
}

#pragma mark -- 上传服务器
-(void)imageQuest{
//    [BQActivityView showActiviTy];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
     NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"1"};
    NSString *signStr = [TCServerSecret signStr:dic];
     NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"1"};
    //提交修改，上传图片至服务器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecretOffline:@"201006"] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //开始滚动
        if (self.imageData) {
            [formData appendPartWithFileData:self.imageData  name:@"license" fileName:@"license.png" mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"提交图片的返回结果 %@", dic[@"msg"]);
//        [BQActivityView hideActiviTy];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"returnlicense" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    
}


-(void)creatalphaView{
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
    picView.image = [UIImage imageNamed:@"营业执照示例图0"];
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
-(void)tapView{
//    if (self.photoPic.hidden == NO) {
        [self creatalphaView];
//    }else{
//        [self deleteimage];
//    }
    
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
//-(void)deleteimage{
//
//    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
//    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
//    NSString *Timestr = [TCGetTime getCurrentTime];
//    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
//    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"imageid":self.imageid};
//    NSString *signStr = [TCServerSecret signStr:dic];
//    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"imageid":self.imageid};
//
//    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201009"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
//        NSLog(@"%@---%@",jsonDic,jsonStr);
//        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
//        if ([codeStr isEqualToString:@"1"]) {
//            [self clickalphaView];
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}

-(void)clickKnow:(UIButton *)sender{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgckView removeFromSuperview];
        self.bgckView = nil;
    }];
    [self clickalphaView];
}

//picker.delegate代理方法  选择完图片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    //放入全局队列中保存头像
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将头像写入沙盒
        _imageData = UIImageJPEGRepresentation(image, 0.5);
        [_imageData writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"store.png"] atomically:YES];
    });
    _bgView.image = image;
    self.photoPic.hidden = YES;
    self.tiLabel.hidden = YES;
    //点击choose后跳转到前一页
    self.alphaView.hidden = NO;
    self.PreservationBtn.userInteractionEnabled = YES;
    self.PreservationBtn.alpha = 1;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)creatRequest{
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"1"};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"1"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201020"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            self.PreservationBtn.alpha = 1;
            self.PreservationBtn.userInteractionEnabled = YES;
            NSString *str = [NSString stringWithFormat:@"%@",jsonDic[@"data"][@"imageid"]];
            self.imageid = str;
            if ([str isEqualToString:@"0"]) {
                self.alphaView.hidden = YES;
                self.photoPic.hidden = NO;
                self.tiLabel.hidden = NO;
            }else{
            [self.bgView sd_setImageWithURL:[NSURL URLWithString: jsonDic[@"data"][@"src"]] placeholderImage:[UIImage imageNamed:@"商家版长占位图"]];
            self.alphaView.hidden = NO;
            self.photoPic.hidden = YES;
            self.tiLabel.hidden = YES;
            }
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        nil;
    }];
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
