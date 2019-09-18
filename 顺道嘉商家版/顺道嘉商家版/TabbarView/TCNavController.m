//
//  TCNavController.m
//  ShunDaoJia
//

#import "TCNavController.h"
#import "AppDelegate.h"

@interface TCNavController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation TCNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.禁用系统自带的返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
    //2.捕获返回手势的代理
    id target = self.interactivePopGestureRecognizer.delegate;
    // 3.添加全屏滑动返回手势，事件指向系统自带的Pop转场
    SEL backGestureSelector = NSSelectorFromString(@"handleNavigationTransition:");
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:backGestureSelector];
    //4.添加手势
    [self.view addGestureRecognizer:self.pan];
    //5.设置自己为自己代理，这样的设置不科学，但可用
    self.delegate = self;
    
    //导航栏标题的颜色字体大小
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18],
       NSForegroundColorAttributeName:TCUIColorFromRGB(0xFFFFFF)}];
    self.navigationBar.barTintColor = Color;
    //导航栏的主颜色
    [[UINavigationBar appearance] setBarTintColor:TCUIColorFromRGB(0x1F1B1E)];
    //隐藏导航栏下的黑线
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果有大于控制器
    
    if (self.childViewControllers.count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        [self setBackItem:viewController];
    }
    
    [super pushViewController:viewController animated:animated];
    // 修正push控制器tabbar上移问题
    
//    if (@available(iOS 11.0, *)){

        // 修改tabBra的frame

//        CGRect frame = self.tabBarController.tabBar.frame;
//
//        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;

        self.tabBarController.tabBar.frame = CGRectMake(0, 30, 0, 0);
//    }
}

- (void)setBackItem:(UIViewController *)controller{

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 0, 44, 44);
    // 让按钮内部的所有内容左对齐
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    controller.navigationItem.leftBarButtonItem = leftItem;

}

- (void)btn:(UIButton *)sender {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (delegate.isBack == YES){
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhifanhui" object:nil];
        return;
    } else {
        [self popViewControllerAnimated:YES];
    }
}

//导航控制器的代理，处理Pan手势是否生效，解决NavitionController的根控制器转场错乱
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 判断下当前控制器是不是根控制器
    if (navigationController.viewControllers.count>1) {
        self.pan.enabled = YES;
    }else{
        self.pan.enabled = NO;
        //手势无效，无法转场，自然不会出现转场错乱的问题。
    }
}

@end



