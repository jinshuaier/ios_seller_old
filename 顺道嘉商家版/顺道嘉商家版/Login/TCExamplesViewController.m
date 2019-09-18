//
//  TCExamplesViewController.m
//  顺道嘉(新)
//
//  Created by Macx on 16/9/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TCExamplesViewController.h"

@interface TCExamplesViewController ()

@end

@implementation TCExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实例照片";
    self.view.backgroundColor = ViewColor;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //创建view
    [self createView];
    // Do any additional setup after loading the view.
}
#pragma mark -- view
-(void)createView
{
    UIView *view_one = [[UIView alloc]init];
    view_one.frame = CGRectMake(0, 64, WIDHT, 105*HEIGHTSCALE);
    view_one.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_one];

    
    UIImageView *imageSuretwo = [[UIImageView alloc]init];
    imageSuretwo.frame = CGRectMake(0, 64, WIDHT, 496/2*HEIGHTSCALE);
    imageSuretwo.image = [UIImage imageNamed:@"用户版实例照片.png"];
    [self.view addSubview:imageSuretwo];
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
