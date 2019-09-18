//
//  TCChooseAddressViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/8.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCChooseAddressViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "TCLocation.h"


@interface TCChooseAddressViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong) MAMapView *mapView; //地图
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton; //自定义大头针
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) TCLocation *location;
@property (nonatomic, strong) UILabel *labelLocation; //位置
@property (nonatomic, strong) UITextField *disField; //详细位置
@property (nonatomic, strong) NSString *disStr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UILabel *tishiLabel;
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong) NSString *latitude;//纬度

@end

@implementation TCChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前位置";
    self.view.backgroundColor = TCBgColor;
    
    //创建Map地图
    [self initMapView];
    //自定义的大头针
    UIImageView *pointImage = [[UIImageView alloc] init];
    pointImage.frame = CGRectMake((WIDHT - 15)/2, (HEIGHT - 24)/2, 15, 24);
    pointImage.image = [UIImage imageNamed:@"地图上搜索的位置图标"];
    [self.view addSubview:pointImage];
    
    // Do any additional setup after loading the view.
}

//创建地图
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        self.mapView.delegate = self;
        //范围圈自定义
        self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        self.mapView.showsUserLocation = YES; //开启定位
        //        self.locationManager = [[AMapLocationManager alloc]init];
        //        self.locationManager.delegate = self;
        //        [self.locationManager setDesiredAccuracy:(kCLLocationAccuracyBest)];
        //        [self.locationManager startUpdatingLocation];
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动，并将定位点设置成地图中心点。
        [_mapView setZoomLevel:16.1 animated:YES];
        [self.view addSubview:self.mapView];
        
        //去掉logo的图标
        [self deleLogo];
        
        //添加地图的信息
        [self createView];
        
        //初始化大头针
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [_mapView addAnnotation:self.pointAnnotaiton];
    }
}

-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"经纬度:%f-%f",location.coordinate.latitude, location.coordinate.longitude);
}

#pragma mark - MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //        NSLog(@"latitude : %f , longitude : %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
}

//地图移动结束后调用
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    if(mapView)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
        //逆编码
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
        regeo.requireExtension = YES;
        //发起逆地理编码
        [self.search AMapReGoecodeSearch:regeo];
        
        //进行POI搜索
        if (_search == nil){
            return;
        }
        //设置周边请求参数
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
        //request.types = @"风景名胜";
        request.sortrule = 0;
        request.requireExtension = YES;
        
        [_search AMapPOIAroundSearch:request];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        NSLog(@"ReGeo: %@ -%@- %@", result,response.regeocode.formattedAddress,response.regeocode.addressComponent.streetNumber.street);
        
        
    }
}

//POI搜索回调的方法
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0){
        return;
    }
    
    for (AMapPOI *poi in response.pois) {
        NSString *name = poi.name;
        NSString *address = poi.address;
        NSString *district = poi.district;
        NSString * longitude = [NSString stringWithFormat:@"%f",poi.location.longitude];
        NSString * latitude = [NSString stringWithFormat:@"%f",poi.location.latitude];
        NSDictionary *dic1 = @{@"name":name,@"address":address,@"district":district,@"longitude":longitude,@"latitude":latitude};
       
    }
    self.longitude = [NSString stringWithFormat:@"%f",response.pois[0].location.longitude];
    self.latitude = [NSString stringWithFormat:@"%f",response.pois[0].location.latitude];
    
    self.labelLocation.text = response.pois[0].name;
    self.disField.text = response.pois[0].address;
    CGSize size = [self.disField sizeThatFits:CGSizeMake(WIDHT - 30 - 55, MAXFLOAT)];
    self.disField.frame = CGRectMake(30, CGRectGetMaxY(self.labelLocation.frame) + 31, WIDHT - 30 - 55, size.height);
    self.tishiLabel.frame = CGRectMake(30, CGRectGetMaxY(self.disField.frame) + 5, WIDHT - 30 - 55, 18);
    self.locationView.frame =CGRectMake(15, self.okBtn.frame.origin.y - 15 - 140, WIDHT - 30, CGRectGetMaxY(self.tishiLabel.frame) + 16);
}
//添加地图的信息View
- (void)createView {
    
    //确定的按钮
    UIButton *okBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.okBtn = okBtn;
    okBtn.frame = CGRectMake(15, HEIGHT - 15 - 48 - StatusBarAndNavigationBarHeight, WIDHT - 30, 48);
    okBtn.backgroundColor = TCUIColorFromRGB(0x53C3C3);
    [okBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [okBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    okBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [okBtn addTarget:self action:@selector(ok:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mapView addSubview:okBtn];
    
    //添加View
    self.locationView = [[UIView alloc] init];
    self.locationView.frame = CGRectMake(15, okBtn.frame.origin.y - 15 - 122, WIDHT - 30, 122);
    self.locationView.backgroundColor = [UIColor whiteColor];
    [self.mapView addSubview:self.locationView];
    
    //小View
    UIView *dingweiView = [[UIView alloc] init];
    dingweiView.frame = CGRectMake(0, 0, WIDHT - 30, 50);
    [self.locationView addSubview:dingweiView];
    
    //添加图标、文字、图片、输入框
    UIImageView *imageLocation = [[UIImageView alloc] init];
    imageLocation.image = [UIImage imageNamed:@"位置图标(面)"];
    imageLocation.frame = CGRectMake(7, 17, 14, 16);
    [dingweiView addSubview:imageLocation];
    
    self.labelLocation = [[UILabel alloc] init];
    self.labelLocation.frame = CGRectMake(CGRectGetMaxX(imageLocation.frame) + 10,15, WIDHT - 30 - 10 - 21,20);
    self.labelLocation.text = @"金融街园中园";
    self.labelLocation.textAlignment = NSTextAlignmentLeft;
    self.labelLocation.textColor = TCUIColorFromRGB(0x333333);
    self.labelLocation.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [dingweiView addSubview:self.labelLocation];
    

    
    //细线
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(dingweiView.frame), WIDHT - 30, 1);
    lineView.backgroundColor = TCLineColor;
    [dingweiView addSubview:lineView];
    
    //详细的地址
    //    self.disField = [UILabel publicLab:@"朝阳北路与温榆河西路交汇处北2公里" textColor:TCUIColorFromRGB(0x666666) textAlignment:NSTextAlignmentLeft fontWithName:@"PingFangSC-Regular" size:14 numberOfLines:0];
    //    self.disField.
    self.disField = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lineView.frame) + 15, WIDHT - 30 - 55,18)];
    self.disField.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    self.disField.textAlignment = NSTextAlignmentLeft;
    [self.disField setEnabled:YES];
    self.disField.borderStyle = UITextBorderStyleNone;
    self.disField.delegate = self;
    self.disField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.disField.textColor = TCUIColorFromRGB(0x666666);
    [self.locationView addSubview:self.disField];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.disField.frame) + 5, WIDHT - 30 - 55, 18)];
    self.tishiLabel = tishiLabel;
    tishiLabel.text = @"(填写详细地址至门牌号，与营业执照地址一致)";
    tishiLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    tishiLabel.textColor = TCUIColorFromRGB(0xC4C4C4);
    tishiLabel.textAlignment = NSTextAlignmentLeft;
    [self.locationView addSubview:tishiLabel];

    
    UIButton *locationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    locationBtn.frame = CGRectMake(WIDHT - 15 - 36, self.locationView.frame.origin.y - 20 - 36, 36, 36);
    [locationBtn setImage:[UIImage imageNamed:@"定位（地图）"] forState:(UIControlStateNormal)];
    [locationBtn addTarget:self action:@selector(locationBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mapView addSubview:locationBtn];
    
    
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout   = NO;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.image            = [UIImage imageNamed:@"地图上搜索的位置图标"];
        return annotationView;
    }
    
    return nil;
}

//去掉高德logo图标
- (void)deleLogo
{
    [self.mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            
            UIImageView * logoM = obj;
            
            logoM.layer.contents = (__bridge id)[UIImage imageNamed:@""].CGImage;
        }
    }];
}

//范围圈的回调函数
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    
    if(overlay == mapView.userLocationAccuracyCircle)
    {
        MACircle *accuracyCircleView = (MACircle *)overlay  ;
        MACircleRenderer *circleRend = [[MACircleRenderer alloc] initWithCircle:accuracyCircleView];
        circleRend.alpha = 0.3;
        //  填充颜色
        circleRend.fillColor = [TCUIColorFromRGB(0xFF4C79) colorWithAlphaComponent:0.2];
        //  边框颜色
        circleRend.strokeColor = TCUIColorFromRGB(0xFF4C79);
        return circleRend;
    }
    return nil;
}

#pragma mark -- 手势点击事件
- (void)tap
{
    NSLog(@"11111");
//    NSLog(@"地图商圈");
//    TCSearchMapViewController *searchMapVC = [[TCSearchMapViewController alloc] init];
//    searchMapVC.adressArr = self.dataArray;
//    searchMapVC.addressBlock = ^(TCNearAddInfo *model) {
//        self.labelLocation.text = model.name;
//        self.disField.text = model.address;
//        self.model = model;
//    };
//    [self.navigationController pushViewController:searchMapVC animated:YES];
}
#pragma mark -- 确定的按钮
- (void)ok:(UIButton *)sender
{
    NSLog(@"确定的按钮");
    NSString *address = [NSString stringWithFormat:@"%@%@",self.disField.text,self.labelLocation.text];
//    TCNearAddInfo *model = self.dataArray[0];
    self.diBlock(self.disField.text,self.labelLocation.text, self.longitude, self.latitude);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 搜索
- (void)clickRightBtn
{
//    NSLog(@"搜索");
//    TCSearchMapViewController *searchMapVC = [[TCSearchMapViewController alloc] init];
//    searchMapVC.adressArr = self.dataArray;
//    [self.navigationController pushViewController:searchMapVC animated:YES];
}
#pragma mark -- 重新定位按钮的点击事件
- (void)locationBtn:(UIButton *)sender
{
    [self.mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];

    // self.mapView.showsUserLocation = YES; //开启定位
    //开始定位
    //self.pointAnnotaiton.coordinate = self.userLocation.coordinate;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.disField resignFirstResponder];
    //结束编辑时整个试图返回原位
    [self.disField resignFirstResponder];
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = CGRectMake(0, 0, WIDHT, HEIGHT );
    [UIView commitAnimations];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    //开始编辑时使整个视图整体向上移
    [UIView beginAnimations:@"up" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = CGRectMake(0, -300, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
    
    return YES;
}
#pragma mark -- 点击return 下滑
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    //结束编辑时整个试图返回原位
    [textField resignFirstResponder];
    [UIView beginAnimations:@"down" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, WIDHT, HEIGHT );
    [UIView commitAnimations];
    
    return YES;
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
