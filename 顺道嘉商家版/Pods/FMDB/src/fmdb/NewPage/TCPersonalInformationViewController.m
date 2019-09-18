//
//  TCPersonalInformationViewController.m
//  顺道嘉商家版
//
//  Created by GeYang on 2017/4/12.
//  Copyright © 2017年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCPersonalInformationViewController.h"
#import "TCExamplesViewController.h"
#import "TCPersonalCommitView.h"



@interface TCPersonalInformationViewController ()<UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *idNo;//身份证
@property (nonatomic, strong) UITextField *phoneNum;//联系方式
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *address;
@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) NSData *imageData0;
@property (nonatomic, strong) NSData *imageData1;
@property (nonatomic, strong) NSData *imageData2;
@property (nonatomic, assign) NSInteger index;//记录当前选择的图片
@property (nonatomic, strong) UIImageView *selectedIm;
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UILabel *titles;
@property (nonatomic, strong) UILabel *zhuyilb;
@property (nonatomic, strong) UIView *backview;
@property (nonatomic, assign) int imagecount;
@end

@implementation TCPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagecount = 0;
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    _userdefault = [NSUserDefaults standardUserDefaults];
    
    _mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT - 64)];
    _mainScrollview.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    _mainScrollview.delegate = self;
    [self.view addSubview: _mainScrollview];
    
    //填写信息view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 200)];
    topView.backgroundColor = [UIColor whiteColor];
    [_mainScrollview addSubview: topView];
    //身份证号
    UILabel *idnum = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 36)];
    idnum.text = @"身份证号:";
    idnum.textColor = TCUIColorFromRGB(0x666666);
    idnum.font = [UIFont systemFontOfSize:14];
    [topView addSubview: idnum];
    _idNo = [[UITextField alloc]initWithFrame:CGRectMake(idnum.frame.origin.x + idnum.frame.size.width + 4, 0, WIDHT - idnum.frame.origin.x - idnum.frame.size.width - 4 - 12, 36)];
    _idNo.textColor = TCUIColorFromRGB(0x333333);
    _idNo.font = [UIFont systemFontOfSize:14];
    
//    if ([NSString stringWithFormat:@"%@", _mseDic[@"data"][@"idno"]].length == 18) {
//        NSString *str = [_mseDic[@"data"][@"idno"] substringWithRange:NSMakeRange(0, 4)];
//        NSString *str1 = [_mseDic[@"data"][@"idno"] substringWithRange:NSMakeRange(14, 4)];
//        NSString *str2 = [[str stringByAppendingString:@"************"] stringByAppendingString:str1];
//        _idNo.text = str2;
//    }else{
        _idNo.text = _mseDic[@"data"][@"idno"];

//    }
    _idNo.delegate = self;
    [topView addSubview: _idNo];
    _idNo.userInteractionEnabled = NO; 
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(12, idnum.frame.origin.y + idnum.frame.size.height, WIDHT - 12, 1)];
    line1.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1/1.0];
    [topView addSubview: line1];
    
    //联系方式
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(line1.frame.origin.x, line1.frame.origin.y + line1.frame.size.height, idnum.frame.size.width, idnum.frame.size.height)];
    phone.text = @"联系方式:";
    phone.textColor = TCUIColorFromRGB(0x666666);
    phone.font = [UIFont systemFontOfSize:14];
    [topView addSubview: phone];
    _phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(idnum.frame.origin.x + idnum.frame.size.width + 4, phone.frame.origin.y, WIDHT - idnum.frame.origin.x - idnum.frame.size.width - 4 - 12, 36)];
    _phoneNum.font = [UIFont systemFontOfSize:14];
    _phoneNum.textColor = TCUIColorFromRGB(0x333333);
    _phoneNum.userInteractionEnabled = NO;
//    if ([NSString stringWithFormat:@"%@", _mseDic[@"data"][@"mobile"]].length == 11) {
//        NSString *str = [_mseDic[@"data"][@"mobile"] substringWithRange:NSMakeRange(0, 3)];
//        NSString *str1 = [_mseDic[@"data"][@"mobile"] substringWithRange:NSMakeRange(8, 3)];
//        NSString *str2 = [[str stringByAppendingString:@"*****"] stringByAppendingString:str1];
//        _phoneNum.text = str2;
//    }else{
        _phoneNum.text = _mseDic[@"data"][@"mobile"];
        
//    }
    _phoneNum.delegate = self;
    [topView addSubview: _phoneNum];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(12, phone.frame.origin.y + phone.frame.size.height, WIDHT - 12, 1)];
    line2.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1/1.0];
    [topView addSubview: line2];
    
    //姓名
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(line2.frame.origin.x, line2.frame.origin.y + line2.frame.size.height, idnum.frame.size.width, idnum.frame.size.height)];
    userName.text = @"姓名:";
    userName.textColor = TCUIColorFromRGB(0x666666);
    userName.font = [UIFont systemFontOfSize:14];
    [topView addSubview: userName];
    _name = [[UITextField alloc]initWithFrame:CGRectMake(idnum.frame.origin.x + idnum.frame.size.width + 4, userName.frame.origin.y, WIDHT - idnum.frame.origin.x - idnum.frame.size.width - 4 - 12, 36)];
    _name.textColor = TCUIColorFromRGB(0x333333);
    _name.font = [UIFont systemFontOfSize:14];
    _name.placeholder = @"输入您的姓名(和身份证一致)";
    _name.delegate = self;
    [topView addSubview: _name];
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(12, userName.frame.origin.y + userName.frame.size.height, WIDHT - 12, 1)];
    line3.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1/1.0];
    [topView addSubview: line3];
    
    //家庭住址
    UILabel *homeAddress = [[UILabel alloc]initWithFrame:CGRectMake(line3.frame.origin.x, line3.frame.origin.y + line3.frame.size.height, idnum.frame.size.width, idnum.frame.size.height)];
    homeAddress.textColor = TCUIColorFromRGB(0x666666);
    homeAddress.text = @"家庭住址:";
    homeAddress.font = [UIFont systemFontOfSize:14];
    [topView addSubview: homeAddress];
    _address = [[UITextField alloc]initWithFrame:CGRectMake(homeAddress.frame.origin.x + homeAddress.frame.size.width + 4, homeAddress.frame.origin.y, WIDHT - homeAddress.frame.origin.x - homeAddress.frame.size.width - 4 - 12, 36)];
    _address.delegate = self;
    _address.textColor = TCUIColorFromRGB(0x333333);
    _address.font = [UIFont systemFontOfSize:14];
    _address.placeholder = @"填写您的目前住址";
    [topView addSubview: _address];
    topView.frame = CGRectMake(0, 0, WIDHT, _address.frame.origin.y + _address.frame.size.height + 12);
    
    //上传view
    UIView *midview = [[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height + topView.frame.origin.y + 10, WIDHT, 300)];
    midview.backgroundColor = [UIColor whiteColor];
    [_mainScrollview addSubview: midview];
    UILabel *shangchuan = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, WIDHT, 14)];
    shangchuan.text = @"上传相关照片";
    shangchuan.textColor = TCUIColorFromRGB(0x666666);
    shangchuan.font = [UIFont systemFontOfSize:14];
    [midview addSubview: shangchuan];
    _titles = shangchuan;
    
    float x = (WIDHT - 80 * WIDHTSCALE - 3 * 56 * WIDHTSCALE) / 2.0;
    float y = (WIDHT - 64 * WIDHTSCALE - 3 * 75 * WIDHTSCALE) / 2.0;
    NSArray *arr = @[@"正面身份证照", @"反面身份证照", @"手持身份证照"];
    for (int i = 0; i < 3; i++) {
        UIImageView *imview = [[UIImageView alloc]initWithFrame:CGRectMake(40 * WIDHTSCALE + i * (56 * WIDHTSCALE + x), shangchuan.frame.origin.y + shangchuan.frame.size.height + 16, 56 * WIDHTSCALE, 56 * WIDHTSCALE)];
        imview.userInteractionEnabled = YES;
        imview.image = [UIImage imageNamed:@"营业执照上传框.png"];
        imview.tag = i + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        [imview addGestureRecognizer: tap];
        [midview addSubview: imview];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(32 * WIDHTSCALE + i * (75 * WIDHTSCALE + y), imview.frame.origin.y + imview.frame.size.height + 12, 75 * WIDHTSCALE, 12 * HEIGHTSCALE)];
        title.font = [UIFont systemFontOfSize:12 * HEIGHTSCALE];
        title.text = arr[i];
        title.tag = (i + 1) * 10;
        title.textColor = TCUIColorFromRGB(0x2EA8E5);
        title.textAlignment = NSTextAlignmentCenter;
        [midview addSubview: title];
    }
    
    //注意
    UIView *zhuyiview = [[UIView alloc]initWithFrame:CGRectMake(12, 146, WIDHT - 24, 176)];
    zhuyiview.backgroundColor =  [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1/1.0];
    zhuyiview.layer.cornerRadius = 5;
    zhuyiview.layer.masksToBounds = YES;
    [midview addSubview: zhuyiview];
    
    UILabel *zhuyilb = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, zhuyiview.frame.size.width - 20, zhuyiview.frame.size.height - 24)];
    zhuyilb.textColor = TCUIColorFromRGB(0x99734C);
    zhuyilb.font = [UIFont systemFontOfSize:13];
    zhuyilb.numberOfLines = 0;
    zhuyilb.text = @"注意：\n为确保您的合法权益，请您仔细阅读以下权益须知\n1.请上传本人相关证件：包含身份证原件的正反面及手持身份证正面，共三张；\n2.请在上传时仔细检查证件信息，确认照片无误并清晰后上传；\n3.证件通过审核后不得自行修改，若必要修改请联系客服人员，待确认无误后方可更改";
    _zhuyilb = zhuyilb;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:zhuyilb.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [zhuyilb.text length])];
    zhuyilb.attributedText = attributedString;
    
    
    [zhuyiview addSubview: zhuyilb];
    midview.frame = CGRectMake(0, topView.frame.size.height + topView.frame.origin.y + 10, WIDHT, zhuyiview.frame.origin.y + zhuyiview.frame.size.height + 20);
    
    //查看实例照片
    UIButton *chakan = [[UIButton alloc]initWithFrame:CGRectMake(WIDHT - 12 - 84, midview.frame.origin.y + midview.frame.size.height + 10, 84, 16)];
    [chakan setTitle:@"查看实例照片" forState:UIControlStateNormal];
    chakan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chakan setTitleColor:TCUIColorFromRGB(0x2EA8E5) forState:UIControlStateNormal];
    chakan.titleLabel.font = [UIFont systemFontOfSize:13];
    [chakan addTarget:self action:@selector(muban) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollview addSubview: chakan];
    
    //提交按钮
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, chakan.frame.origin.y + chakan.frame.size.height + 48, WIDHT - 24, 48)];
    _commitBtn.layer.cornerRadius = 20;
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _commitBtn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_commitBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.userInteractionEnabled = NO;
    [_mainScrollview addSubview: _commitBtn];
    
    _mainScrollview.contentSize = CGSizeMake(WIDHT, _commitBtn.frame.size.height + _commitBtn.frame.origin.y + 50);
    
    
    UIImageView *imview1 = (UIImageView *)[_mainScrollview viewWithTag:1];
    UIImageView *imview2 = (UIImageView *)[_mainScrollview viewWithTag:2];
    UIImageView *imview3 = (UIImageView *)[_mainScrollview viewWithTag:3];
    UILabel *label1 = (UILabel *)[_mainScrollview viewWithTag:10];
    UILabel *label2 = (UILabel *)[_mainScrollview viewWithTag:20];
    UILabel *label3 = (UILabel *)[_mainScrollview viewWithTag:30];
    if ([[NSString stringWithFormat:@"%@", _mseDic[@"data"][@"auth"]] isEqualToString:@"1"]) {
        [self showViews];
        //通过
        if ([NSString stringWithFormat:@"%@", _mseDic[@"data"][@"idno"]].length == 18) {
            NSString *str = [_mseDic[@"data"][@"idno"] substringWithRange:NSMakeRange(0, 4)];
            NSString *str1 = [_mseDic[@"data"][@"idno"] substringWithRange:NSMakeRange(14, 4)];
            NSString *str2 = [[str stringByAppendingString:@"************"] stringByAppendingString:str1];
            _idNo.text = str2;
        }else{
            _idNo.text = _mseDic[@"data"][@"idno"];
            
        }
        if ([NSString stringWithFormat:@"%@", _mseDic[@"data"][@"mobile"]].length == 11) {
            NSString *str = [_mseDic[@"data"][@"mobile"] substringWithRange:NSMakeRange(0, 3)];
            NSString *str1 = [_mseDic[@"data"][@"mobile"] substringWithRange:NSMakeRange(8, 3)];
            NSString *str2 = [[str stringByAppendingString:@"*****"] stringByAppendingString:str1];
            _phoneNum.text = str2;
        }else{
            _phoneNum.text = _mseDic[@"data"][@"mobile"];
            
        }
        _name.text = _mseDic[@"data"][@"name"];
        _address.text = _mseDic[@"data"][@"address"];
        _name.userInteractionEnabled = NO;
        _address.userInteractionEnabled = NO;
        _titles.text = @"您已通过实名认证";
        _zhuyilb.text = @"注意：\n欢迎您使用【顺道嘉】平台，您的证件已上传成功，如若修改相关证件信息，请拨打【顺道嘉】平台全国免费客服热线4000-111-228，待工作人员确认后，方可进行修改。";
        [_commitBtn removeFromSuperview];
        
        [imview1 removeFromSuperview];
        [imview2 removeFromSuperview];
        [imview3 removeFromSuperview];
        [label1 removeFromSuperview];
        [label2 removeFromSuperview];
        [label3 removeFromSuperview];
        
        zhuyiview.frame = CGRectMake(12, _titles.frame.origin.y + _titles.frame.size.height + 10, WIDHT - 24, 176);
        
    }else if ([[NSString stringWithFormat:@"%@", _mseDic[@"data"][@"auth"]] isEqualToString:@"0"]){
        //审核中
        _name.text = _mseDic[@"data"][@"name"];
        _address.text = _mseDic[@"data"][@"address"];
        _name.userInteractionEnabled = NO;
        _address.userInteractionEnabled = NO;
        _titles.text = @"您的认证信息正在审核中";
        [_commitBtn removeFromSuperview];
        [imview1 removeFromSuperview];
        [imview2 removeFromSuperview];
        [imview3 removeFromSuperview];
        [label1 removeFromSuperview];
        [label2 removeFromSuperview];
        [label3 removeFromSuperview];
        
        zhuyiview.frame = CGRectMake(12, _titles.frame.origin.y + _titles.frame.size.height + 10, WIDHT - 24, 176);
    }else{
        //未审核
    }
    
}

//弹框
- (void)showViews{
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, HEIGHT)];
    _backview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview: _backview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(36, HEIGHT / 2 - 170 / 2, WIDHT - 72, 170)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    [_backview addSubview: view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 32, view.frame.size.width - 48, 66)];
    label.text = @"恭喜您通过了顺道嘉实名认证，未来的日子我们一路同行！";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = TCUIColorFromRGB(0x666666);
    label.numberOfLines = 0;
    [view addSubview: label];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(view.frame.size.width / 2 -  160 / 2, view.frame.size.height - 10 - 40, 160, 40);
    btn1.backgroundColor = TCUIColorFromRGB(0x2EA8E5);
    btn1.layer.cornerRadius = 20;
    btn1.layer.masksToBounds = YES;
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview: btn1];
}

- (void)back{
    [_backview removeFromSuperview];
}

- (void)clickImage:(UIGestureRecognizer *)gue{
    _index = gue.view.tag;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            __block UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            ipc.allowsEditing = NO;
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
        picker.allowsEditing = NO;
        picker.delegate = self;
        picker.navigationBar.tintColor = [UIColor whiteColor];
        picker.navigationBar.barTintColor = Color;
        [self presentViewController:picker animated:YES completion:^{
            picker = nil;
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

//picker.delegate代理方法  选择完图片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //放入全局队列中保存头像
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将头像写入沙盒
        if (_index == 1) {
            _imageData0 = UIImageJPEGRepresentation(image, 0.5);
            [_imageData0 writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"pic0.png"] atomically:NO];
        }else if (_index == 2){
            _imageData1 = UIImageJPEGRepresentation(image, 0.5);
            [_imageData1 writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"pic1.png"] atomically:NO];
        }else if (_index == 3){
            _imageData2 = UIImageJPEGRepresentation(image, 0.5);
            [_imageData2 writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"pic2.png"] atomically:NO];
        }
    });
    UIImageView *imview = (UIImageView *)[_mainScrollview viewWithTag:_index];
    imview.image = image;
    if (image) {
        _imagecount++;
    }
    [self check];
    //点击choose后跳转到前一页
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)muban{
    TCExamplesViewController *example = [[TCExamplesViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:example animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_name resignFirstResponder];
    [_address resignFirstResponder];
}


//上传事件
- (void)login:(UIButton *)sender{
    [TCPersonalCommitView showCommitView:@"1" andCommit:^{
        sender.userInteractionEnabled = NO;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        if ([_phoneNum.text isEqualToString:@""] || [_idNo.text isEqualToString:@""] || [_address.text isEqualToString:@""] || [_name.text isEqualToString:@""] || !_imageData0 || !_imageData1 || !_imageData2) {
            [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
        }else{
            //上传实名信息
            NSDictionary *paramters = @{@"mid":[self.userdefault valueForKey:@"userMID"], @"id": [self.userdefault valueForKey:@"userID"], @"token":[self.userdefault valueForKey:@"userToken"], @"name":_name.text, @"idno":_idNo.text, @"tel":_phoneNum.text, @"address":_address.text};
            NSLog(@"canshu %@", paramters);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:[TCServerSecret loginAndRegisterSecret:@"100108"] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [SVProgressHUD show];
                [SVProgressHUD showWithStatus:@"提交中..."];
                //写入图片data
                [formData appendPartWithFileData:_imageData0 name:@"pic1" fileName:@"pic0" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:_imageData1 name:@"pic2" fileName:@"pic1" mimeType:@"image/jpeg"];
                [formData appendPartWithFileData:_imageData2 name:@"pic3" fileName:@"pic2" mimeType:@"image/jpeg"];
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"提交返回信息%@", str);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:nil];
                if ([[NSString stringWithFormat:@"%@", dic[@"retValue"]] isEqualToString:@"5"]) {
                    [SVProgressHUD showSuccessWithStatus:dic[@"retMessage"]];
                    [self performSelector:@selector(dismis) withObject:nil afterDelay:1.5];
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
    } andCancel:^{
        NSLog(@"取消");
    }];
    
}

- (void)dismis{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)check{
    if ([_phoneNum.text isEqualToString:@""] || [_idNo.text isEqualToString:@""] || [_address.text isEqualToString:@""] || [_name.text isEqualToString:@""] || _imagecount < 3) {
        _commitBtn.userInteractionEnabled = NO;
        _commitBtn.backgroundColor = TCUIColorFromRGB(0xCCCCCC);
    }else{
        _commitBtn.userInteractionEnabled = YES;
        _commitBtn.backgroundColor = TCUIColorFromRGB(0x2EA8E5);
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self check];
}






@end
