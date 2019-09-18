//
//  TCNetworking.m
//  顺道嘉商家版
//
//  Created by GeYang on 2016/12/5.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCNetworking.h"
#import "AFNetworking.h"
#import "DeleteNull.h"
#import "TCLoginViewController.h"
#import "UIApplication+GYApplication.h"

@implementation TCNetworking



+ (void)postWithTcUrlString:(NSString *)urlString paramter:(id)paramter success:(void (^)(NSString *, NSDictionary *))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [[[[[jsonStr
                            stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\r\\n"]
                           stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]
                          stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"]
                         stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"]
                        dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONWritingPrettyPrinted | NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
        if (success) {
            success(jsonStr, [DeleteNull changeType:jsonDic]);
            
            //登录超时
            NSString *codeStr = [NSString stringWithFormat:@"%@",jsonDic[@"code"]];
            if ([codeStr isEqualToString:@"-5"]){
                TCLoginViewController *loginVC = [[TCLoginViewController alloc] init];
                UINavigationController *navi = [[UIApplication sharedApplication] visibleNavigationController];
                [navi presentViewController:loginVC animated:YES completion:nil];
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
