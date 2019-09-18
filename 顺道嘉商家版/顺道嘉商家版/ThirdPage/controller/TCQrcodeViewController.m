//
//  TCQrcodeViewController.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/8/29.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCQrcodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TCShopEditViewController.h"
#import "TCAddGoodsViewController.h"

@interface TCQrcodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) NSUserDefaults *userdefaults;
@end

@implementation TCQrcodeViewController


- (void)viewWillAppear:(BOOL)animated
{
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
        
    }
    [_session startRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"二维码添加";
    _userdefaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor darkGrayColor]colorWithAlphaComponent:0.9]];

    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [SVProgressHUD showErrorWithStatus:@"相机权限受限，请在设置中更改"];
    }else{
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

        _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];

        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];


        //  x轴与y轴参数互换
        [_output setRectOfInterest:CGRectMake(164 * HEIGHTSCALE / HEIGHT, (WIDHT - 220 * WIDHTSCALE) / 2 / WIDHT, 220 * WIDHTSCALE / HEIGHT, 220 * WIDHTSCALE / WIDHT)];


        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput: _input]) {
            [_session addInput: _input];
        }
        if ([_session canAddOutput: _output]) {
            [_session addOutput: _output];
        }

        //添加条码类型
        _output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];

        _preview = [AVCaptureVideoPreviewLayer layerWithSession: _session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = CGRectMake(0, 0, WIDHT, HEIGHT - 64);
        [self.view.layer insertSublayer:_preview above:0];

        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake((WIDHT - 220 * WIDHTSCALE) / 2,  164 * HEIGHTSCALE, 220 * WIDHTSCALE, 220 * WIDHTSCALE)];
        [self.view addSubview: vi];


        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, vi.frame.origin.y)];
        view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self.view addSubview: view1];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, view1.frame.size.height - 60, WIDHT, 30)];
        lb.text = @"将条码置于框中，即可自动扫描";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:17];
        [view1 addSubview: lb];

        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, vi.frame.origin.y + vi.frame.size.height, WIDHT, HEIGHT - vi.frame.origin.y - vi.frame.size.height)];
        view2.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self.view addSubview: view2];


        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, vi.frame.origin.y, vi.frame.origin.x , vi.frame.size.height)];
        view3.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self.view addSubview: view3];

        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(vi.frame.origin.x + vi.frame.size.width, vi.frame.origin.y, view3.frame.size.width, vi.frame.size.height)];
        view4.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self.view addSubview: view4];


        //划线
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x, vi.frame.origin.y - 2, 50 * WIDHTSCALE, 4)];
        line1.backgroundColor = mainColor;
        [self.view addSubview: line1];

        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.size.width + vi.frame.origin.x - 50 * WIDHTSCALE, vi.frame.origin.y - 2, 50 * WIDHTSCALE, 4)];
        line2.backgroundColor = mainColor;
        [self.view addSubview: line2];

        UILabel *lin3 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x - 2, vi.frame.origin.y, 4, 50 * WIDHTSCALE)];
        lin3.backgroundColor = mainColor;
        [self.view addSubview: lin3];

        UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x - 2, vi.frame.origin.y + vi.frame.size.height - 50 * WIDHTSCALE, 4, 50 * WIDHTSCALE)];
        line4.backgroundColor = mainColor;
        [self.view addSubview: line4];

        UILabel *line5 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x, vi.frame.origin.y + vi.frame.size.height - 2 , 50 * WIDHTSCALE, 4)];
        line5.backgroundColor = mainColor;
        [self.view addSubview: line5];

        UILabel *lin6 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x + vi.frame.size.width - 50 * WIDHTSCALE, vi.frame.origin.y + vi.frame.size.height - 2, 50 * WIDHTSCALE, 4)];
        lin6.backgroundColor = mainColor;
        [self.view addSubview: lin6];

        UILabel *line7 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x + vi.frame.size.width - 2, vi.frame.origin.y, 4, 50 * WIDHTSCALE)];
        line7.backgroundColor = mainColor;
        [self.view addSubview: line7];

        UILabel *line8 = [[UILabel alloc]initWithFrame:CGRectMake(vi.frame.origin.x + vi.frame.size.width - 2, vi.frame.origin.y + vi.frame.size.height - 50 * WIDHTSCALE, 4, 50 * WIDHTSCALE)];
        line8.backgroundColor = mainColor;
        [self.view addSubview: line8];
        
        
        [_session startRunning];
    }
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        TCAddGoodsViewController *edit = [[TCAddGoodsViewController alloc]init];
        [SVProgressHUD showWithStatus:@"获取中..."];
        
        NSString *Timestr = [TCGetTime getCurrentTime];
        NSString *midStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userID"]];
        NSString *tokenStr = [NSString stringWithFormat:@"%@",[_userdefaults valueForKey:@"userToken"]];
        
        NSDictionary *dic = @{@"barcode":stringValue,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
        NSString *singStr = [TCServerSecret loginStr:dic];
        NSDictionary *parameters = @{@"barcode":stringValue,@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr,@"sign":singStr};
        
        [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201035"] paramter:parameters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
            //成功
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"1"]) {
                [SVProgressHUD showSuccessWithStatus:jsonDic[@"msg"]];
                edit.codeStr = stringValue;
                edit.QrDic = jsonDic[@"data"];
                edit.hidesBottomBarWhenPushed = YES;
                edit.isQr = YES;

                [self.navigationController pushViewController:edit animated:YES];
//                edit.hidesBottomBarWhenPushed = NO;
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"msg"]];
                edit.isQr = YES;
                edit.codeStr = stringValue;
                edit.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:edit animated:YES];
//                edit.hidesBottomBarWhenPushed = NO;
            }
        } failure:^(NSError *error) {
            nil;
        }];
    }
}



#pragma mark -- 左边返回按钮
- (void)barButtonItemsao:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}





@end
