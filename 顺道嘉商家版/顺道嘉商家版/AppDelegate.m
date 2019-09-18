//
//  AppDelegate.m
//  顺道嘉商家版
//
//  Created by 某某 on 16/7/27.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "TCLoginViewController.h"
#import "TCTabBarViewController.h"
#import "TCNavController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "Pingpp.h"
#import <AVFoundation/AVFoundation.h>
#import "JKNotifier.h"
#import <UserNotifications/UserNotifications.h>
#import "TCOrderViewController.h"
#import "TCAlertView.h"
//友盟的头文件
#import "UMMobClick/MobClick.h"
//创建活动的弹窗
#import "TCCheckActityView.h"
//交易完成的商家弹窗
#import "TCCodeCheckView.h"
//百度统计的头文件
#import "BaiduMobStat.h"
//审核保证金
#import "GYTipView.h"

#import "TCUpdateView.h"

#import "UncaughtExceptionHandler.h"

#import "AppDelegate+JPush.h"

@interface AppDelegate ()<AVAudioPlayerDelegate,JPUSHRegisterDelegate>
@property (nonatomic, assign) BOOL isIntave; //添加一个字段，判断是否前台和后台
@property (nonatomic, strong) NSString *message;//传递的消息
@property (nonatomic, strong) NSString *type; //这个是判断跳转的类型 order
@property (nonatomic, strong) NSString *btype;// blance
@property (nonatomic, strong) NSString *bbid;// blance
@property (nonatomic, strong) NSString *pbid;//blance
@property (nonatomic, strong) NSString *moneyStr;//获得的奖金
@property (nonatomic, strong) NSString *urlstr;//message
@property (nonatomic, strong) NSString *pushtype;
@property (nonatomic, strong) NSString *string ;//声音字段
@property (nonatomic, strong) TCCheckActityView *checkView;
@property (nonatomic, strong) AVAudioPlayer *avAudioPlayer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //高德key
    [AMapServices sharedServices].apiKey = @"2d58ec621837d3f5fce5b68aeedf7abe";
    //友盟统计
    [self umengTrack];
    //设置整体框架
    [self setFrame];
    //百度统计
    [self baiduTongJi];
    
    //调用自定义类中的收集崩溃信息的方法
    InstallUncaughtExceptionHandler();
    
    [self configureJPushWithOptions:launchOptions];//极光推送
    
    // 避免多个按钮同时点击
    [[UIButton appearance] setExclusiveTouch:YES];
    
    return YES;
}

- (void)setFrame{
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"userToken"]) {
        TCTabBarViewController *tab = [[TCTabBarViewController alloc]init];
        self.window.rootViewController  = tab;
    }else{
        TCNavController *naVC = [[TCNavController alloc]initWithRootViewController:[[TCLoginViewController alloc]init]];
        self.window.rootViewController = naVC;
    }
    [_window makeKeyAndVisible];
    
    //请求版本更新
    [self versionUpdate];
}
//检测更新
- (void)versionUpdate{
    
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSDictionary *dic = @{@"timestamp":Timestr};
    NSString *singStr = [TCServerSecret loginStr:dic];
    NSDictionary *paramters = @{@"timestamp":Timestr,@"sign":singStr};

    [TCNetworking postWithTcUrlString:[TCServerSecret loginAndRegisterSecretOffline:@"201039"] paramter:paramters success:^(NSString *jsonStr, NSDictionary *jsonDic) {
        if (jsonDic[@"data"]) {
            if ([[NSString stringWithFormat:@"%@", jsonDic[@"code"]] isEqualToString:@"1"]) {
                
                //获得当前版本
                NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
                if (jsonDic[@"data"][@"version"] && ![jsonDic[@"data"][@"version"] isEqualToString:currentVersion]) {
                    [TCUpdateView upDateView:jsonDic[@"data"][@"updateContent"]];
                }
            }else{
                NSLog(@"未开启检测更新");
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
}
#pragma mark -- 获取传给服务器的ID,可以获得自定义的消息
-(void)notification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}
-(void)networkDidReceiveMessage:(NSNotification *)notification{
    [self getMessage:notification];
}
//这里是获取系统的消息，基本上自定义消息这里没什么用
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark -- 获得的自定义消息
-(void)getMessage:(NSNotification *)notification{
    // 取得 APNs 标准信息内容
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"userInfo:-----你能收到的消息是%@",userInfo);
    NSDictionary *aps = [userInfo valueForKey:@"extras"];
    self.pushtype = [aps valueForKey:@"pushtype"];
    /************ 创建活动的审核 **************/
    if([self.pushtype isEqualToString:@"activity"])
    {
        NSString *typeStr = [NSString stringWithFormat:@"%@",[aps valueForKey:@"type"]];
        if([typeStr isEqualToString:@"1"]){
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100000] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100001] removeFromSuperview];
            self.checkView = [[TCCheckActityView alloc] initWithFrame:self.window.frame andmessage:[userInfo valueForKey:@"title"]];
    
        }else if ([typeStr isEqualToString:@"2"]){
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100000] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100002] removeFromSuperview];
            self.checkView = [[TCCheckActityView alloc] initWithFrame:self.window.frame andTtile:aps[@"reason"] andMessage:[userInfo valueForKey:@"title"]];
            self.checkView.contentActity = [userInfo valueForKey:@"content"];
        }
            [[UIApplication sharedApplication].keyWindow addSubview:self.checkView];
    }
    /************ 用户交易完的推送 *********************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"qrcodePay"])
    {
        NSString *monerStr = [NSString stringWithFormat:@"¥%@",[aps valueForKey:@"pushinfo"][@"money"]];
        TCCodeCheckView *CodecheckView = [[TCCodeCheckView alloc] initWithFrame:self.window.frame andTtile:monerStr andtime:[aps valueForKey:@"pushinfo"][@"time"]];
        CodecheckView.CodeCheckOid = [aps valueForKey:@"pushinfo"][@"oid"];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:100001] removeFromSuperview];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:100002] removeFromSuperview];
       [[[UIApplication sharedApplication].keyWindow viewWithTag:100003] removeFromSuperview];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:100005] removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow addSubview:CodecheckView];
    }
    /************ order类型下的pushinfo    ************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"order"]){
        NSDictionary *pushinfo = [aps valueForKey:@"pushinfo"];
        NSString *messageid = [pushinfo valueForKey:@"messageid"];//消息id
        NSString *oid = [pushinfo valueForKey:@"oid"];//订单id
        self.type = [pushinfo valueForKey:@"type"];//订单的类型
        self.message = [userInfo valueForKey:@"title"];
        NSLog(@"messageid是:%@ %@ %@ %@",messageid,oid,self.type,self.message);
    }
    /************ blance类型下的pushinfo    ************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"bills"]){
        NSDictionary *pushinfo = [aps valueForKey:@"pushinfo"];
        NSString *messageid = [pushinfo valueForKey:@"bid"];//消息id
        //据解析这里面类型是NSNumber类型的，转化成NSString
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        if([[pushinfo valueForKey:@"bbid"] isKindOfClass:[NSNumber class]]){
            self.bbid =  [numberFormatter stringFromNumber:[pushinfo valueForKey:@"bbid"]];//分润账单id
        }else{
            self.bbid =  [pushinfo valueForKey:@"bbid"];//分润账单id
        }
            self.btype = [numberFormatter stringFromNumber:[pushinfo valueForKey:@"btype"]];//订单的类型
        if([[pushinfo valueForKey:@"pbid"] isKindOfClass:[NSNumber class]]){
            self.pbid =  [numberFormatter stringFromNumber:[pushinfo valueForKey:@"pbid"]];//分润账单id
        }else{
            self.pbid =  [pushinfo valueForKey:@"pbid"];//分润账单id
        }
        self.moneyStr = [numberFormatter stringFromNumber:[pushinfo valueForKey:@"money"]];
        NSLog(@" 现在的钱数是:%@",self.moneyStr);
        self.message = [userInfo valueForKey:@"title"];
        NSLog(@"messageid是:%@ %@ %@ %@ %@",messageid,self.bbid,self.btype,self.message,self.pbid);
    }
    /************ message类型下的pushinfo    ************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"message"]){
        NSDictionary *pushinfo = [aps valueForKey:@"pushinfo"];
        NSString *messageid = [pushinfo valueForKey:@"mid"];//消息id
        self.urlstr =  [NSString stringWithFormat:@"%@",[pushinfo valueForKey:@"url"]];
        
        self.message = [userInfo valueForKey:@"messageid"];
        NSLog(@"messageid是:%@ %@ %@",messageid,self.urlstr,self.message);
        
    }
    /************ message类型下的purchase *************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"purchase"]){
//        TCAlertView *alert = [[TCAlertView alloc]initWithFrame:self.window.frame andTtile:[userInfo valueForKey:@"title"]];
//        [self.window addSubview:alert];
    }
    /************  bond类型 保证金的审核 *****************/
    if([[aps valueForKey:@"pushtype"] isEqualToString:@"bond"]){
        NSString *typeStr = [NSString stringWithFormat:@"%@",[aps valueForKey:@"type"]];
        if([typeStr isEqualToString:@"1"]){
            //通过审核
           [GYTipView ShowTipView:userInfo[@"content"]];
           
        }else{
            //未通过审核
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100000] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100002] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100003] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:100005] removeFromSuperview];
            self.checkView = [[TCCheckActityView alloc] initWithFrame:self.window.frame andTtiles:[userInfo valueForKey:@"content"] andMessages:[userInfo valueForKey:@"title"]];
        }
        
    }
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"--------%@",customizeField1);
}

#pragma mark -- 注册成功
- (void)application:(UIApplication *)application  didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
}
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}
#pragma mark -- 新版的版本
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *alert = [aps valueForKey:@"alert"];//消息内容
    NSString *sounds = [aps valueForKey:@"sound"];// 消息声音
    if([sounds isEqualToString:@"default"]){
        NSLog(@"系统默认的声音");
    }else{
        //截取字符串，用来声音的推送
        NSRange range = [sounds rangeOfString:@"."];
        sounds = [sounds substringToIndex:range.location];
        NSLog(@"string:%@",sounds);
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            NSLog(@"iOS10 前台收到远程通知");
            self.isIntave = YES;
            if([sounds isEqualToString:@"sound"]){
                self.string = [[NSBundle mainBundle]pathForResource:sounds ofType:@"mp3"];
            }else{
                self.string = [[NSBundle mainBundle]pathForResource:sounds ofType:@"caf"];
            }
            //把音频文件转换成url格式
            NSURL *url = [NSURL fileURLWithPath:self.string];
            //初始化音频类，添加播放器
            NSError *error = nil;
            _avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
            //设置代理
            _avAudioPlayer.delegate = self;
            //设置音乐播放器的次数
            _avAudioPlayer.numberOfLoops = 0;
            [_avAudioPlayer prepareToPlay];
            NSUserDefaults *default_sounds = [NSUserDefaults standardUserDefaults];
            NSString *sounds = [default_sounds objectForKey:@"open"];
            BOOL iscan = [[ NSUserDefaults standardUserDefaults ] boolForKey:@"lights" ];
            if(iscan){
                [_avAudioPlayer stop];
                _avAudioPlayer = nil;
            }else{
                [_avAudioPlayer play];
            }
            //加了个本地通知
            UILocalNotification *notification=[[UILocalNotification alloc] init];
            if (notification!=nil) {
                NSDate *now=[NSDate date];
                notification.fireDate=[now dateByAddingTimeInterval:1];
                notification.timeZone=[NSTimeZone defaultTimeZone];
                notification.alertBody = alert;
                NSLog(@" 您接收到的消息是:%@",alert);
                notification.soundName = sounds;
                [notification setApplicationIconBadgeNumber:1];
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
            }
            NSLog(@"本地通知1秒后触发");
        }
    }
}
// iOS 10 Support
//后台
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self goToMssageView];
    }
    completionHandler(); //
}

//ios7系统下
//只要有推送都会走这个方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)   (UIBackgroundFetchResult))completionHandler {
    NSLog(@"推送消息呢===%@",userInfo);
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *alert = [aps valueForKey:@"alert"];//消息内容
    NSString *sounds = [aps valueForKey:@"sound"];// 消息声音
    if([sounds isEqualToString:@"default"]){
        NSLog(@"系统默认的声音");
    }else{
        //截取字符串，用来声音的推送
        NSRange range = [sounds rangeOfString:@"."];
        sounds = [sounds substringToIndex:range.location];
        //前台(通知不一样需要加判断) 可以加个本地推送哦
        if(application.applicationState == UIApplicationStateActive){
            self.isIntave = YES;
            if([sounds isEqualToString:@"sound"]){
                self.string = [[NSBundle mainBundle]pathForResource:sounds ofType:@"mp3"];
            }else{
                self.string = [[NSBundle mainBundle]pathForResource:sounds ofType:@"caf"];
            }
            //把音频文件转换成url格式
            NSURL *url = [NSURL fileURLWithPath:self.string];
            //初始化音频类，添加播放器
            NSError *error = nil;
            _avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
            //设置代理
            _avAudioPlayer.delegate = self;
            //设置音乐播放器的次数
            _avAudioPlayer.numberOfLoops = 0;
            [_avAudioPlayer prepareToPlay];
            NSUserDefaults *default_sounds = [NSUserDefaults standardUserDefaults];
            NSString *sounds = [default_sounds objectForKey:@"open"];
            BOOL iscan = [[ NSUserDefaults standardUserDefaults ] boolForKey:@"lights" ];
            if(iscan){
                [_avAudioPlayer stop];
                _avAudioPlayer = nil;
            }else{
                [_avAudioPlayer play];
            }
            [JPUSHService handleRemoteNotification:userInfo];
            completionHandler(UIBackgroundFetchResultNewData);
            //这里是自定义的前台弹出框
            [JKNotifier showNotifer:[NSString stringWithFormat:@"%@",alert]];
            [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
                [notifier dismiss];
                NSLog(@"AutoHidden JKNotifierBar clicked");
            }];
            //加了个本地通知
            UILocalNotification *notification=[[UILocalNotification alloc] init];
            if (notification!=nil) {
                NSDate *now=[NSDate date];
                notification.fireDate=[now dateByAddingTimeInterval:1];
                notification.timeZone=[NSTimeZone defaultTimeZone];
                notification.alertBody = alert;
                NSLog(@" 您接收到的消息是:%@",alert);
                notification.soundName = sounds;
                [notification setApplicationIconBadgeNumber:1];
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                [JKNotifier showNotifer:[NSString stringWithFormat:@"%@",alert]];
            }
            NSLog(@"本地通知1秒后触发");
        }
        //后台
        if(application.applicationState == UIApplicationStateInactive){
            NSLog(@" 后台");
            self.isIntave = NO;
            
            [JPUSHService handleRemoteNotification:userInfo];
            completionHandler(UIBackgroundFetchResultNewData);
            [self goToMssageView];
        }
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"chickViewAndRefreshOrder" object:nil userInfo:@{@"tag": @"0"}];
}

#pragma mark --- 跳转的页面
-(void)goToMssageView{
    /* 这里是order的跳转页面 */
    if([self.pushtype isEqualToString:@"order"]){
        if([self.type isEqualToString:@"0"]){
//            TCOrderViewController *myCheckVC = [[TCOrderViewController alloc]init];
//            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:myCheckVC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
//            [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
            self.window.rootViewController.navigationController.tabBarController.selectedIndex = 0;
        }
    }
    /*  库存量  */
    if ([self.pushtype isEqualToString:@"purchase"]) {
        self.window.rootViewController.navigationController.tabBarController.selectedIndex = 2;
    }
}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    if(application.applicationState == UIApplicationStateActive){
        return;
    }
    if(application.applicationState == UIApplicationStateInactive){
        [application setApplicationIconBadgeNumber:0];
        [self goToMssageView];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}
//友盟统计数据
- (void)umengTrack {
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = UMengKey;
    UMConfigInstance.secret = @"secretstringaldfkals";
    UMConfigInstance.channelId = @"Shundaojiashangjiaban";//此处为渠道名
    // UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
}
//百度统计数据
-(void)baiduTongJi
{
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"6faa0b942d"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

@end
