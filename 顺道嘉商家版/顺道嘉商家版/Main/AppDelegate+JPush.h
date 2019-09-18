//
//  AppDelegate+JPush.h
//  顺道嘉商家版
//
//  Created by 胡高广 on 2018/8/13.
//  Copyright © 2018年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate (JPush)<AVAudioPlayerDelegate>
- (void)configureJPushWithOptions:(NSDictionary *)launchOptions;
@property (nonatomic, strong) AVAudioPlayer *avAudioPlayer;
@property (nonatomic, strong) NSString *string ;//声音字段
@end
