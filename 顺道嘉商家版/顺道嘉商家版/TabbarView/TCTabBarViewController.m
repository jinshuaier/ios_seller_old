//
//  TCTabBarViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCTabBarViewController.h"
#import "TCOrderViewController.h"
#import "TCShopViewController.h"
#import "TCGoodsViewController.h"
#import "TCTabbarView.h"
#import "TCShopsManaerViewController.h"
#import "TCMessageNewsViewController.h"
#import "TCNavController.h"

@interface TCTabBarViewController ()<UITabBarDelegate>
@property (nonatomic, strong) NSUserDefaults *userdefault;
@end

@implementation TCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor darkGrayColor]colorWithAlphaComponent:0.9]];
    _userdefault = [NSUserDefaults standardUserDefaults];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //未知网络
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //没有网络
                [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络!"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //wifi
                //                [SVProgressHUD showInfoWithStatus:@"wifi"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //3G,4G
                //                [SVProgressHUD showInfoWithStatus:@"移动网络"];
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
    // 添加子控制器
    [self addOneChildVcClass:[TCOrderViewController class] title:@"订单" image:@"订单iconNS" selectedImage:@"订单iconS"];
      [self addOneChildVcClass:[TCMessageNewsViewController class] title:@"消息" image:@"消息iconNS" selectedImage:@"消息iconS"];
    [self addOneChildVcClass:[TCShopsManaerViewController class] title:@"商品管理" image:@"团购图标NS" selectedImage:@"团购图标S"];
    [self addOneChildVcClass:[TCShopViewController class] title:@"我的店铺" image:@"我的ICONNS" selectedImage:@"我的ICONS"];
}

/**
 * 添加一个子控制器
 * @param vcClass : 子控制器的类名
 * @param title : 标题
 * @param image : 图片
 * @param selectedImage : 选中的图片
 */
- (void)addOneChildVcClass:(Class)vcClass title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    UIViewController *vc = [[vcClass alloc] init];
    [self addOneChildVc:vc title:title image:image selectedImage:selectedImage];

}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"item name = %@", item.title);
}

/**
 * 添加一个子控制器
 * @param vc : 子控制器
 * @param title : 标题
 * @param image : 图片
 * @param selectedImage : 选中的图片
 */
- (void)addOneChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    //设置navigation的颜色为橘色
    [[UINavigationBar appearance]setBarTintColor:Color];
    //设置导航栏字体为白色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    //设置导航栏返回按钮
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    //设置导航控件颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundColor:Color];
    //状态栏颜色
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //设置不透明
    [UINavigationBar appearance].translucent = NO;

    //去除导航栏横线
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance]setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:70 / 255.0 green:173 / 255.0 blue:173 / 255.0 alpha:1], NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    // 同时设置tabbar每个标签的文字 和 navigationBar的文字
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    // 包装一个导航控制器后,再成为tabbar的子控制器
    TCNavController *nav = [[TCNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
