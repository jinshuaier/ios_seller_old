//
//  TCSeniorityViewController.m
//  顺道嘉商家版
//
//  Created by 吕松松 on 2018/1/5.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSeniorityViewController.h"
#import "TCSeniorTableViewCell.h"
@interface TCSeniorityViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate,seniorcellDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIScrollView *myscrollView;
@property (nonatomic, strong) NSData *imageData;//用来记录选取的图片
@property (nonatomic, strong) NSUserDefaults *userdefault;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) NSString *imageid;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation TCSeniorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEdit = NO;
    self.title = @"上传资历证明";
    self.view.backgroundColor = TCBgColor;
    self.userdefault = [NSUserDefaults standardUserDefaults];
    self.dataArr = [NSMutableArray array];
    [self creatRequest];
    [self creatUI];
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDHT, 48)];
    view1.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:view1];
    
    self.myscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), WIDHT, HEIGHT - 48)];
    self.myscrollView.contentSize = CGSizeMake(WIDHT, HEIGHT);
    self.myscrollView.showsVerticalScrollIndicator = FALSE;
    self.myscrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:self.myscrollView];
    
    UILabel *jieshaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDHT - 30, 18)];
    jieshaoLabel.text = @"可上传多张资历证明，有助于店铺快速审核通过";
    jieshaoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    jieshaoLabel.textColor = TCUIColorFromRGB(0x53C3C3);
    jieshaoLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:jieshaoLabel];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake((WIDHT - 240)/2, 0, 240, (self.dataArr.count + 1) * (135 + 30))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.showsVerticalScrollIndicator = NO;//隐藏分割线
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = TCBgColor;
    [self.myscrollView addSubview:self.mainTableView];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(self.mainTableView.frame) + 40, WIDHT - 30, 48)];
    self.saveBtn = saveBtn;
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setTitleColor:TCUIColorFromRGB(0xFFFFFF) forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor: TCUIColorFromRGB(0x53C3C3)];
    [saveBtn addTarget:self action:@selector(clickSave:) forControlEvents:(UIControlEventTouchUpInside)];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 5;
    saveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.myscrollView addSubview:saveBtn];
}

#pragma mark -- UITableViewDelegate
#pragma mark -- tableViewDelegateMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
//预防ios11错误
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 0)];
        headerView.backgroundColor = TCBgColor;
        return headerView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCSeniorTableViewCell *cell = [[TCSeniorTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    if (indexPath.section == self.dataArr.count) {
        cell.deleBtn.hidden = YES;
        cell.bgImage.hidden = YES;
        UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(97, 30, 46, 40)];
        photoImage.image = [UIImage imageNamed:@"相机图标"];
        [cell.contentView addSubview:photoImage];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(photoImage.frame) + 20, 240, 15)];
        label.text = @"点击上传资历证明";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = TCUIColorFromRGB(0x666666);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }else{
       [cell.bgImage sd_setImageWithURL:[NSURL URLWithString: self.dataArr[indexPath.section][@"image"]]];
        cell.deleBtn.hidden = NO;
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArr.count) {
        [self clickalphaView];
    }else{
        self.imageid = self.dataArr[indexPath.section][@"imageid"];
        self.isEdit = YES;
        [self deleteRequest];
    }
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

#pragma mark -- 请求接口获取已上传的图片
-(void)creatRequest{
    [self.dataArr removeAllObjects];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"3"};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"3"};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201020"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            NSArray *arr = jsonDic[@"data"];
            //NSString *imageStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"][0][@"src"]];
            if (arr.count == nil) {
                
            }else{
            for (NSDictionary *info in jsonDic[@"data"]) {
                NSString *imageStr = [NSString stringWithFormat:@"%@",info[@"src"]];
                NSString *imageid = [NSString stringWithFormat:@"%@",info[@"imageid"]];
                    NSDictionary*dicinfo = @{@"image":imageStr,@"imageid":imageid};
                    [self.dataArr addObject:dicinfo];
               
            }
            }
            [self.mainTableView reloadData];
            self.mainTableView.frame =  CGRectMake((WIDHT - 240)/2, 0, 240, (self.dataArr.count + 1) * (135 + 30));
            self.myscrollView.contentSize = CGSizeMake(WIDHT, 30 + (self.dataArr.count + 1) * (135 + 30) + 138);
            if (self.dataArr.count < 2) {
                self.myscrollView.scrollEnabled = NO;
            }else{
                self.myscrollView.scrollEnabled = YES;
            }
           self.saveBtn.frame = CGRectMake(15,CGRectGetMaxY(self.mainTableView.frame) + 40, WIDHT - 30, 48);
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
       
        
    } failure:^(NSError *error) {
        nil;
    }];
}

#pragma mark -- 上传服务器
-(void)imageQuest{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"type":@"3"};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"type":@"3"};
    //提交修改，上传图片至服务器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[TCServerSecret loginAndRegisterSecretOffline:@"201006"] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //开始滚动
        if (self.imageData) {
            [formData appendPartWithFileData:self.imageData  name:@"qualification" fileName:@"qualification.png" mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [TCProgressHUD showMessage:dic[@"msg"]];
        NSLog(@"提交图片的返回结果 %@", dic[@"msg"]);
        
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            [self creatRequest];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    
}

//picker.delegate代理方法  选择完图片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    //放入全局队列中保存头像
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //将头像写入沙盒
        _imageData = UIImageJPEGRepresentation(image, 0.5);
        [_imageData writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"store.png"] atomically:YES];
        
        [self imageQuest];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- cellDelegate
-(void)didClickDelete:(UIButton *)button{
    TCSeniorTableViewCell *cell = (TCSeniorTableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSLog(@"第%ld个元素",(long)indexPath.section);
    self.isEdit = NO;
    self.imageid = self.dataArr[indexPath.section][@"imageid"];
    [self deleteRequest];
    
    
}
-(void)deleteRequest{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"获取中..."];
    NSString *mid = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userID"]];
    NSString *token = [NSString stringWithFormat:@"%@",[self.userdefault valueForKey:@"userToken"]];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *shopID =[NSString stringWithFormat:@"%@",[_userdefault valueForKey:@"shopID"]];
    NSDictionary *dic = @{@"timestamp":Timestr,@"mid":mid,@"token":token,@"shopid":shopID,@"imageid":self.imageid};
    NSString *signStr = [TCServerSecret signStr:dic];
    NSDictionary *paramters = @{@"mid":mid,@"token":token,@"timestamp":Timestr,@"sign":signStr,@"shopid":shopID,@"imageid":self.imageid};
    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201009"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        [SVProgressHUD dismiss];
        NSLog(@"%@---%@",jsonDic,jsonStr);
        NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
        if ([codeStr isEqualToString:@"1"]) {
            
            if (_isEdit == YES) {
                [self clickalphaView];
            }else{
                [self creatRequest];
                [TCProgressHUD showMessage:jsonDic[@"msg"]];
            }
            
        }else{
            [TCProgressHUD showMessage:jsonDic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)clickSave:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"returnzizhi" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
